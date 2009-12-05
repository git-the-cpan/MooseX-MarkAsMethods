#!/usr/bin/env perl
#############################################################################
#
# Author:  Chris Weyl (cpan:RSRCHBOY), <cweyl@alumni.drew.edu>
# Company: No company, personal work
# Created: 12/04/2009
#
# Copyright (c) 2009  <cweyl@alumni.drew.edu>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
#############################################################################

=head1 NAME

03-role.t -  

=head1 DESCRIPTION 

This test exercises...

=head1 TESTS

This module defines the following tests.

=cut

use strict;
use warnings;

{
    package TestRole;

    use Moose::Role;
    use MooseX::MarkAsMethods autoclean => 1;

    use overload q{""} => sub { shift->stringify }, fallback => 1;
    #sub stringify { 'from role' }
    requires 'stringify';

    has role_att => (isa => 'Str', is => 'rw');
}
{
    package TestClass;

    use Moose;
    use MooseX::MarkAsMethods autoclean => 1;

    with 'TestRole';

    sub stringify { 'from class' }
    has class_att => (isa => 'Str', is => 'rw');
}

use Test::More 0.92; #tests => XX;
use Test::Moose;

require 't/funcs.pm' unless eval { require funcs };

check_sugar_removed_ok('TestClass');

my $t = make_and_check(
    'TestClass',
    [ 'TestRole' ],
    [ qw{ role_att class_att } ],
);

is "$t", 'from class', 'TestClass stringified correctly';
ok $t->meta->has_method('(""'), 'TestClass still has overload method';

done_testing;

__END__

=head1 AUTHOR

Chris Weyl  <cweyl@alumni.drew.edu>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2009  <cweyl@alumni.drew.edu>

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
     Lesser General Public License for more details.

     You should have received a copy of the GNU Lesser General Public
     License along with this library; if not, write to the 

     Free Software Foundation, Inc.
     59 Temple Place, Suite 330
     Boston, MA  02111-1307  USA

     =cut


