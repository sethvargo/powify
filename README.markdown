Powify
======

Powify is a management tool for [Pow](http://pow.cx/) by 37 signals. It allows you to easily install, update, and manage pow and pow applications seamlessly. To get started, read the installation section below.


Installation
============
Install powify using the `gem` command:

    gem install powify


Usage
=====
    $ pow server install
    => install pow server

&nbsp;

    $ pow server reinstall
    => reinstall pow server

&nbsp;

    $ pow server update
    => update pow server

&nbsp;

    $ pow server uninstall
    => uninstall pow server

&nbsp;

    $ pow server list
    => list all apps on this pow server

&nbsp;

    $ pow server logs
    => tail the pow server logs

&nbsp;

    $ pow create
    => create a pow app with the same name as the current directory

&nbsp;

    $ pow create foo
    => create a pow app named `foo` served from the current directory

&nbsp;

    $ pow destroy
    => destroy the pow app served from the current directory

&nbsp;

    $ pow destroy foo
    => destroy the pow app named `foo`

&nbsp;

    $ pow restart
    => restart the app served from the current directory

&nbsp;

    $ pow restart foo
    => restart the pow app named `foo`

&nbsp;

    $ pow browse
    => open the default browser and navigate to this app

&nbsp;

    $ pow browse foo
    => open the default browser and navigate to the app named `foo`

&nbsp;

    $ pow browse foo test
    => open the default browser and navigate to the app named `foo` resolved on test (http://foo.test)

&nbsp;

    $ pow logs
    => tail the app logs for the app served from this directory
    
&nbsp;

    $ pow logs foo
    => tail the app logs for the app named `foo`

&nbsp;

    $ pow rename foo
    => rename the pow app in the current directory to `foo`

&nbsp;

    $ pow rename foo bar
    => rename the pow app named `foo` to `bar`

&nbsp;

    $ pow help
    => list pow commands


Contribution
============
If you would like to contribute, fork and send me a pull request.

Copyright
=========
Copyright &copy; 2011 Seth Vargo
