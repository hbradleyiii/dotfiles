# dotfiles
My personal dotfile repository

## Installation

```bash
$ git clone git@github.com:hbradleyiii/dotfiles.git ~/.dotfiles
$ ~/.dotfiles/install
```

## Site Watch Script
Site watch is web development script for that can be used to tell your browser
to reload a webpage whenever a change has been made to a php, html, css, or
other website file.

It watches a website directory for modifications and updates a file called
'.site-watch' in the root directory (the root that is being watched, which does
not have to be the root of the website). The file's first line is the timestamp
of the modification, and the second line is the file modified. The file
'.site-watch' is removed when the script is closed.

Settings can be modified by creating a bash file named 'site-watch.config' that
is in the root directory. This file can be used to modify the following bash
variables:

```bash
$WATCH_DIR # the directory to watch
$WATCH_FILE # the file to update with changes
$FILE_TYPES # the file extensions to watch
```

If a site-watch.config file cannot be found in a parent directory
(recursively), the $WATCH_DIR is assumed to be the current directory.

The website must source a javascript snippet such as this one (requires
jQuery):
```javascript
<script type='text/javascript'>
    jQuery( function ($) {
        var last_update = 0;
        var start_time = Date.now();
        function init( response ) {
            last_update = get_update_time( response );
            process = process_watch;
            process_watch ( response );
            console.log( 'Watching for updates...' );
        }
        function process_watch( response ) {
            if ( last_update < get_update_time( response ) ) {
                console.log( 'Reloading to updated page...' );
                location.reload();
            } else if ( Date.now() < start_time + 3600000 ) {
                setTimeout( check_watch, 800 );
            } else {
                console.warn( 'No changes for over an hour. No longer watching.' )
                console.warn( 'Please refresh the page to continue watching for changes.' )
            }
        }
        function check_watch() {
            $.ajax({
                url: '<?php echo get_template_directory_uri() . '/.site-watch'; ?>',
                success: process,
                error: function () { console.warn( 'Site Watch is not running! Set up site-watch on server and reload the page.' ); }
            });
        }
        function get_update_time( response ) {
            return parseInt( response.split( '\n' ) );
        }
        var process = init;
        check_watch();
    });
</script>
```

It is also nice to serve this file only when debugging. You can check for the
XDEBUG_SESSION cooking and only load the javascript when it is present (using
php):
```php
if ( isset($_COOKIE['XDEBUG_SESSION']) ) {
    // ...
}
```

## Containing Files

- .bash_lib/ - Contains various bash scripts
  - colors
  - colors_ext
  - compass-watch
  - dirtest
  - env
  - env.conf
  - env.help
  - gen-update
  - log
  - msg
  - sass-watch
  - site-watch
  - symtest
  - tmux-sass-watch
  - tmux-site-watch
  - wp ( wp-cli see: http://wp-cli.org/ )

- hooks/
  - post-checkout
  - post-merge

- install
- .bash_logout
- .bash_profile
- .bashrc
- .config
- .ctags
- .emacs
- .fonts.conf
- .gitconfig
- .gitignore
- .gitignore_default
- .inputrc
- .muttrc
- .pythonrc.py
- .selected_editor
- .stignore
- .tmux.conf
- .vim
- .vimrc
- .xinitrc
- .Xmodmap
- .Xresources
