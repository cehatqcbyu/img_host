package ImgHost::Login;

use Mojo::Base 'Mojolicious::Controller';

# Authentication section

sub login {
    my $self = shift;

    # Query or POST parameters
    my $user = $self->param('user') || '';
    my $pass = $self->param('pass') || '';

    # Check password and render "index.html.ep" if necessary
    return $self->render unless $self->users->check($user, $pass);

    # Store username in session
    $self->session(user => $user);
    # Redirect to protected page with a 302 response
    $self->redirect_to('/images');
}

sub registration {
    my $self = shift;

    # Query or POST parameters
    my $user = $self->param('user') || '';
    my $pass = $self->param('pass') || '';
    my $pass2 = $self->param('pass2') || '';
    my $err_message = ''; # show user if something wrong

    # if everyhing is blank
    return $self->render(err_message => $err_message) if( ($user eq '') && ($pass eq '') && ($pass2 eq '') );

    # register new user
    my $result = $self->users->register($user, $pass, $pass2);

    # registration succesfull
    if ($result eq 'ok') {
        if (mkdir ("images/$user")) {
            $self->redirect_to('index');
        }
        else {
            $err_message = "Unknown error!";
            return $self->render(err_message => $err_message);
        }
    }
    else {
        $err_message = $result;
        return $self->render(err_message => $err_message);
    }

}

1;
