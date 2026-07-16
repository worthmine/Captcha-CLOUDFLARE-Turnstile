
# NAME

Cloudflare::Turnstile - A Perl implementation of Cloudflare Turnstile

# SYNOPSIS

```perl
use Cloudflare::Turnstile;
my $ts = Cloudflare::Turnstile->new(
sitekey => '__YOUR_SITEKEY__', # Optional
secret  => '__YOUR_SECRET__',  # Required
);
```

```perl
# In your HTML template, inside a <form> tag:
print $ts->scripts( action => 'login' );
# or separately:
print $ts->scriptTag;
print $ts->widgetTag( action => 'login' );
```

```perl
# Server-side verification:
my $content = $ts->verify($param{$ts});
unless ( $content->{'success'} ) {
die 'fail to verify Turnstile: ', @{ $content->{'error-codes'} }, "\n";
}
```

# DESCRIPTION

Cloudflare::Turnstile is a subclass of Captcha::reCAPTCHA::V3 that implements
the [Cloudflare Turnstile](https://www.cloudflare.com/products/turnstile/) CAPTCHA service.

It inherits `verify()`, `name()`, `sitekey()`, and the utility methods from the base class,
and overrides the API endpoints and JavaScript helpers for Turnstile.

## Basic Usage

### new( secret => _secret_, [ sitekey => _sitekey_, query_name => _query_name_ ] )

Requires only secret when constructing.

You have to get them from [Cloudflare Turnstile dashboard](https://dash.cloudflare.com/?to=/:account/turnstile).

```perl
my $ts = Cloudflare::Turnstile->new(
sitekey    => '__YOUR_SITEKEY__', # Optional
secret     => '__YOUR_SECRET__',
query_name => '__YOUR_QUERY_NAME__', # Optional, defaults to 'cf-turnstile-response'
);
```

### name([_name_])

Get/set the form field name (_query_name_). Defaults to `'cf-turnstile-response'`.

```perl
my $query_name = "$ts";   # stringification returns query_name
```

### verify( _response_ )

Sends the token to the Cloudflare Turnstile siteverify endpoint and returns the decoded JSON response.

```perl
my $content = $ts->verify($param{$ts});
unless ( $content->{'success'} ) {
die 'fail to verify Turnstile: ', @{ $content->{'error-codes'} }, "\n";
}
```

### verify_or_die( response => _response_ )

Calls `verify()` and dies immediately on failure.

### deny_by_score( response => _response_ )

Not applicable for Turnstile (no score is returned). Issues a warning and delegates to `verify()`.

### scriptURL()

Returns the Turnstile JavaScript API URL:
`https://challenges.cloudflare.com/turnstile/v0/api.js`

No sitekey parameter is required in the URL for Turnstile.

### scriptTag()

Returns `<script src="...api.js" defer></script>`.

### widgetTag( [ sitekey => _sitekey_, action => _action_ ] )

Returns the Turnstile widget `<div ...></div>` to place inside a `<form>` tag.

```perl
print $ts->widgetTag( action => 'login' );
# <div class="cf-turnstile" data-sitekey="..." data-action="login"></div>
```

Turnstile automatically injects a hidden `cf-turnstile-response` input into the form
when the challenge is completed.

### scripts( [ sitekey => _sitekey_, action => _action_ ] )

Returns `scriptTag()` and `widgetTag()` combined. Place this **inside** the `<form>` tag.

```perl
print <<"EOL";
<form action="./" method="POST">
<input type="hidden" name="name" value="value">
@{[ $ts->scripts( action => 'submit' ) ]}
<button type="submit">send</button>
</form>
EOL
```

# NOTES

To test this module strictly,
there is a necessary to run javascript in test environment.

Cloudflare provides dummy test keys for automated testing:

- Always passes: sitekey `1x00000000000000000000AA`, secret `1x0000000000000000000000000000000AA`

- Always blocks: sitekey `2x00000000000000000000AB`, secret `2x0000000000000000000000000000000AA`

# SEE ALSO

- Captcha::reCAPTCHA::V3

- [Cloudflare Turnstile](https://www.cloudflare.com/products/turnstile/)

- [Cloudflare Turnstile API document](https://developers.cloudflare.com/turnstile/)

# LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

worthmine <worthmine@gmail.com>
