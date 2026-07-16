use strict;
use Test::More 0.98 tests => 3;

use_ok('Captcha::Cloudflare::Turnstile');
my $ts = new_ok('Captcha::Cloudflare::Turnstile', [ sitekey => 'Dummy', secret => 'Dummy' ]);
$ts->isa_ok('Captcha::Cloudflare::Turnstile');

done_testing;
