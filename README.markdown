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
    $ powify server install
    => install pow server

&nbsp;

    $ powify server reinstall
    => reinstall pow server

&nbsp;

    $ powify server update
    => update pow server

&nbsp;

    $ powify server uninstall
    => uninstall pow server

&nbsp;

    $ powify server list
    => list all apps on this pow server

&nbsp;

    $ powify server start
    => start the pow server

&nbsp;

    $ powify server stop
    => stop the pow server

&nbsp;

    $ powify server restart
    => restart the pow server

&nbsp;

    $ powify server status
    => print the current status of the server

&nbsp;

    $ powify server config
    => print the current configuration of the server

&nbsp;

    $ powify server logs
    => tail the pow server logs

&nbsp;

    $ powify create
    => create a pow app with the same name as the current directory

&nbsp;

    $ powify create foo
    => create a pow app named `foo` served from the current directory

&nbsp;

    $ powify destroy
    => destroy the pow app served from the current directory

&nbsp;

    $ powify destroy foo
    => destroy the pow app named `foo`

&nbsp;

    $ powify restart
    => restart the app served from the current directory

&nbsp;

    $ powify always_restart
    => tell pow to always reload the framework on each request

&nbsp;

    $ powify always_restart foo
    => tell pow to always reload the framework on each request to the pow app named `foo`

&nbsp;

    $ powify restart foo
    => restart the pow app named `foo`

&nbsp;

    $ powify browse
    => open the default browser and navigate to this app

&nbsp;

    $ powify browse foo
    => open the default browser and navigate to the app named `foo`

&nbsp;

    $ powify browse foo test
    => open the default browser and navigate to the app named `foo` resolved on test (http://foo.test)

&nbsp;

    $ powify logs
    => tail the app logs for the app served from this directory
    
&nbsp;

    $ powify logs foo
    => tail the app logs for the app named `foo`

&nbsp;

    $ powify rename foo
    => rename the pow app in the current directory to `foo`

&nbsp;

    $ powify rename foo bar
    => rename the pow app named `foo` to `bar`

&nbsp;

    $ powify environment production
    => run the current pow app in production

&nbsp;

    $ powify env staging
    => run the current pow app in staging

&nbsp;

    $ powify help
    => list pow commands


Contribution
------------
- 6/9 [@hayesr](https://github.com/hayesr) fixed typo in README

If you would like to contribute, fork and send me a pull request.


Copyright
---------
Copyright &copy; 2011 Seth Vargo
