<?php
class rss_feed {

	/**
	 * Constructor
	 *
	 * @param array $a_db database settings
	 * @param string $xmlns XML namespace
	 * @param array $a_channel channel properties
	 * @param string $site_url the URL of your site
	 * @param string $site_name the name of your site
	 * @param bool $full_feed flag for full feed (all topic content)
	 */
	public function __construct($xmlns, $a_channel, $site_url, $site_name, $full_feed = false) {
		// initialize
		$this -> xmlns = ($xmlns ? ' ' . $xmlns : '');
		$this -> channel_properties = $a_channel;
		$this -> site_url = $site_url;
		$this -> site_name = $site_name;
		$this -> full_feed = $full_feed;
	}

	/**
	 * Generate RSS 2.0 feed
	 *
	 * @return string RSS 2.0 xml
	 */
	public function create_feed($rss_items) {

		$xml = '<?xml version="1.0" encoding="utf-8"?>' . "\n";

		$xml .= '<rss version="2.0"' . $this -> xmlns . '>' . "\n";

		// channel required properties
		$xml .= '<channel>' . "\n";
		$xml .= '<title>' . $this -> channel_properties["title"] . '</title>' . "\n";
		$xml .= '<link>' . $this -> channel_properties["link"] . '</link>' . "\n";
		$xml .= '<description>' . $this -> channel_properties["description"] . '</description>' . "\n";

		// channel optional properties
		if (array_key_exists("language", $this -> channel_properties)) {
			$xml .= '<language>' . $this -> channel_properties["language"] . '</language>' . "\n";
		}
		if (array_key_exists("image_title", $this -> channel_properties)) {
			$xml .= '<image>' . "\n";
			$xml .= '<title>' . $this -> channel_properties["image_title"] . '</title>' . "\n";
			$xml .= '<link>' . $this -> channel_properties["image_link"] . '</link>' . "\n";
			$xml .= '<url>' . $this -> channel_properties["image_url"] . '</url>' . "\n";
			$xml .= '</image>' . "\n";
		}

		// get RSS channel items
		$now = date("YmdHis");

		foreach ($rss_items as $rss_item) {
			$xml .= '<item>' . "\n";
			$xml .= '<title>' . $rss_item->title . '</title>' . "\n";
			$xml .= '<link>' . $rss_item->url . '</link>' . "\n";
			$xml .= '<description>' . $rss_item->topic . '</description>' . "\n";
			$xml .= '<category>' . implode(", ", $rss_item->tags) . '</category>' . "\n";
			if (isset($rss_item->source)) {
				$xml .= '<source>' . $rss_item->source . '</source>' . "\n";
			}

			if ($this -> full_feed) {
				$xml .= '<content:encoded>' . $rss_item['content'] . '</content:encoded>' . "\n";
			}

			$xml .= '</item>' . "\n";
		}

		$xml .= '</channel>';

		$xml .= '</rss>';

		return $xml;
	}

}
?>