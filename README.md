# Local Setup & Configurations

A summary of my setup and dotfiles.

Dotfiles are stored/installed following this [guide](https://www.atlassian.com/git/tutorials/dotfiles)

## Terminal Setup

### Shell

[zshell](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH)  
Plugin framework: [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh)  
Plugins:

* [zsh-autosuggestion](https://github.com/zsh-users/zsh-autosuggestions) (fish style)
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) (fish style)
* [autoupdate](https://github.com/TamCore/autoupdate-oh-my-zsh-plugins)
* theme: [powerlevel10k](https://github.com/romkatv/powerlevel10k?fbclid=IwAR0xEmjJLjOCjxB75KiU6Ab-2ehSDVXacIm6suddTm6Q_5_t7bD-XjS4o14)

### tmux

* Customising tmux [guide](https://hackernoon.com/customizing-tmux-b3d2a5050207)
* Plugin manager: [tpm](https://github.com/tmux-plugins/tpm)

### Text Editors

Vim

* Using `vim-gnome` for `clipboard` support
* Colour scheme: [Oceanic-Next](https://github.com/hillaryychan/oceanic-next)
* Plugin manager: [vim-plug](https://github.com/junegunn/vim-plug)

[Visual Studio Code](https://code.visualstudio.com/)

* [Keyboard shortcuts](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf)
* [Extensions](https://github.com/hillaryychan/dotfiles/blob/master/.vscode/extensions_list)

### File Explorer

[ranger](https://github.com/ranger/ranger)

* syntax highlighting: [highlight](http://www.andre-simon.de/doku/highlight/en/highlight.php)
* [image previews](https://github.com/ranger/ranger/wiki/Image-Previews)
  * `w3m-img` for image previews

## Desktop Setup

OS: Ubuntu 18.04.4 LTS  
Desktop Environment: GNOME3  
Window Manager: GNOME Shell  
Terminal: xfce4-terminal

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

| Shortcut Keys     | Description                       |
| :---:             | ---                               |
| `super-a`         | Open app menu                     |
| `super-d`         | Hide all windows                  |
| `super-l`         | Lock screen                       |
| `super-space`     | Switch keyboard                   |
| `super-tab`       | Switch applications               |
| `alt-tab`         | Switch windows                    |
| `ctrl-alt-down`   | Move to workspace below           |
| `ctrl-alt-up`     | Move to workspace above           |
| `ctrl-alt-pgdn`   | Move window to workspace below    |
| `ctrl-alt-pgup`   | Move window to workspace above    |

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
