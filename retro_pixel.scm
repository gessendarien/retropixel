; RetroPixel - GIMP Script-Fu Plugin for PS1/N64 Style Pixelation
; Creates retro low-resolution texture effects for 3D objects
; License: GNU GPL v3
; GitHub: https://github.com/gessendarien/retropixel

(define (script-fu-retro-pixel img
                                drw
                                preset
                                pix-size
                                col-depth
                                tgt-width
                                tgt-height
                                dither-type
                                color-filter)
  
  (let* ((orig-w (car (gimp-image-get-width img)))
         (orig-h (car (gimp-image-get-height img)))
         (new-w 0)
         (new-h 0)
         (final-w orig-w)
         (final-h orig-h)
         (num-colors 32)
         (color-layer 0))
    
    (gimp-image-undo-group-start img)
    
    ; Apply preset
    (cond
      ((= preset 1)  ; PS1 Low-Res
       (set! pix-size 12)
       (set! num-colors 16)
       (set! tgt-width 128)
       (set! tgt-height 128))
      ((= preset 2)  ; PS1 Medium
       (set! pix-size 8)
       (set! num-colors 32)
       (set! tgt-width 256)
       (set! tgt-height 256))
      ((= preset 3)  ; N64 Style
       (set! pix-size 6)
       (set! num-colors 64)
       (set! tgt-width 256)
       (set! tgt-height 256))
      ((= preset 4)  ; Extreme Retro
       (set! pix-size 16)
       (set! num-colors 8)
       (set! tgt-width 64)
       (set! tgt-height 64))
      (else  ; Custom - use manual values
       (set! num-colors col-depth)))
    
    ; Calculate dimensions
    (if (and (> tgt-width 0) (> tgt-height 0))
        (begin
          (set! new-w (min tgt-width orig-w))
          (set! new-h (min tgt-height orig-h))
          (set! final-w new-w)
          (set! final-h new-h))
        (begin
          (set! new-w (max 1 (floor (/ orig-w pix-size))))
          (set! new-h (max 1 (floor (/ orig-h pix-size))))
          (set! final-w orig-w)
          (set! final-h orig-h)))
    
    ; Scale down with NO interpolation
    (gimp-context-push)
    (gimp-context-set-interpolation INTERPOLATION-NONE)
    (gimp-image-scale img new-w new-h)
    
    ; Convert to indexed with dithering for retro look
    (gimp-image-convert-indexed img 
                                dither-type
                                0
                                (max 2 (min 256 num-colors))
                                FALSE FALSE "")
    
    ; Convert back to RGB
    (gimp-image-convert-rgb img)
    
    ; Apply color filter (simple color balance method)
    (when (> color-filter 0)
      ; Set foreground color based on filter choice
      (cond
        ((= color-filter 1)  ; Red
         (gimp-context-set-foreground '(255 0 0)))
        ((= color-filter 2)  ; Orange
         (gimp-context-set-foreground '(255 140 0)))
        ((= color-filter 3)  ; Yellow
         (gimp-context-set-foreground '(255 220 0)))
        ((= color-filter 4)  ; Green
         (gimp-context-set-foreground '(0 255 80)))
        ((= color-filter 5)  ; Blue
         (gimp-context-set-foreground '(0 100 255)))
        ((= color-filter 6)  ; Purple
         (gimp-context-set-foreground '(180 0 255)))
        ((= color-filter 7)  ; Pink
         (gimp-context-set-foreground '(255 80 180)))
        ((= color-filter 8)  ; Brown
         (gimp-context-set-foreground '(150 90 40)))
        ((= color-filter 9)  ; White
         (gimp-context-set-foreground '(255 255 255)))
        ((= color-filter 10) ; Black
         (gimp-context-set-foreground '(0 0 0))))
      
      ; Create new layer for color overlay
      (let ((overlay-layer (car (gimp-layer-copy drw TRUE))))
        (gimp-image-insert-layer img overlay-layer 0 0)
        (gimp-layer-set-mode overlay-layer LAYER-MODE-OVERLAY)
        (gimp-layer-set-opacity overlay-layer 50)
        (gimp-drawable-fill overlay-layer FILL-FOREGROUND)
        (gimp-image-merge-down img overlay-layer EXPAND-AS-NECESSARY)))
    
    ; Scale back up with NO interpolation
    (gimp-image-scale img final-w final-h)
    (gimp-context-pop)
    
    (gimp-displays-flush)
    (gimp-image-undo-group-end img)))

; Register
(script-fu-register "script-fu-retro-pixel"
  "RetroPixel"
  "Apply PS1/N64 style pixelation with dithering and color filters. NOTE: When using Presets, the Pixel Size/Colors/Target values below are ignored. Choose 'Custom' to use manual settings."
  "RetroPixel"
  "GNU GPL v3"
  "2025"
  "RGB* GRAY*"
  SF-IMAGE "Image" 0
  SF-DRAWABLE "Drawable" 0
  SF-OPTION "Preset" '("Custom (use values below)" "PS1 Low-Res (128x128, 16 colors)" "PS1 Medium (256x256, 32 colors)" "N64 Style (256x256, 64 colors)" "Extreme Retro (64x64, 8 colors)")
  SF-ADJUSTMENT "Pixel Size (Custom only)" '(8 2 32 1 2 0 0)
  SF-ADJUSTMENT "Number of Colors (Custom only)" '(32 4 256 1 8 0 0)
  SF-ADJUSTMENT "Target Width - 0=keep (Custom only)" '(0 0 4096 1 64 0 0)
  SF-ADJUSTMENT "Target Height - 0=keep (Custom only)" '(0 0 4096 1 64 0 0)
  SF-OPTION "Dithering Pattern" '("None (Solid)" "Floyd-Steinberg (Best)" "Positioned (Retro)")
  SF-OPTION "Color Filter (Retro Palette)" '("None" "Red" "Orange" "Yellow" "Green" "Blue" "Purple" "Pink" "Brown/Sepia" "White" "Black"))

(script-fu-menu-register "script-fu-retro-pixel" "<Image>/Filters/Blur")
