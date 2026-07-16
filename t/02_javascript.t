use strict;
use Test::More 0.98;

use Captcha::Cloudflare::Turnstile;

my $rc = Captcha::Cloudflare::Turnstile->new( secret => 'Dummy' );

is eval { $rc->scriptURL() }, undef, "scriptURL fails without sitekey";
is eval { $rc->scriptTag() }, undef, "scriptTag fails without sitekey";
is eval { $rc->scripts( id => 'Form' ) }, undef, "scripts fails without sitekey";

my $url = $rc->scriptURL( sitekey => 'Dummy' );
like $url, qr|https://www.google.com/recaptcha/api.js\?render=Dummy|, "scriptURL generates correct URL";

my $tag = $rc->scriptTag( sitekey => 'Dummy' );
like $tag, qr|<script src=".+recaptcha.+Dummy" defer></script>|, "scriptTag generates script element";

my $scripts = $rc->scripts( id => 'Form', sitekey => 'Dummy' );
like $scripts, qr|grecaptcha.execute|, "scripts generates JavaScript";

$rc->sitekey('Dummy');
is $rc->scriptURL(), $url, "scriptURL uses stored sitekey";

my $test = $rc->scripts( id => 'Form', debug => 1 );
like $test, qr|console\.log\(token\)|, "succeed to make test scripts";

done_testing;
