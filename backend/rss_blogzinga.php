<?php
	header('Cache-Control: no-cache, must-revalidate');
	header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
	header('Content-type: application/xml; charset=utf-8');
	
	require_once 'rss_feed.php';
	// configure appropriately
	
	// set more namespaces if you need them
	$xmlns = 'xmlns:content="http://purl.org/rss/1.0/modules/content/"
	    xmlns:wfw="http://wellformedweb.org/CommentAPI/"
	    xmlns:dc="http://purl.org/dc/elements/1.1/"
	    xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"';
	
	$site_url = 'http://www.blogzinga.it';
	$site_name = 'La lista dei blog di programmatori italiani. By CoseNonJaviste';
	$a_channel = array("title" => "BlogZinga!", "link" => $site_url, "description" => $site_name, "language" => "it");
	
	$json = file_get_contents('https://raw.githubusercontent.com/cosenonjaviste/blogzinga/master/blogs.json');
	$rss = new rss_feed($xmlns, $a_channel, $site_url, $site_name);
	echo $rss->create_feed(json_decode($json));
?>