#!/usr/bin/env perl

use v5.40.0;
use strict;
use warnings;

use File::Basename qw/dirname/;
chdir dirname($0);
system qw{git remote add upstream https://gitweb.gentoo.org/proj/portage.git};
system qw{git checkout upstream/master sys-apps/portage/};
exit system qw{git pull upstream master}
