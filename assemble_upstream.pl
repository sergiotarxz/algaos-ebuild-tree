#!/usr/bin/env perl

use v5.40.0;
use strict;
use warnings;

use File::Basename qw/dirname/;
chdir dirname($0);

system qw{git checkout upstream/master sys-apps/portage/};
for my $file ( glob 'sys-apps/portage/*.ebuild' ) {
    open my $read_fh, '<', $file or die "Cannot open $file: $!";
    my $final_contents = '';
    my ( $found_prefix_use, $found_end_prefix_use );
    while ( my $line = <$read_fh> ) {
        my $processed_line;
        ( $processed_line, $found_prefix_use, $found_end_prefix_use ) =
          process_line( $line, $found_prefix_use, $found_end_prefix_use );
        $final_contents .= $processed_line;
    }
    open my $fh, '>', $file;
    print $fh $final_contents;
    if ( system qw{sudo ebuild}, $file, 'clean' ) {
        die "Clean for $file failed";
    }
    if ( system qw{sudo ebuild}, $file, 'manifest' ) {
        die "Manifest for $file failed";
    }
    if ( system qw{sudo ebuild}, $file, 'compile' ) {
        die "Compile for $file failed";
    }
}

sub process_line( $line, $found_prefix_use, $found_end_prefix_use ) {
    if ( !$found_prefix_use ) {
        return ( $line, $found_prefix_use, $found_end_prefix_use )
          if $line !~ /^\s*if use prefix-guest/;
        return ( $line, 1, $found_end_prefix_use );
    }
    if ( !$found_end_prefix_use ) {
        return ( $line, $found_prefix_use, $found_end_prefix_use )
          if $line !~ /^\s*fi\s*$/;
        $line .= "
\t" . 'cat > cnf/repos.conf <<\'EOF\'
[DEFAULT]
main-repo = algaos

[algaos]
location = /var/db/repos/algaos
sync-type = git
sync-uri = https://github.com/sergiotarxz/algaos-ebuild-tree.git
auto-sync = yes
EOF
';
        return ( $line, $found_prefix_use, 1 );
    }
    return ( $line, $found_prefix_use, $found_end_prefix_use );
}
