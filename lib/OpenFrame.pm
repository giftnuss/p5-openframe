package OpenFrame;

use strict;

##
## we just want to track versions
##
our $VERSION = '2.08';

=head1 NAME

OpenFrame - An Application Framework for Perl and the Web

=head1 SYNOPSIS

  # See the examples/ directory

=head1 DESCRIPTION

=head2 The OpenFrame Application Framework

=head2 Introduction

The OpenFrame application framework takes a lot of complicated ideas, and
tries to simplify them into a single point that allows for multiple applications
to take care of multiple presentations, without the time consuming parts (mainly the
application) having to be rewritten several times.

This document attempts to provide an overview of what OpenFrame does and how it could
be made to work for you.

=head2 Framework Overview

At the heart of the framework lies the server class.  An OpenFrame server is a simple device that
takes a request from one mechanism and translates it into one that OpenFrame can understand.
Once a request is generated in the form of an AbstractRequest object the server passes control to
OpenFrame's slot system.  The slot system is a simple way of plugging in new functionality to the
system, without it having an effect on old functionality.  To get a basic understanding of what
slots do, imagine a pipe.  Each section of the pipe dyes the water a different colour, provided
that the water is the right colour that flows into it is correct.  If it isn't, the water keeps 
flowing, but it doesn't change colour.  Right, now replace slots for sections, and objects for water.

Slots execute linearly - that is, one after the other.  Each slot tells the slot pipeline that
it wants certain objects in order to function.  When a slot executes it may return an object
which the pipeline will keep and remember. Later on in the pipeline if that object is
needed by a different slot then the pipeline can provide it.  The only difference between this
and our magical colour changing water is that at the end of the slot pipeline there should
be something that our server understands -- an AbstractResponse object.

The AbstractResponse object is used as a container for the data (for example, HTML) and is passed
by the OpenFrame server to the person who asked for it originally in the AbstractRequest object.
Once the request is complete, everything that we learnt -- any object that was generated along
the slot pipeline -- is thrown away, so that the next request can begin afresh.

Slots can be plugged quickly in and out of the pipeline, as the server doesn't care what happens in 
the pipeline and the elements of the pipeline don't care what happens to the other elements, and none
of the elements care what happens to anything they generate -- they just want to do their thing, and
be done with.

=head2 Slot Dispatch

Another useful part of OpenFrame is that the slots need not reside on the local system.  The slot
system allows for multiple dispatch mechanisms.  The fastest, and most obvious way of course, is
to dispatch them locally and write them in Perl.  However, another way of doing it is to write them
in Java, and dispatch them using the SOAP.  These dispatch mechanisms are easily extended to work
for any calling mechanism, and any programming language.

This doesn't mean that you should only consider SOAP-based dispatch if you are planning on writing
slots in other languages.  You can distribute the load of your OpenFrame server by moving various
slots to various other places.

=head2 Slots can be Clever

Slots can also be a little bit cunning.

Sometimes a slot knows that it must be executed, and although there are some things that it must have, sometimes 
it would be nice to have a few things, but not absolutely necessary.  Rather than confusing things, a slot can simply 
request that it has I<everything> that a pipeline knows, and then query the pipeline programatically to
see if it knows anything that is useful.  In fact, it can blend requesting the entire pipeline, with
requesting individual elements, so the functionality in the slot can be quite circuitous.

Another place where slots can be clever is what they return.  Often executing a slot at the top of the
slot pipeline means that another slot has to execute at the bottom of the pipeline. To allow for this, 
slots can return a single object, or a single class name, or any combination of either in a list.  When
the slot pipeline sees that a slot has returned a class name, it pushes the class to the bottom of the
pipeline and tells it to use all the properties of the slot that returned it.  For instance, if a slot
that is dispatched via SOAP returns a class name, then the returned class would be placed in the pipeline
and would be dispatched with SOAP to the same place that the original slot was dispatched to.

=head2 Slots out of the Box

Out of the box OpenFrame provides some pretty powerful functionality from its slots.  Fotango (the nice
people that let us write OpenFrame) want to use OpenFrame as an Application Server, so the majority
of the slots reflect that purpose.  However, they are all open source, and are all bundled in the OpenFrame
distribution.  This means that out of the box OpenFrame can operate as as Application Server for the
web.

The slots that build this functionality are simple.  Listed in order of execution:

  Slot Name			  Slot Purpose

  OpenFrame::Slot::Images         serve images immediately
  OpenFrame::Slot::Session        restore or generate a session
  OpenFrame::Slot::Dispatch       dispatch an application
  OpenFrame::Slot::Generator      generate content
  OpenFrame::Slot::SessionSaver   save the session

The application dispatcher slot is (we think) quite clever, so we'd like to tell you more about it, but
that exists outside the scope of this document.  For more information, see OpenFrame::AppWrite.

=head1 PORTABILITY

OpenFrame is pretty much as portable as Perl. We have tested it on the
following varied platforms:

  Operating System        Architecture

  Caldera OpenLinux 3.1   i386
  Darwin 5.1              PowerPC
  Debian Linux 2.1        StrongARM
  Debian Linux 2.2        Alpha
  Debian Linux 2.2        i386
  Debian Linux 2.2        PowerPC
  Debian Linux 2.2        Sparc
  FreeBSD 4.4             i386
  Mandrake Linux 8.1      i386
  NetBSD 1.5.1            Alpha
  RedHat Linux 7.1        Itanium
  RedHat Linux 7.2        i386
  SunOS 5.8               Sparc
  SuSE Linux 7            i386
  SuSE Linux 7            S/390
  Tru64 5.1a              Alpha
  TurboLinux 6.5          i386
  Slackware 8.0           i386

=head1 SEE ALSO

OpenFrame::Install
OpenFrame::AppWrite
OpenFrame::Slot

=head1 AUTHOR

James A. Duncan <jduncan@fotango.com>

=head1 COPYRIGHT

Copyright (C) 2001, Fotango Ltd.

This module is free software; you can redistribute it or modify it
under the same terms as Perl itself.

=cut

1;
