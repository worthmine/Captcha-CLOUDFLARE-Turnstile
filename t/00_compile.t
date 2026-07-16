use strict;
use Test::More 0.98;

use_ok('Captcha::CloudFlare::Turnstile');
my $ts = new_ok('Captcha::CloudFlare::Turnstile', [ sitekey => 'Dummy', secret => 'Dummy' ]);

$ts->isa_ok('Captcha::CloudFlare::Turnstile');



done_testing;

