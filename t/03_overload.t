use strict;
use Test::More 0.98;

use Captcha::reCAPTCHA::V3;

my $rc = Captcha::reCAPTCHA::V3->new( secret => 'Dummy', sitekey => 'Dummy' );

is $rc->name(),  'g-recaptcha-response', "name() returns default";
is "$rc",        'g-recaptcha-response', "overload stringify works";

$rc->name('custom');
is "$rc", 'custom', "overload uses updated name";

done_testing;
