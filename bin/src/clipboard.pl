#!/usr/bin/perl
# https://github.com/muennich/urxvt-perls
# I should be placed with other perl libs
# sudo cp clipboard /usr/lib/urxvt/perl/
# requires "urxvt-perls" and maybe "xclip" packages

use strict;

sub on_start {
    my ($self) = @_;

    $self->{copy_cmd} = $self->x_resource('copyCommand') || 'xclip -selection clipboard';
    $self->{paste_cmd} = $self->x_resource('pasteCommand') || 'xclip -o -selection clipboard';

    ()
}

sub copy {
    my ($self) = @_;

    if (open(CLIPBOARD, "| $self->{copy_cmd}")) {
        my $sel = $self->selection();
        utf8::encode($sel);
        print CLIPBOARD $sel;
        close(CLIPBOARD);
    } else {
        print STDERR "error running '$self->{copy_cmd}': $!\n";
    }

    ()
}

sub paste {
    my ($self) = @_;

    my $str = `$self->{paste_cmd}`;
    if ($? == 0) {
        $self->tt_paste($self->locale_encode($str));
    } else {
        print STDERR "error running '$self->{paste_cmd}': $!\n";
    }

    ()
}

sub on_user_command {
    my ($self, $cmd) = @_;
    if ($cmd eq "clipboard:paste") {
        $self->paste;
    }
    elsif ($cmd eq "clipboard:copy") {
        $self->copy;
    }
}
