package ImgHost;

use Mojo::Base 'Mojolicious';

sub startup {
    my $self = shift;

    # Make signed cookies secure
    $self->secret(['Habba-habba-habba']);

    my $r = $self->routes;

    #/
    $r->any('/')->to('login#login');
}

1;
