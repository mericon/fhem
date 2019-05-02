##############################################
# $Id: myUtilsTemplate.pm 7570 2015-01-14 18:31:44Z rudolfkoenig $
#
# Save this file as 99_myUtils.pm, and create your own functions in the new
# file. They are then available in every Perl expression.

package main;

use strict;
use warnings;
use POSIX;

sub
myUtils_Initialize($$)
{
  my ($hash) = @_;
}

# Enter you functions below _this_ line.
sub Schlafgut() {
    # Übergebene Parameter in Variablen speichern
    my (@type) = @_;
	
    # Standardantwort festlegen
    fhem("set S_Licht off");
	fhem("set SchrankSchlauch off");
	fhem("set sb.schlafzimmer sleep 01:30:00");
	fhem("set sb.schlafzimmer play");
    fhem("set sb.schlafzimmer volume 55");

	return "Gute Nacht.";
}

sub GuteNacht() {
	
    fhem("set S_Licht off");
	fhem("set SchrankSchlauch off");
	fhem("set sb.schlafzimmer stop");
    fhem("set sb.schlafzimmer volume 40");

	return "Schlaf gut.";
}

sub WetterMorgen($) {
my ($no) = @_;
my $i = 6;
my $k = 0;
my $u = "";
my $v = "";
my $w = "";
my $da = "fc".$no."_date";
while($i < 19) {
	if ($i == 6)
	{$k = "06"}
	elsif ($i == 9)
	{$k = "09"}
	else
	{$k = $i};
	my $we = "fc".$no."_weather".$k;
	my $te = "fc".$no."_temp".$k;
	my $wi = "fc".$no."_wind".$k;
  $u = "Um ".$i." Uhr ist es ".(ReadingsVal("WetterProplanta",$we,0))." Die Temperatur beträgt voraussichtlich ".(ReadingsVal("WetterProplanta",$te,0))." Grad Celsius.";
  $v = $v.$u;
  $i += 3;
}
  $w = "Das Wetter vom ".(ReadingsVal("WetterProplanta",$da,0)).". ".$v;
  return $w;
}

sub aussenTemp() {
my ($no) = 0;
my $i = 6;
my $k = 0;
my $u = "";
my $v = "";
my $w = "";
my $da = "fc".$no."_date";
while($i < 19) {
	if ($i == 6)
	{$k = "06"}
	elsif ($i == 9)
	{$k = "09"}
	else
	{$k = $i};
	my $we = "fc".$no."_weather".$k;
	my $te = "fc".$no."_temp".$k;
	my $wi = "fc".$no."_wind".$k;
  if($te <= 5)
  {
	$w = "ist es Arschkalt.";
  }elsif($te > 5)
  {
	$w = "ist es Kalt.";
  }elsif($te > 9)
  {
	$w = "ist es Kühl.";
  }elsif($te > 14)
  {
	$w = "ist es Mild.";
  }elsif($te > 19)
  {
	$w = "ist es Warm.";
  }elsif($te > 25)
  {
	$w = "ist es Sehr Warm.";
  }
  $u = "Heute um ".$k."uhr".$w;
  $v=$v." ".$u;
  $i+=3;  
}
  
  return $v;
}

sub BedRoom($$) {
    # Übergebene Parameter in Variablen speichern
    my (@type) = @_;
	
    # Standardantwort festlegen
    my $response = "Das kann ich leider nicht beantworten,";

    if ($type[0] eq "Ficken" || $type[0] eq "Sex") {
	    
        fhem("set SchrankSchlauch on");
		fhem("set sb.schlafzimmer play");
        fhem("set sb.schlafzimmer volume 90");
		$response = ["Ich wünsche viel Spaß.","Macht ein Patenkind für Becca!","Viel erfolg.","Ich höre jetzt besser weg!","Ich habe ein, bitte nicht stören, schild aufgehangen","Ich dreh mich auch um."]->[rand(6)];
    }
	elsif ($type[0] eq "Fertig") {
	
	 	fhem("set SchrankSchlauch off");
		fhem("set sb.schlafzimmer pause");
		
		
		$response = "Ich hoffe es war schön";
	}
	
    # Antwort an das Snipsmodul zurück geben
    return $response;
}

1;
