;;; TODO: system.scm
;;;
;;; kinc/system.h

(provide 'kinc/system)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc system
    :c-info '(
                        (char* kinc_application_name (void))
                         (void kinc_set_application_name (char*))
                          (int kinc_width (void))
                          (int kinc_height (void))
                         (void kinc_load_url (char*))
                        (char* kinc_system_id (void))
                        (char* kinc_language (void))
                         (void kinc_vibrate (int))
                        (float kinc_safe_zone (void))
                         (bool kinc_automatic_safe_zone (void))
                         (void kinc_set_safe_zone (float))
                       (double kinc_frequency (void))
      ;((kinc_ticks_t uint64_t) kinc_timestamp (void)) ; FIXME: return is stored in int64_t, needs to be uint64, so a bignum?
                       (double kinc_time (void))
                         (void kinc_start (void))
                         (void kinc_stop (void))
                         (void kinc_login (void))
                         (bool kinc_waiting_for_login (void))
                         (void kinc_unlock_achievement (int))
                         (void kinc_disallow_user_change (void))
                         (void kinc_allow_user_change (void))
                         (void kinc_set_keep_screen_on (bool))
                         (void kinc_copy_to_clipboard (char*))

      ;; NOTE: Various callbacks from system.h are set in core.c to allow scheme side hooks.

      ;; TODO: Special functions
      ;(int kinc_init (char* int int kinc_window_options_t* kinc_framebuffer_options_t*))
    )
  )

(curlet))
