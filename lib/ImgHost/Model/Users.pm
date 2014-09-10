package ImgHost::Model::Users;

use Modern::Perl;
use Moose;

# user authentication and registration
# user information is stored in text file ./users/users.conf

my %users;
my $salt = 'habba'; # for hashing algorythm;

sub BUILD {

    # check if ./users/users.conf exists
    # if not - create directory and file
    unless (-d 'users') {
        mkdir 'users';
        open (my $pass_file, '>>', './users/users.conf') || die "Can't open file ./users/users.conf: $!";
        close ($pass_file);
    }
}

# check user/pass
sub check {
    my ($self, $login, $pass) = @_;

    # get current passwords from file
    &get_users();
    
    # checking
    my $hash = crypt $pass, $salt; # create hash from checked password
    if ( ($users{$login}) && ($hash eq $users{$login}) ) {
        return 1;
    }
    else {
        return 0;
    }
}

# get user/pass from password file
sub get_users {
    undef %users;
    open (my $pass_file, '<', './users/users.conf') || die "Can't open file ./users/users.conf: $!";
    while (<$pass_file>) {
        my @row = split /\s+/, $_;
        $users{$row[0]} = $row[1];
    }
    close ($pass_file);
}

1;
