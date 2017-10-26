<?php

$serverType='';

if( strpos(strtolower($_SERVER["SERVER_SOFTWARE"]), 'apache') !== false ) {
    $serverType = 'apache';
}
elseif(strpos(strtolower($_SERVER["SERVER_SOFTWARE"]), 'nginx') !== false ) {
    $serverType = 'nginx';
}


$isMemcached = false;

$memcached = new Memcached;
$memcached->addServer('memcached',11211);

if($memcached->set("Test", "I found a match, memcached is working")) {
    $isMemcached = true;
}


function test_host($hostUrl)
{
    $exists = false;
    $headers = get_headers($hostUrl,1);

    if(is_array($headers) && strpos($headers[0],'200') !== false ) {
        $exists = true;
    }

    return $exists;
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Control Panel</title>
</head>
<body>
    <h1>Control Panel for Kaliop Docker platform</h1>

    <h2>Web server</h2>
    <ul>
        <li><a href="/phpinfo.php">PHP Info</a></li>
        <li><a href="/ocp.php">PHP Opcache Info</a></li>
        <?php
        if( $serverType == 'apache' )
        {
            echo '<li><a href="/server-status">Apache Server Status</a></li>
                <li><a href="/server-info">Apache Server Info</a></li>';
        }
        elseif( $serverType == 'nginx' )
        {
            echo '<li><a href="/nginx_status">Nginx Server Status</a></li>';
        }
        ?>
    </ul>

    <h2>Other servers</h2>
    <ul>
        <?php
        if( $isMemcached ) {
            echo '<li><a href="/memcache/">Memcached Info</a></li>
                 <li><a href="http://localhost:88/phpmemadmin/web/index.php">Memcached Admin</a></li>';
        }
        ?>
        <?php
            if(test_host("http://solr:8983/solr/")) {
                echo '<li><a href="http://localhost:8983/solr/">Solr</a></li>';
            }
        ?>

        <?php
        if(test_host("http://localhost/pma/index.php")) {
            echo '<li><a href="/pma/index.php">PhpMyAdmin</a></li>';
        }
        ?>

        <?php
        if(test_host("http://varnish:81")) {
            echo '<li><a href="http://localhost:88/va/html/">Varnish</a></li>';
        }
        ?>
    </ul>

    <p>Credentials for Varnish & Memcached Admin : </p>
    <ul>
        <li>Varnish : varnish / CacheMeIfYouCan</li>
        <li>Memcached Admin : admin / pass</li>
    </ul>
</body>
</html>
