;;; TODO: window.scm
;;;
;;; kinc/window.h

(provide 'kinc/window)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc window
    :ctypes '((kinc_framebuffer_options_t
               (int frequency)
               (bool vertical_sync)
               (int color_bits)
               (int depth_bits)
               (int stencil_bits)
               (int samples_per_pixel))

              (kinc_window_options_t
               ((symbol "const char*") title)
               (int x)
               (int y)
               (int width)
               (int height)
               (int display_index)
               (bool visible)
               (int window_features)
               (kinc_window_mode_t mode)))

    :c-info '(
      (C-macro (int (KINC_WINDOW_FEATURE_RESIZEABLE
                     KINC_WINDOW_FEATURE_MINIMIZABLE
                     KINC_WINDOW_FEATURE_MAXIMIZABLE
                     KINC_WINDOW_FEATURE_BORDERLESS
                     KINC_WINDOW_FEATURE_ON_TOP)))

      (int (KINC_WINDOW_MODE_WINDOW
            KINC_WINDOW_MODE_FULLSCREEN
            KINC_WINDOW_MODE_EXCLUSIVE_FULLSCREEN))

      ;; TODO: Special functions
      ;(void kinc_window_options_set_defaults (kinc_window_options_t*))
      ;(void kinc_framebuffer_options_set_defaults (kinc_framebuffer_options_t*))
      ;(int kinc_window_create (kinc_window_options_t* kinc_framebuffer_options_t*))
      ;(void kinc_window_change_framebuffer (int kinc_framebuffer_options_t*))

      (void kinc_window_destroy (int))
      (int kinc_count_windows (void))
      (void kinc_window_resize (int int int))
      (void kinc_window_move (int int int))
      (void kinc_window_change_mode (int (kinc_window_mode_t int)))
      (void kinc_window_change_features (int int))
      (int kinc_window_x (int))
      (int kinc_window_y (int))
      (int kinc_window_width (int))
      (int kinc_window_height (int))
      (int kinc_window_display (int))
      ((kinc_window_mode_t int) kinc_window_get_mode (int))
      (void kinc_window_show (int))
      (void kinc_window_hide (int))
      (void kinc_window_set_title (int char*))
      ;; NOTE: Basic hooks for these callbacks are set in core.c
      ;(void kinc_window_set_resize_callback (int window, void(*callback)(int x, int y, void *data), void *data))
      ;(void kinc_window_set_ppi_changed_callback (int window, void(*callback)(int ppi, void *data), void *data)) ; NOTE: Backend Not Implemented
      (bool kinc_window_vsynced (int))
    )
  )

(curlet))
