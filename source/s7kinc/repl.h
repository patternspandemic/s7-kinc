#ifndef S7KINC_REPL_H_
#define S7KINC_REPL_H_


#include <stdlib.h>
#include <string.h>

#include <kinc/error.h>
#include <kinc/log.h>
#include <kinc/network/socket.h>

#include "../lib/s7/s7.h"
#include "../lib/sds/sds.h" // Simple Dynamic Strings


#define REPL_BUFFER_SIZE 512
#define REPL_BUFFER_PORT 1337

extern s7_scheme *sc;

static kinc_socket_t server, client; // server and current client sockets
static unsigned client_addr = 0, client_port = 0; // current client address and port
static bool client_connected = false; // whether a client is connected
static const char initial_prompt[] = "Welcome to Kinc\n> "; // initial prompt to send to client
static sds input_buffer; // a buffer to hold client input until a valid form is received
static sds wrapped; // a buffer that wraps input_buffer to attempt evaluation


static void clear_input_buffer(void);
static void handle_client_input(const char *str);

void s7kinc_repl_listen(void);
void s7kinc_repl_init(void);
void s7kinc_repl_cleanup(void);


#endif // S7KINC_REPL_H_
