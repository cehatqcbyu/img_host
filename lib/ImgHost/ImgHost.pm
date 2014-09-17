package ImgHost;

use Mojo::Base 'Mojolicious';

use ImgHost::Model::Users;

sub startup {
    my $self = shift;

    # Make signed cookies secure
    $self->secret(['Secret-tsssss']);
    $self->helper(users => sub { state $users = ImgHost::Model::Users->new(); });

    my $r = $self->routes;

    # /
    $r->any('/')->to('login#index')->name('index');
    # /registration
    $r->any('/registration')->to('login#registration')->name('registration');
    # /logout
    $r->any('/logout')->to('login#logout')->name('logout')

    # /images section (authentication check required)
    my $rn = $r->bridge('/images')->to('login#logged_in');
    $rn->any('/')->to('images#show')->name('images_show');
    $rn->any('/add')->to('images#add')->name('images_add');
}

1;
