Powify
======

Powify is a management tool for [Pow](http://pow.cx/) by 37 signals. It allows you to easily install, update, and manage pow and pow applications seamlessly. To get started, read the installation section below.


Installation
------------
Install powify using the `gem` command:

    gem install powify

Important Notes
---------------
Powify assumes that your current working directory has the same basename as Pow app. For example, if my site was in:

    /Users/sethvargo/Development/my_site

Powify would expect the name of the Pow app to also be `my_site` (the name of the symlink). This is the default behavior if you just use the command `powify create`. However, it's feasible that you would want a different name that the folder. If this is the case, you'll always need to specify the name of the application like this:

    powify restart foo
    powify destroy foo
    powify move foo new_foo


### FAQ
Q: But Seth, why don't you just search the `~/.pow` directory and grab the symlink that points to the current directory?

A: Because it's inefficient and it could cause a problem if the same Pow apps are symlinked multiple times under different names, Powify could accidentally perform an operation on the wrong one.


Q: Why don't you just add a hidden file to the project directory when someone creates the app, then you'll know what the symlinked is named.

A: What happens when the same app is symlinked multiple times under a different name? I also hate when applications create files randomly on my hard drive.

Usage
-----
```bash
SERVER COMMANDS
  powify server install            install pow server
  powify server reinstall          reinstall pow server
  powify server update             update pow server
  powify server uninstall          uninstall pow server
  powify server list               list all pow apps
  powify server start              start the pow server
  powify server stop               stop the pow server
  powify server restart            restart the pow server
  powify server host               adds all pow apps to /etc/hosts file
  powify server unhost             removes all pow apps from /etc/hosts file
  powify server status             print the current server status
  powify server config             print the current server configuration
  powify server logs               tails the pow server logs

UTILS COMMANDS
  powify utils install             install powify.dev server management tool
  powify utils reinstall           reinstall powify.dev server management tool
  powify utils uninstall           uninstall powify.dev server management tool

APP COMMANDS
  powify create [NAME]             creates a pow app from the current directory
  powify destroy [NAME]            destroys the pow app linked to the current directory
  powify restart [NAME]            restarts the pow app linked to the current directory
  powify always_restart [NAME]     reload the pow app after each request
  powify always_restart_off [NAME] do not reload the pow app after each request
  powify rename [NAME]             rename the pow app to [NAME]
  powify rename [OLD] [NEW]        rename the pow app [OLD] to [NEW]
  powify environment [ENV]         run the this pow app in a different environment (aliased `env`)
  powify browse [NAME]             opens and navigates the default browser to this app
  powify xip [NAME]                opens and navigates the default browser to this app on xip.io
  powify logs [NAME]               tail the application logs
```

Important Notes
---------------
The server commands for `start` and `stop` **only** stop the Pow process. They do not modify the existing firewall rules. If you need to disable the firewall rules, please `uninstall` and `install` to re-activate.

Contribution
------------
- 9/2 [@lindblom](https://github.com/lindblom) - author of `host` and `unhost`
- 10/29 [@warwickp](https://github.com/warwickp) - wrote `always_restart_off`

If you would like to contribute, fork and send me a pull request.
