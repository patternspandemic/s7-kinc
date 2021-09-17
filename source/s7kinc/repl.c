#include "repl.h"


static kinc_socket_t server, client; // server and current client sockets
static unsigned client_addr = 0, client_port = 0; // current client address and port
static bool client_connected = false; // whether a client is connected
static const char initial_prompt[] = "Welcome to Kinc\n> "; // initial prompt to send to client
static sds input_buffer; // a buffer to hold client input until a valid form is received
static sds wrapped; // a buffer that wraps input_buffer to attempt evaluation


static void clear_input_buffer(void) {
  input_buffer[0] = '\0';
  sdsupdatelen(input_buffer);
}

static void handle_client_input(const char *str) {
  input_buffer = sdscat(input_buffer, str); // append to prev input not eval'd
  wrapped[0] = '\0'; sdsupdatelen(wrapped); // truncate the wrapping buffer
  wrapped = sdscatprintf(wrapped, "(begin %s)", input_buffer); // wrap the current input_buffer

  int gc_loc_err, gc_loc_out;
  gc_loc_err = gc_loc_out = -1;

  /* Attempt to read the wrapped input to see if its a valid form. */
  s7_pointer form_port = s7_open_input_string(sc, wrapped);
  s7_pointer err = s7_open_output_string(sc);
  s7_pointer err_prev = s7_set_current_error_port(sc, err);
  gc_loc_err = s7_gc_protect(sc, err_prev);
  s7_pointer form = s7_read(sc, form_port); // outputs to err when not valid
  s7_close_input_port(sc, form_port);
  const char *err_msg = s7_get_output_string(sc, err);

  /* If there was err output, form is invalid. */
  if((err_msg) && (*err_msg)) {
    s7_set_current_error_port(sc, err_prev); // restore prev error port
    s7_close_output_port(sc, err);
    if(gc_loc_err != -1) {
      s7_gc_unprotect_at(sc, gc_loc_err);
      gc_loc_err  = -1;
    }
    return; // invalid form
  } else {
    clear_input_buffer(); // so we don't reevaluate what we're about to evaluate

    /* Evaluate the form ... */

    /*     Capture out */
    s7_pointer out = s7_open_output_string(sc);
    s7_pointer out_prev = s7_set_current_output_port(sc, out);
    gc_loc_out = s7_gc_protect(sc, out_prev);

    /*     Capture err
     *     - `err` port still set from form read above. */

    /*     Evaluation! */
    s7_pointer eval_result = s7_eval(sc, form, s7_nil(sc));
    char *eval_result_str = s7_object_to_c_string(sc, eval_result); // free this!
    const char *out_msg = s7_get_output_string(sc, out); // When form writes to current out port.
    err_msg = s7_get_output_string(sc, err); // When the form errors.

    /*     Client reply */
    sds reply;
    if ((err_msg) && (*err_msg)) {
      reply = sdscatprintf(sdsempty(), "%s> ", err_msg);
    } else {
      reply = sdscatprintf(sdsempty(), "%s%s\n\n> ", out_msg, eval_result_str); // output before result before prompt
    }
    kinc_socket_send_connected(&client, reply, sdslen(reply)); // send the reply

    /*     Port cleanup */
    s7_set_current_output_port(sc, out_prev);
    s7_close_output_port(sc, out);
    if(gc_loc_out != -1) {
      s7_gc_unprotect_at(sc, gc_loc_out);
      gc_loc_out  = -1;
    }
    s7_set_current_error_port(sc, err_prev);
    s7_close_output_port(sc, err);
    if(gc_loc_err != -1) {
      s7_gc_unprotect_at(sc, gc_loc_err);
      gc_loc_err  = -1;
    }

    /* String cleanup */
    free(eval_result_str);
    sdsfree(reply);
  }
}

void s7kinc_repl_listen(void) {
  // Client Connect
  if(!client_connected) {
    client_connected = kinc_socket_accept(&server, &client, &client_addr, &client_port);
    if(client_connected) {
      kinc_log(KINC_LOG_LEVEL_INFO, "Client connected.");
      kinc_socket_send_connected(&client, initial_prompt, strlen(initial_prompt));
    }
  }
  // Client Input
  if(client_connected) {
    char buffer[REPL_BUFFER_SIZE];
    int count_recv = 0;
    count_recv = kinc_socket_receive_connected(&client, buffer, REPL_BUFFER_SIZE - 1);
    if (count_recv > 0) {
      buffer[count_recv] = 0; // terminate what was received
      handle_client_input(buffer);
    } else {
      kinc_log(KINC_LOG_LEVEL_INFO, "Client disconnected.");
      clear_input_buffer();
      kinc_socket_destroy(&client);
      client_connected = false;
    }
  }
}

void s7kinc_repl_init(void) {
  /* Initialize some buffers. */
  input_buffer = sdsempty();
  wrapped = sdsempty();

  /* Initialize server and client sockets. */
  kinc_log(KINC_LOG_LEVEL_INFO, "Setting up REPL server,");
  kinc_socket_options_t server_opts;
  kinc_socket_options_set_defaults(&server_opts);
  kinc_socket_init(&server);
  kinc_socket_init(&client);

  /* Open server socket and listen. */
  kinc_affirm_message(
    kinc_socket_open(&server, KINC_SOCKET_PROTOCOL_TCP, REPL_BUFFER_PORT, &server_opts),
    "    ! Could not open server socket.\n");
  kinc_affirm_message(
    kinc_socket_listen(&server, 1),
    "    ! Could not listen on server socket.\n");
  kinc_log(KINC_LOG_LEVEL_INFO, "    > awaiting connection.\n");
}

void s7kinc_repl_cleanup(void) {
  kinc_socket_destroy(&client);
  kinc_socket_destroy(&server);
  sdsfree(input_buffer);
}
