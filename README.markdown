Powify
======

Powify is a management tool for [Pow](http://pow.cx/) by 37 signals. It allows you to easily install, update, and manage pow and pow applications seamlessly. To get started, read the installation section below.


Installation
============
Install powify using the `gem` command:

    gem install powify


Usage
=====
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

    $ powify help
    => list pow commands


Contribution
============
- 6/9 [@hayesr](https://github.com/hayesr) fixed typo in README

If you would like to contribute, fork and send me a pull request.

Copyright
=========
Copyright &copy; 2011 Seth Vargo
