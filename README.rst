trojita-google-contacts
=======================

An ugly Perl script I hacked together to one-way sync Google Contacts with Trojita.

Installation
************

First install goobook (Python 2 is required, not Python 3)::

  sudo python2 -m pip install goobook

Then install trojita-google-contacts:

::

  sudo make install

Usage
*****

Just run:

::

  trojita-google-contacts

This will download your Google Contacts list and save it to your address book. Trojita
should pick up the changes automatically.

Automatic syncing
*****************

A systemd service+timer are included. Run::

  make install-systemd
  systemctl --user enable trojita-google-contacts.timer

This will sync every day by default. To change this, pass ``SYNC=`` to
``make install-systemd``::

  make install-systemd SYNC=1d     # every day
  make install-systemd SYNC=15min  # every 15 minutes

If you go this route, for on-demand syncing you should run::

  systemctl --user run trojita-google-contacts

instead of running ``trojita-google-contacts`` manually. This should avoid interference
with the timer.
