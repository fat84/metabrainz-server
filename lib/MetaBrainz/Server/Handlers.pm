#!/home/httpd/metabrainz/metabrainz/bin/perl -w
# vi: set ts=4 sw=4 :

use strict;

package MetaBrainz::Server::Handlers;

use Apache::Constants qw( DECLINED HTTP_NOT_ACCEPTABLE );
use HTTP::Headers;
use HTTP::Negotiate;

sub TransHandler
{
	my ($r) = @_;
	my $uri = $r->uri;

	if ($uri =~ s/;remote_ip=(.*?)$//)
	{
		my $ip = $1;
	   	$r->connection->remote_ip($ip);
		$r->uri($uri);

		my $request = $r->the_request;

		if ($request =~ s/;remote_ip=\Q$ip\E//)
		{
			$r->the_request($request);
		}
	}

	DECLINED;
}

1;
# eof Handlers.pm