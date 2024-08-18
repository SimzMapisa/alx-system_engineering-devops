# Apache 500 error by fixing typo in wordpress settings config file
# Fixes typo phpp to php

exec { 'fix typo in a wordpress website':
    onlyif  => 'test -e /var/www/html/wp-settings.php',
    command => "sed -i 's/phpp/php/' /var/www/html/wp-settings.php",
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
}
