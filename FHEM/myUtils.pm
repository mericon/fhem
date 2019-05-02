##############################################
# $Id: myUtilsTemplate.pm 7570 2015-01-14 18:31:44Z rudolfkoenig $
#
# Save this file as 99_myUtils.pm, and create your own functions in the new
# file. They are then available in every Perl expression.

package main;

use strict;
use warnings;
use POSIX;

sub myUtils_Initialize($$)
{
  my ($hash) = @_;
}

# Enter you functions below _this_ line.


sub checkFritzMACpresent($$) {
  # Benötigt: Name der zu testenden Fritzbox ($Device),
  #           zu suchende MAC ($MAC), 
  # Rückgabe: 1 = Gerät gefunden
  #           0 = Gerät nicht gefunden
  my ($Device, $MAC) = @_;
  my $Status = 0;
  $MAC =~ tr/:/_/;
  $MAC = "mac_".uc($MAC);
  my $StatusFritz = ReadingsVal($Device, $MAC, "weg");
  if ($StatusFritz eq "weg") {
    Log 1, ("checkFritzMACpresent ($Device): $MAC nicht gefunden, abwesend.");
    $Status = 0;
  } elsif ($StatusFritz eq "inactive") {
    Log 1, ("checkFritzMACpresent ($Device): $MAC ist >inactive<, also abwesend.");
    $Status = 0;
  } else {
    # Reading existiert, Rückgabewert ist nicht "inactive", also ist das Gerät per WLAN angemeldet.
    Log 1, ("checkFritzMACpresent ($Device): $MAC gefunden, Gerät heißt >$StatusFritz<.");
    $Status = 1;
  }
  return $Status
}

1;
