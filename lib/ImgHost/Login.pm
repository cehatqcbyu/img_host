package ImgHost::Login;

use Mojo::Base 'Mojolicious::Controller';

# Authentication section

sub login {
    my $self = shift;
    $self->render;
}

1;
