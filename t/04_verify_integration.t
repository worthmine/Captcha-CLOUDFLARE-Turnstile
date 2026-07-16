use strict;
use Test::More 0.98;

use Captcha::reCAPTCHA::V3;

my $secret   = $ENV{RECAPTCHA_TEST_SECRET}   // '6LeIxAcTAAAAAGG-vFI1TnRWxMZNFuojJ4WifJWe';
my $response = $ENV{RECAPTCHA_TEST_RESPONSE} // 'dummy-token-for-test-key';

my $rc = Captcha::reCAPTCHA::V3->new( secret => $secret );
my $content = eval { $rc->verify($response) };

ok !$@,                       'verify() does not die';
ok exists $content->{success}, 'response has success key';
is $content->{success}, 1,    'test key returns success';

done_testing;
