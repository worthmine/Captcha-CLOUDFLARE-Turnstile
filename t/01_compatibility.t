use strict;
use Test::More 0.98;

use Captcha::reCAPTCHA::V3;

my $rc = Captcha::reCAPTCHA::V3->new( secret => 'Dummy', sitekey => 'Dummy' );
my $content = $rc->verify('dummy-response-token');
is $content->{'error-codes'}[0], 'invalid-input-response', "verify detects invalid token";

done_testing;
