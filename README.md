# Local Setup & Configurations

A summary of my setup and dotfiles.

Dotfiles are stored/installed following this [guide](https://www.atlassian.com/git/tutorials/dotfiles)

## Terminal Setup

### Shell

[zshell](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH)

* [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)
* [zsh-autosuggestion](https://github.com/zsh-users/zsh-autosuggestions) (fish style)
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) (fish style)
* prompt: modifed [ys-theme](https://github.com/hillaryychan/dotfiles/blob/master/.oh-my-zsh/themes/ys.zsh-theme)

### tmux

* Customising tmux [guide](https://hackernoon.com/customizing-tmux-b3d2a5050207)

### Text Editors

Vim

* [Command Cheat Sheet](https://vim.rtorr.com/)
* [Keyboard Cheat Sheet](https://github.com/CallumHoward/cli-tools/blob/master/vimcheatsheet.pdf)
* colorscheme: modified [Oceanic-Next](https://github.com/hillaryychan/dotfiles/blob/master/.vim/bundle/oceanic-next/colors/OceanicNext.vim)

[Visual Studio Code](https://code.visualstudio.com/)

* [Keyboard shortcuts](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf)
* [Extensions](https://github.com/hillaryychan/dotfiles/blob/master/.vscode/extensions_list)

### File Explorer

[ranger](https://github.com/ranger/ranger)

* syntax highlighting: [highlight](http://www.andre-simon.de/doku/highlight/en/highlight.php)
* [image previews](https://github.com/ranger/ranger/wiki/Image-Previews)
  * ~~w3m-img~~ - inline image previews not available on gnome-terminal so using ASCII art :(
  * caca-utils - for ASCII art

### Source Control

git

## Desktop Setup

### Themes

|               | Theme                                     |
| ---           | ---                                       |
| Applications  | Arc-Sun-Darker\*                          |
| Cursor        | DMZ-White                                 |
| Icons         | [Pop](https://github.com/pop-os/gtk-theme)|
| Shell         | Arc-Sun\*                                 |

\* Arc-Sun is the [Arc Theme](https://github.com/horst3180/arc-theme) with accent colours modified to #FBB41A using [Arc-Theme-Colora](https://github.com/erikdubois/Arc-Theme-Colora)

### Keyboard Shortcuts

Some keyboard shortcuts I often use:

Launchers

| Shortcut Keys | Description               |
| :---:         | ---                       |
| `ctrl-alt-t`  | Open terminal             |
| `ctrl-alt-b`  | Open default web browser  |
| `ctrl-alt-v`  | Open vscode               |
| `ctrl-alt-s`  | Open settings             |
| `super-e`     | Open file explorer        |

Navigation

| Shortcut Keys | Description           |
| :---:         | ---                   |
| `super-a`     | Open app menu         |
| `super-d`     | Hide all windows      |
| `super-l`     | Lock scren            |
| `super-space` | Switch keyboard       |
| `super-tab`   | Switch applications   |
| `alt-tab`     | Switch windows        |

Screenshots

| Shortcut Keys         | Description               |
| :---:                 | ---                       |
| `shift-ctrl-print`    | Copy screenshot of area   |
| `ctrl-alt-print`      | Copy screenshot of window |
| `ctrl-print`          | Copy screenshot           |
| `shift-print`         | Save screenshot of area   |
| `alt-print`           | Save screenshot of window |
| `print`               | Save screenshot           |
| `shift-ctrl-alt-r`    | Record a short screencast |
