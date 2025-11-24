#pragma once

/* =========================
 * Theme selector
 * ========================= */

#define THEME_GRUVBOX    1
#define THEME_NORD       2
#define THEME_NORD_DARK  3

/* Pick your theme here */
#define ACTIVE_THEME THEME_NORD_DARK
/* #define ACTIVE_THEME THEME_NORD */
/* #define ACTIVE_THEME THEME_GRUVBOX */


/* =========================
 * Shared colors for dwm + slstatus
 * ========================= */

#if ACTIVE_THEME == THEME_GRUVBOX
    /* Gruvbox dark hard-ish */
    #define COL_BG        "#282828"
    #define COL_BG_ALT    "#3c3836"
    #define COL_FG        "#ebdbb2"
    #define COL_FG_DIM    "#d5c4a1"
    #define COL_BORDER    "#504945"
    #define COL_ACCENT    "#d79921"  /* yellow/orange */
    #define COL_ACCENT_ALT "#83a598" /* blue */

#elif ACTIVE_THEME == THEME_NORD
    /* Nord */
    #define COL_BG        "#2E3440"
    #define COL_BG_ALT    "#3B4252"
    #define COL_FG        "#ECEFF4"
    #define COL_FG_DIM    "#D8DEE9"
    #define COL_BORDER    "#4C566A"
    #define COL_ACCENT    "#88C0D0"
    #define COL_ACCENT_ALT "#A3BE8C"

#elif ACTIVE_THEME == THEME_NORD_DARK
    /* Nord – darker custom */
    #define COL_BG        "#1E2330"
    #define COL_BG_ALT    "#1E2330"
    #define COL_FG        "#D8DEE9"
    #define COL_FG_DIM    "#AEB6C1"
    #define COL_BORDER    "#2C3240"
    #define COL_ACCENT    "#4C566A"
    #define COL_ACCENT_ALT "#5E81AC"

#endif


/* =========================
 * st ANSI colors per theme
 * ========================= */
/* 0–15 are the ANSI colors used by apps, ST_BG/ST_FG used as defaults */

#if ACTIVE_THEME == THEME_GRUVBOX
    #define ST_C0  "#282828"
    #define ST_C1  "#cc241d"
    #define ST_C2  "#98971a"
    #define ST_C3  "#d79921"
    #define ST_C4  "#458588"
    #define ST_C5  "#b16286"
    #define ST_C6  "#689d6a"
    #define ST_C7  "#a89984"
    #define ST_C8  "#928374"
    #define ST_C9  "#fb4934"
    #define ST_C10 "#b8bb26"
    #define ST_C11 "#fabd2f"
    #define ST_C12 "#83a598"
    #define ST_C13 "#d3869b"
    #define ST_C14 "#8ec07c"
    #define ST_C15 "#ebdbb2"
    #define ST_BG  ST_C0     /* background */
    #define ST_FG  ST_C15    /* foreground */

#elif ACTIVE_THEME == THEME_NORD
    #define ST_C0  "#3B4252"
    #define ST_C1  "#BF616A"
    #define ST_C2  "#A3BE8C"
    #define ST_C3  "#EBCB8B"
    #define ST_C4  "#81A1C1"
    #define ST_C5  "#B48EAD"
    #define ST_C6  "#88C0D0"
    #define ST_C7  "#E5E9F0"
    #define ST_C8  "#4C566A"
    #define ST_C9  "#BF616A"
    #define ST_C10 "#A3BE8C"
    #define ST_C11 "#EBCB8B"
    #define ST_C12 "#81A1C1"
    #define ST_C13 "#B48EAD"
    #define ST_C14 "#8FBCBB"
    #define ST_C15 "#ECEFF4"
    #define ST_BG  "#2E3440"
    #define ST_FG  "#D8DEE9"

#elif ACTIVE_THEME == THEME_NORD_DARK
    #define ST_C0  "#1E2330"
    #define ST_C1  "#BF616A"
    #define ST_C2  "#A3BE8C"
    #define ST_C3  "#EBCB8B"
    #define ST_C4  "#5E81AC"
    #define ST_C5  "#B48EAD"
    #define ST_C6  "#88C0D0"
    #define ST_C7  "#D8DEE9"
    #define ST_C8  "#2C3240"
    #define ST_C9  "#BF616A"
    #define ST_C10 "#A3BE8C"
    #define ST_C11 "#EBCB8B"
    #define ST_C12 "#5E81AC"
    #define ST_C13 "#B48EAD"
    #define ST_C14 "#8FBCBB"
    #define ST_C15 "#ECEFF4"
    #define ST_BG  "#1E2330"
    #define ST_FG  "#D8DEE9"

#endif

