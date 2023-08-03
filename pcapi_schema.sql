-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 03, 2023 at 08:41 PM
-- Server version: 8.0.21
-- PHP Version: 7.4.3-4ubuntu2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pcapi`
--

-- --------------------------------------------------------

--
-- Table structure for table `api_tokens`
--

CREATE TABLE `api_tokens` (
  `id` bigint NOT NULL,
  `userid` bigint NOT NULL COMMENT 'Link to id in the users table',
  `keyval` varchar(20) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `secretval` varchar(40) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `createdon` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `permlevel` int NOT NULL DEFAULT '0' COMMENT 'What permissions does this key have?',
  `rate_limited` int NOT NULL DEFAULT '0' COMMENT 'Is a rate limit in effect?'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin COMMENT='API tokens for accessing the REST api';

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint NOT NULL,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Categories for podcasts.';

-- --------------------------------------------------------

--
-- Table structure for table `category_map`
--

CREATE TABLE `category_map` (
  `id` bigint NOT NULL,
  `categoryid` bigint NOT NULL,
  `feedid` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='A mapping of feeds to categories.';

-- --------------------------------------------------------

--
-- Table structure for table `developers`
--

CREATE TABLE `developers` (
  `id` bigint NOT NULL,
  `email` varchar(512) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `active` tinyint NOT NULL DEFAULT '0',
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `lastlogin` datetime NOT NULL,
  `lastpasschange` datetime NOT NULL,
  `username` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `activationcode` varchar(49) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Developer accounts';

-- --------------------------------------------------------

--
-- Table structure for table `directory_apple`
--

CREATE TABLE `directory_apple` (
  `id` bigint NOT NULL,
  `description` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `itunes_id` bigint NOT NULL,
  `itunes_url` varchar(768) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `time_createdon` int NOT NULL,
  `feed_url` varchar(768) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `title_non_english` tinyint NOT NULL DEFAULT '0' COMMENT 'Does the title contain non-english characters',
  `artwork_url_30` varchar(768) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `artwork_url_60` varchar(768) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `artwork_url_100` varchar(768) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `artwork_url_600` varchar(768) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `dead` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_cs COMMENT='Apple metadata for linkage to feeds';

-- --------------------------------------------------------

--
-- Table structure for table `feeds_added`
--

CREATE TABLE `feeds_added` (
  `id` bigint NOT NULL,
  `feedid` bigint DEFAULT NULL,
  `userid` int DEFAULT NULL,
  `developerid` bigint DEFAULT NULL,
  `time_added` int NOT NULL DEFAULT '0',
  `source` tinyint NOT NULL DEFAULT '0' COMMENT '0-api, 1-api-batch, 2-cron',
  `processed` tinyint NOT NULL DEFAULT '0',
  `stage` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='A record of every feed added and who added it.';

-- --------------------------------------------------------

--
-- Table structure for table `flags`
--

CREATE TABLE `flags` (
  `name` varchar(32) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `value` int NOT NULL,
  `timeset` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `setby` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin COMMENT='Server-wide flags.';

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `id` int NOT NULL,
  `itunes_genre_id` int NOT NULL DEFAULT '0',
  `title` varchar(256) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `subgenre` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Podcast categories';

-- --------------------------------------------------------

--
-- Table structure for table `newsfeeds`
--

CREATE TABLE `newsfeeds` (
  `id` bigint NOT NULL,
  `title` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `url` varchar(768) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `lastcheck` int NOT NULL DEFAULT '0',
  `lastupdate` int NOT NULL DEFAULT '0',
  `lastmod` int NOT NULL DEFAULT '0',
  `createdon` int NOT NULL DEFAULT '0',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `link` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `errors` int NOT NULL DEFAULT '0',
  `updated` tinyint NOT NULL DEFAULT '0',
  `lastitemid` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `pubdate` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `contenthash` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `lasthttpstatus` int NOT NULL DEFAULT '0',
  `lastgoodhttpstatus` int NOT NULL DEFAULT '0',
  `dead` tinyint NOT NULL DEFAULT '0',
  `contenttype` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `itunes_id` bigint DEFAULT NULL,
  `duplicateof` bigint DEFAULT NULL,
  `original_url` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `artwork_url_600` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `description` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `itunes_author` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `itunes_owner_email` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `itunes_owner_name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `itunes_new_feed_url` varchar(768) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `explicit` tinyint NOT NULL DEFAULT '0',
  `image` varchar(768) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `itunes_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` tinyint NOT NULL DEFAULT '0',
  `generator` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `parse_errors` int NOT NULL DEFAULT '0',
  `lastparse` int NOT NULL DEFAULT '0',
  `pullnow` tinyint NOT NULL DEFAULT '0' COMMENT 'Scan this feed immediately.',
  `parsenow` tinyint NOT NULL DEFAULT '0' COMMENT 'Parse this feed immediately.',
  `newest_item_pubdate` int NOT NULL DEFAULT '0',
  `update_frequency` tinyint NOT NULL DEFAULT '0',
  `priority` tinyint NOT NULL DEFAULT '0',
  `language` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'Language stated in the feed.',
  `detected_language` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'Language we detected.',
  `chash` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `oldest_item_pubdate` int NOT NULL DEFAULT '0',
  `item_count` int NOT NULL DEFAULT '0',
  `popularity` int NOT NULL DEFAULT '0',
  `podcast_chapters` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `podcast_locked` tinyint NOT NULL DEFAULT '0',
  `podcast_owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The podcast feeds';

-- --------------------------------------------------------

--
-- Table structure for table `nfcategories`
--

CREATE TABLE `nfcategories` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `catid1` bigint DEFAULT NULL,
  `catid2` bigint DEFAULT NULL,
  `catid3` bigint DEFAULT NULL,
  `catid4` bigint DEFAULT NULL,
  `catid5` bigint DEFAULT NULL,
  `catid6` bigint DEFAULT NULL,
  `catid7` bigint DEFAULT NULL,
  `catid8` bigint DEFAULT NULL,
  `catid9` bigint DEFAULT NULL,
  `catid10` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nfenclosures`
--

CREATE TABLE `nfenclosures` (
  `id` bigint NOT NULL COMMENT 'Enclosure id',
  `itemid` bigint NOT NULL COMMENT 'Newsfeed item id',
  `url` varchar(2048) NOT NULL COMMENT 'Url of the enclosure',
  `mimetype` varchar(64) NOT NULL COMMENT 'Mimetype of the enclosure',
  `length` bigint NOT NULL COMMENT 'Size in bytes of the enclosure',
  `time` datetime NOT NULL COMMENT 'Incoming enclosure time',
  `type` int NOT NULL COMMENT 'Internal type spec',
  `marker` int NOT NULL COMMENT 'Timestampe of last play marker',
  `source` int NOT NULL COMMENT 'Is this an html scrape or an enclosure?'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Enclosures from the newsfeed item table';

-- --------------------------------------------------------

--
-- Table structure for table `nfetags`
--

CREATE TABLE `nfetags` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `updatedon` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nffunding`
--

CREATE TABLE `nffunding` (
  `feedid` bigint NOT NULL,
  `url` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nfguids`
--

CREATE TABLE `nfguids` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `guid` varchar(36) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nfhashes`
--

CREATE TABLE `nfhashes` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `hash` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `updatedon` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nfimages`
--

CREATE TABLE `nfimages` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `crc32` int UNSIGNED NOT NULL DEFAULT '0',
  `type` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0 = jpg',
  `resolution` int UNSIGNED NOT NULL DEFAULT '300'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nfitems`
--

CREATE TABLE `nfitems` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `link` varchar(768) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `guid` varchar(740) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT 'A unique id for this item.',
  `timestamp` bigint NOT NULL DEFAULT '0',
  `timeadded` int NOT NULL DEFAULT '0',
  `enclosure_url` varchar(768) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '' COMMENT 'Enclosure url',
  `enclosure_length` bigint NOT NULL DEFAULT '0',
  `enclosure_type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'audio/mpeg',
  `itunes_episode` int DEFAULT NULL,
  `itunes_episode_type` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `itunes_explicit` tinyint DEFAULT NULL,
  `itunes_duration` int DEFAULT NULL,
  `image` varchar(768) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `purge` tinyint NOT NULL DEFAULT '0',
  `itunes_season` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Holds all the news feed items.';

-- --------------------------------------------------------

--
-- Table structure for table `nfitem_chapters`
--

CREATE TABLE `nfitem_chapters` (
  `itemid` bigint NOT NULL,
  `url` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `type` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nfitem_images`
--

CREATE TABLE `nfitem_images` (
  `id` bigint NOT NULL,
  `episodeid` bigint NOT NULL,
  `crc32` int UNSIGNED NOT NULL DEFAULT '0',
  `type` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0 = jpg',
  `resolution` int UNSIGNED NOT NULL DEFAULT '300'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nfitem_persons`
--

CREATE TABLE `nfitem_persons` (
  `id` bigint UNSIGNED NOT NULL,
  `itemid` bigint NOT NULL,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `role` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'host',
  `grp` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'cast',
  `img` varchar(768) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `href` varchar(768) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nfitem_socialinteract`
--

CREATE TABLE `nfitem_socialinteract` (
  `id` bigint NOT NULL,
  `itemid` bigint NOT NULL,
  `uri` varchar(760) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `protocol` tinyint NOT NULL DEFAULT '0',
  `accountId` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `accountUrl` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `priority` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Social interact tags for newsfeed items.';

-- --------------------------------------------------------

--
-- Table structure for table `nfitem_soundbites`
--

CREATE TABLE `nfitem_soundbites` (
  `itemid` bigint NOT NULL,
  `title` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `start_time` int NOT NULL DEFAULT '0',
  `duration` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nfitem_transcripts`
--

CREATE TABLE `nfitem_transcripts` (
  `itemid` bigint NOT NULL,
  `url` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `type` tinyint NOT NULL DEFAULT '0',
  `captions` tinyint NOT NULL DEFAULT '0',
  `language` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Transcripts for newsfeed items.';

-- --------------------------------------------------------

--
-- Table structure for table `nfitem_value`
--

CREATE TABLE `nfitem_value` (
  `itemid` bigint NOT NULL,
  `value_block` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` tinyint NOT NULL DEFAULT '0' COMMENT '0=lightning',
  `createdon` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nflinkage`
--

CREATE TABLE `nflinkage` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `itunes` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `google` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `spotify` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `stitcher` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `luminary` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `bullhorn` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `iheartradio` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `ivoox` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `amazon` varchar(400) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Links to a podcast on other sites and services.';

-- --------------------------------------------------------

--
-- Table structure for table `nfliveitems`
--

CREATE TABLE `nfliveitems` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `link` varchar(768) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `guid` varchar(740) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT 'A unique id for this item.',
  `timestamp` bigint NOT NULL DEFAULT '0',
  `timeadded` int NOT NULL DEFAULT '0',
  `enclosure_url` varchar(768) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '' COMMENT 'Enclosure url',
  `enclosure_length` bigint NOT NULL DEFAULT '0',
  `enclosure_type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'audio/mpeg',
  `itunes_explicit` tinyint DEFAULT NULL,
  `image` varchar(768) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `purge` tinyint NOT NULL DEFAULT '0',
  `start_time` int NOT NULL DEFAULT '0',
  `end_time` int NOT NULL DEFAULT '0',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0=pending, 1=live, 2=ended',
  `content_link` varchar(768) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Holds all the live feed items.';

-- --------------------------------------------------------

--
-- Table structure for table `nflocations`
--

CREATE TABLE `nflocations` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `locale` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `osm` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `latlon` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Location tags for newsfeeds';

-- --------------------------------------------------------

--
-- Table structure for table `nfmediums`
--

CREATE TABLE `nfmediums` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `medium` varchar(36) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'podcast'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nfpersons`
--

CREATE TABLE `nfpersons` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `role` tinyint NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `image` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `href` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Persons listed in feeds';

-- --------------------------------------------------------

--
-- Table structure for table `nfproblematic`
--

CREATE TABLE `nfproblematic` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `reason` tinyint NOT NULL DEFAULT '0',
  `updatedon` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nfpublish`
--

CREATE TABLE `nfpublish` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `pub_time` int NOT NULL,
  `pub_dow` int NOT NULL,
  `pub_dom` int NOT NULL,
  `pub_slice` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Episode publish history for newsfeeds';

-- --------------------------------------------------------

--
-- Table structure for table `nfschedule`
--

CREATE TABLE `nfschedule` (
  `feedid` bigint NOT NULL,
  `sun` tinyint NOT NULL,
  `mon` tinyint NOT NULL,
  `tue` tinyint NOT NULL,
  `wed` tinyint NOT NULL,
  `thu` tinyint NOT NULL,
  `fri` tinyint NOT NULL,
  `sat` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The feed update schedule';

-- --------------------------------------------------------

--
-- Table structure for table `nfsoundbites`
--

CREATE TABLE `nfsoundbites` (
  `feedid` bigint NOT NULL,
  `url` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nfsphinx`
--

CREATE TABLE `nfsphinx` (
  `feedid` bigint NOT NULL,
  `node` varchar(128) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `updatedon` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nfsubscriptions`
--

CREATE TABLE `nfsubscriptions` (
  `apitoken` bigint NOT NULL,
  `subscriberid` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `updated` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nfvalue`
--

CREATE TABLE `nfvalue` (
  `feedid` bigint NOT NULL,
  `value_block` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` tinyint NOT NULL DEFAULT '0' COMMENT '0=lightning',
  `createdon` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `owners`
--

CREATE TABLE `owners` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `email` varchar(512) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Owners of podcasts';

-- --------------------------------------------------------

--
-- Table structure for table `podcasts`
--

CREATE TABLE `podcasts` (
  `id` bigint NOT NULL,
  `ownerid` bigint NOT NULL,
  `upid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `feedid` bigint NOT NULL,
  `createdon` int NOT NULL DEFAULT '0',
  `validation_code` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `prefs`
--

CREATE TABLE `prefs` (
  `id` int NOT NULL COMMENT 'User id',
  `maxfiles` int NOT NULL,
  `avatarurl` varchar(767) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `timezone` varchar(64) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT 'UTC'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin COMMENT='User level preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pubsub`
--

CREATE TABLE `pubsub` (
  `id` bigint NOT NULL,
  `feedid` bigint NOT NULL,
  `hub_url` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `self_url` varchar(768) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `lease_expire` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(128) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `userid` int NOT NULL,
  `lastactivity` int NOT NULL,
  `created` int NOT NULL,
  `firstsourceip` varchar(24) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `lastsourceip` varchar(24) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `firstbrowser` varchar(128) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `lastbrowser` varchar(128) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `type` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin COMMENT='Active sessions';

-- --------------------------------------------------------

--
-- Table structure for table `subgenres`
--

CREATE TABLE `subgenres` (
  `id` int NOT NULL,
  `title` varchar(256) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Podcast sub-categories';

-- --------------------------------------------------------

--
-- Table structure for table `tos_accept`
--

CREATE TABLE `tos_accept` (
  `id` bigint NOT NULL,
  `userid` int NOT NULL,
  `date` int NOT NULL,
  `version` int NOT NULL,
  `ip_address` varchar(40) NOT NULL,
  `browser` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='A record of who agreed to the TOS, when and where.';

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `name` varchar(128) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `password` varchar(128) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `email` varchar(128) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `active` tinyint NOT NULL DEFAULT '0',
  `admin` tinyint NOT NULL DEFAULT '0',
  `badlogins` tinyint NOT NULL DEFAULT '0',
  `stage` tinyint NOT NULL DEFAULT '0',
  `lastpasschange` datetime NOT NULL,
  `username` varchar(64) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `totpseed` varchar(40) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `lastlogin` datetime NOT NULL,
  `system` tinyint NOT NULL DEFAULT '0' COMMENT 'Is this a system account',
  `developer` bigint DEFAULT NULL COMMENT 'Is this a developer stub account?',
  `tos` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_bin COMMENT='Main user table.';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `api_tokens`
--
ALTER TABLE `api_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `createdon` (`createdon`),
  ADD KEY `permlevel` (`permlevel`),
  ADD KEY `rate_limited` (`rate_limited`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `category_map`
--
ALTER TABLE `category_map`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categoryid_2` (`categoryid`,`feedid`),
  ADD KEY `categoryid` (`categoryid`),
  ADD KEY `feedid` (`feedid`);

--
-- Indexes for table `developers`
--
ALTER TABLE `developers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `directory_apple`
--
ALTER TABLE `directory_apple`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `itunes_id` (`itunes_id`),
  ADD KEY `description` (`description`),
  ADD KEY `title_non_english` (`title_non_english`),
  ADD KEY `feed_url` (`feed_url`);

--
-- Indexes for table `feeds_added`
--
ALTER TABLE `feeds_added`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feedid` (`feedid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `time_added` (`time_added`),
  ADD KEY `source` (`source`),
  ADD KEY `processed` (`processed`),
  ADD KEY `developerid` (`developerid`),
  ADD KEY `stage` (`stage`);

--
-- Indexes for table `flags`
--
ALTER TABLE `flags`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `title` (`title`),
  ADD KEY `subgenre` (`subgenre`),
  ADD KEY `itunes_genre_id` (`itunes_genre_id`);

--
-- Indexes for table `newsfeeds`
--
ALTER TABLE `newsfeeds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `url` (`url`),
  ADD KEY `title` (`title`),
  ADD KEY `itunes_id` (`itunes_id`),
  ADD KEY `updated` (`updated`),
  ADD KEY `errors` (`errors`),
  ADD KEY `lasthttpstatus` (`lasthttpstatus`),
  ADD KEY `lastgoodhttpstatus` (`lastgoodhttpstatus`),
  ADD KEY `dead` (`dead`),
  ADD KEY `original_url` (`original_url`),
  ADD KEY `lastcheck` (`lastcheck`),
  ADD KEY `lastupdate` (`lastupdate`),
  ADD KEY `pullnow` (`pullnow`),
  ADD KEY `parsenow` (`parsenow`),
  ADD KEY `newest_item_pubdate` (`newest_item_pubdate`),
  ADD KEY `update_frequency` (`update_frequency`),
  ADD KEY `language` (`language`),
  ADD KEY `priority` (`priority`),
  ADD KEY `chash` (`chash`),
  ADD KEY `item_count` (`item_count`),
  ADD KEY `podcast_locked` (`podcast_locked`),
  ADD KEY `podcast_owner` (`podcast_owner`);

--
-- Indexes for table `nfcategories`
--
ALTER TABLE `nfcategories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `feedid` (`feedid`),
  ADD KEY `catid1` (`catid1`),
  ADD KEY `catid2` (`catid2`),
  ADD KEY `catid3` (`catid3`),
  ADD KEY `catid4` (`catid4`),
  ADD KEY `catid5` (`catid5`),
  ADD KEY `catid6` (`catid6`),
  ADD KEY `catid7` (`catid7`),
  ADD KEY `catid8` (`catid8`),
  ADD KEY `catid9` (`catid9`),
  ADD KEY `catid10` (`catid10`);

--
-- Indexes for table `nfenclosures`
--
ALTER TABLE `nfenclosures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `iid` (`itemid`),
  ADD KEY `type` (`type`),
  ADD KEY `time` (`time`);

--
-- Indexes for table `nfetags`
--
ALTER TABLE `nfetags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `feedid` (`feedid`) USING BTREE,
  ADD KEY `updatedon` (`updatedon`);

--
-- Indexes for table `nffunding`
--
ALTER TABLE `nffunding`
  ADD PRIMARY KEY (`feedid`) USING BTREE,
  ADD KEY `url` (`url`) USING BTREE;

--
-- Indexes for table `nfguids`
--
ALTER TABLE `nfguids`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `feedid` (`feedid`),
  ADD KEY `guid` (`guid`) USING BTREE;

--
-- Indexes for table `nfhashes`
--
ALTER TABLE `nfhashes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `feedid` (`feedid`) USING BTREE,
  ADD KEY `hash` (`hash`),
  ADD KEY `updatedon` (`updatedon`);

--
-- Indexes for table `nfimages`
--
ALTER TABLE `nfimages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `crc32_2` (`crc32`,`feedid`,`id`,`resolution`),
  ADD KEY `feedid` (`feedid`),
  ADD KEY `crc32` (`crc32`),
  ADD KEY `resolution` (`resolution`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `nfitems`
--
ALTER TABLE `nfitems`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `feedid_2` (`feedid`,`guid`) USING BTREE,
  ADD KEY `timeadded` (`timeadded`),
  ADD KEY `feedid` (`feedid`),
  ADD KEY `timestamp` (`timestamp`),
  ADD KEY `purgeable` (`purge`);

--
-- Indexes for table `nfitem_chapters`
--
ALTER TABLE `nfitem_chapters`
  ADD PRIMARY KEY (`itemid`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `nfitem_images`
--
ALTER TABLE `nfitem_images`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `crc32_2` (`crc32`,`episodeid`,`id`,`resolution`),
  ADD KEY `crc32` (`crc32`),
  ADD KEY `resolution` (`resolution`),
  ADD KEY `type` (`type`),
  ADD KEY `episodeid` (`episodeid`) USING BTREE;

--
-- Indexes for table `nfitem_persons`
--
ALTER TABLE `nfitem_persons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `itemid_2` (`itemid`,`name`,`href`),
  ADD KEY `itemid` (`itemid`) USING BTREE,
  ADD KEY `href` (`href`),
  ADD KEY `grp` (`grp`),
  ADD KEY `role` (`role`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `nfitem_socialinteract`
--
ALTER TABLE `nfitem_socialinteract`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `itemid_2` (`itemid`,`uri`),
  ADD KEY `priority` (`priority`),
  ADD KEY `itemid` (`itemid`),
  ADD KEY `protocol` (`protocol`),
  ADD KEY `accountId` (`accountId`);

--
-- Indexes for table `nfitem_soundbites`
--
ALTER TABLE `nfitem_soundbites`
  ADD KEY `itemid` (`itemid`) USING BTREE,
  ADD KEY `duration` (`duration`);

--
-- Indexes for table `nfitem_transcripts`
--
ALTER TABLE `nfitem_transcripts`
  ADD UNIQUE KEY `itemid_2` (`itemid`,`type`,`language`),
  ADD KEY `type` (`type`),
  ADD KEY `captions` (`captions`),
  ADD KEY `language` (`language`),
  ADD KEY `itemid` (`itemid`) USING BTREE;

--
-- Indexes for table `nfitem_value`
--
ALTER TABLE `nfitem_value`
  ADD PRIMARY KEY (`itemid`) USING BTREE,
  ADD KEY `type` (`type`),
  ADD KEY `createdon` (`createdon`);

--
-- Indexes for table `nflinkage`
--
ALTER TABLE `nflinkage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feedid` (`feedid`);

--
-- Indexes for table `nfliveitems`
--
ALTER TABLE `nfliveitems`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `feedid_2` (`feedid`,`guid`) USING BTREE,
  ADD KEY `timeadded` (`timeadded`),
  ADD KEY `feedid` (`feedid`),
  ADD KEY `timestamp` (`timestamp`),
  ADD KEY `purgeable` (`purge`),
  ADD KEY `startTime` (`start_time`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `nflocations`
--
ALTER TABLE `nflocations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `feedid` (`feedid`);

--
-- Indexes for table `nfmediums`
--
ALTER TABLE `nfmediums`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `feedid` (`feedid`),
  ADD KEY `medium` (`medium`) USING BTREE;

--
-- Indexes for table `nfpersons`
--
ALTER TABLE `nfpersons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role` (`role`),
  ADD KEY `name` (`name`),
  ADD KEY `feedid` (`feedid`) USING BTREE;

--
-- Indexes for table `nfproblematic`
--
ALTER TABLE `nfproblematic`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `feedid` (`feedid`) USING BTREE,
  ADD KEY `hash` (`reason`),
  ADD KEY `updatedon` (`updatedon`);

--
-- Indexes for table `nfpublish`
--
ALTER TABLE `nfpublish`
  ADD PRIMARY KEY (`id`),
  ADD KEY `feedid` (`feedid`),
  ADD KEY `pub_time` (`pub_time`),
  ADD KEY `pub_dow` (`pub_dow`),
  ADD KEY `pub_dom` (`pub_dom`),
  ADD KEY `pub_slice` (`pub_slice`);

--
-- Indexes for table `nfschedule`
--
ALTER TABLE `nfschedule`
  ADD PRIMARY KEY (`feedid`),
  ADD KEY `sun` (`sun`),
  ADD KEY `mon` (`mon`),
  ADD KEY `tue` (`tue`),
  ADD KEY `wed` (`wed`),
  ADD KEY `thu` (`thu`),
  ADD KEY `fri` (`fri`),
  ADD KEY `sat` (`sat`);

--
-- Indexes for table `nfsoundbites`
--
ALTER TABLE `nfsoundbites`
  ADD PRIMARY KEY (`feedid`) USING BTREE,
  ADD KEY `url` (`url`) USING BTREE;

--
-- Indexes for table `nfsphinx`
--
ALTER TABLE `nfsphinx`
  ADD PRIMARY KEY (`feedid`),
  ADD KEY `updatedon` (`updatedon`);

--
-- Indexes for table `nfsubscriptions`
--
ALTER TABLE `nfsubscriptions`
  ADD PRIMARY KEY (`apitoken`,`subscriberid`,`feedid`),
  ADD KEY `apitoken` (`apitoken`),
  ADD KEY `subscriberid` (`subscriberid`),
  ADD KEY `feedid` (`feedid`),
  ADD KEY `updated` (`updated`);

--
-- Indexes for table `nfvalue`
--
ALTER TABLE `nfvalue`
  ADD PRIMARY KEY (`feedid`),
  ADD KEY `type` (`type`),
  ADD KEY `createdon` (`createdon`);

--
-- Indexes for table `owners`
--
ALTER TABLE `owners`
  ADD PRIMARY KEY (`id`),
  ADD KEY `email` (`email`) USING BTREE,
  ADD KEY `feedid` (`feedid`);

--
-- Indexes for table `podcasts`
--
ALTER TABLE `podcasts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `upid` (`upid`) USING BTREE,
  ADD UNIQUE KEY `feedid` (`feedid`) USING BTREE,
  ADD UNIQUE KEY `owner_and_feed` (`ownerid`,`feedid`),
  ADD KEY `ownerid` (`ownerid`),
  ADD KEY `validation_code` (`validation_code`);

--
-- Indexes for table `prefs`
--
ALTER TABLE `prefs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pubsub`
--
ALTER TABLE `pubsub`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `feedid` (`feedid`),
  ADD KEY `last_sub_time` (`lease_expire`),
  ADD KEY `sub_url` (`hub_url`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `subgenres`
--
ALTER TABLE `subgenres`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `title` (`title`);

--
-- Indexes for table `tos_accept`
--
ALTER TABLE `tos_accept`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `userid_2` (`userid`,`version`),
  ADD KEY `userid` (`userid`),
  ADD KEY `version` (`version`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `developer` (`developer`) USING BTREE,
  ADD KEY `tos` (`tos`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `api_tokens`
--
ALTER TABLE `api_tokens`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category_map`
--
ALTER TABLE `category_map`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `developers`
--
ALTER TABLE `developers`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `directory_apple`
--
ALTER TABLE `directory_apple`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feeds_added`
--
ALTER TABLE `feeds_added`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `newsfeeds`
--
ALTER TABLE `newsfeeds`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nfcategories`
--
ALTER TABLE `nfcategories`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nfenclosures`
--
ALTER TABLE `nfenclosures`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'Enclosure id';

--
-- AUTO_INCREMENT for table `nfetags`
--
ALTER TABLE `nfetags`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nfguids`
--
ALTER TABLE `nfguids`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nfhashes`
--
ALTER TABLE `nfhashes`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nfimages`
--
ALTER TABLE `nfimages`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nfitems`
--
ALTER TABLE `nfitems`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nfitem_images`
--
ALTER TABLE `nfitem_images`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nfitem_persons`
--
ALTER TABLE `nfitem_persons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nfitem_socialinteract`
--
ALTER TABLE `nfitem_socialinteract`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nflinkage`
--
ALTER TABLE `nflinkage`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nfliveitems`
--
ALTER TABLE `nfliveitems`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nflocations`
--
ALTER TABLE `nflocations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nfmediums`
--
ALTER TABLE `nfmediums`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nfpersons`
--
ALTER TABLE `nfpersons`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nfproblematic`
--
ALTER TABLE `nfproblematic`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nfpublish`
--
ALTER TABLE `nfpublish`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `owners`
--
ALTER TABLE `owners`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `podcasts`
--
ALTER TABLE `podcasts`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pubsub`
--
ALTER TABLE `pubsub`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subgenres`
--
ALTER TABLE `subgenres`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tos_accept`
--
ALTER TABLE `tos_accept`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `api_tokens`
--
ALTER TABLE `api_tokens`
  ADD CONSTRAINT `api_tokens_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `developers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `category_map`
--
ALTER TABLE `category_map`
  ADD CONSTRAINT `category_map_ibfk_1` FOREIGN KEY (`categoryid`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `category_map_ibfk_2` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `feeds_added`
--
ALTER TABLE `feeds_added`
  ADD CONSTRAINT `feeds_added_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `feeds_added_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `feeds_added_ibfk_3` FOREIGN KEY (`developerid`) REFERENCES `developers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `genres`
--
ALTER TABLE `genres`
  ADD CONSTRAINT `subgenre` FOREIGN KEY (`subgenre`) REFERENCES `genres` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `newsfeeds`
--
ALTER TABLE `newsfeeds`
  ADD CONSTRAINT `newsfeeds_ibfk_3` FOREIGN KEY (`itunes_id`) REFERENCES `directory_apple` (`itunes_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `nfcategories`
--
ALTER TABLE `nfcategories`
  ADD CONSTRAINT `nfcategories_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nfcategories_ibfk_10` FOREIGN KEY (`catid9`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `nfcategories_ibfk_11` FOREIGN KEY (`catid10`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `nfcategories_ibfk_2` FOREIGN KEY (`catid1`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `nfcategories_ibfk_3` FOREIGN KEY (`catid2`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `nfcategories_ibfk_4` FOREIGN KEY (`catid3`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `nfcategories_ibfk_5` FOREIGN KEY (`catid4`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `nfcategories_ibfk_6` FOREIGN KEY (`catid5`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `nfcategories_ibfk_7` FOREIGN KEY (`catid6`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `nfcategories_ibfk_8` FOREIGN KEY (`catid7`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `nfcategories_ibfk_9` FOREIGN KEY (`catid8`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `nfenclosures`
--
ALTER TABLE `nfenclosures`
  ADD CONSTRAINT `nfenclosures_ibfk_1` FOREIGN KEY (`itemid`) REFERENCES `nfitems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nffunding`
--
ALTER TABLE `nffunding`
  ADD CONSTRAINT `nffunding_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfguids`
--
ALTER TABLE `nfguids`
  ADD CONSTRAINT `nfguids_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfhashes`
--
ALTER TABLE `nfhashes`
  ADD CONSTRAINT `nfhashes_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfimages`
--
ALTER TABLE `nfimages`
  ADD CONSTRAINT `nfimages_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfitems`
--
ALTER TABLE `nfitems`
  ADD CONSTRAINT `nfitems_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfitem_chapters`
--
ALTER TABLE `nfitem_chapters`
  ADD CONSTRAINT `nfitem_chapters_ibfk_1` FOREIGN KEY (`itemid`) REFERENCES `nfitems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfitem_images`
--
ALTER TABLE `nfitem_images`
  ADD CONSTRAINT `nfitem_images_ibfk_1` FOREIGN KEY (`episodeid`) REFERENCES `nfitems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfitem_persons`
--
ALTER TABLE `nfitem_persons`
  ADD CONSTRAINT `nfitem_persons_ibfk_1` FOREIGN KEY (`itemid`) REFERENCES `nfitems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfitem_socialinteract`
--
ALTER TABLE `nfitem_socialinteract`
  ADD CONSTRAINT `nfitem_socialinteract_ibfk_1` FOREIGN KEY (`itemid`) REFERENCES `nfitems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfitem_soundbites`
--
ALTER TABLE `nfitem_soundbites`
  ADD CONSTRAINT `nfitem_soundbites_ibfk_1` FOREIGN KEY (`itemid`) REFERENCES `nfitems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfitem_transcripts`
--
ALTER TABLE `nfitem_transcripts`
  ADD CONSTRAINT `nfitem_transcripts_ibfk_1` FOREIGN KEY (`itemid`) REFERENCES `nfitems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfitem_value`
--
ALTER TABLE `nfitem_value`
  ADD CONSTRAINT `nfitem_value_ibfk_1` FOREIGN KEY (`itemid`) REFERENCES `nfitems` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfliveitems`
--
ALTER TABLE `nfliveitems`
  ADD CONSTRAINT `nfliveitems_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nflocations`
--
ALTER TABLE `nflocations`
  ADD CONSTRAINT `nflocations_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfmediums`
--
ALTER TABLE `nfmediums`
  ADD CONSTRAINT `nfmediums_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfproblematic`
--
ALTER TABLE `nfproblematic`
  ADD CONSTRAINT `nfproblematic_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfpublish`
--
ALTER TABLE `nfpublish`
  ADD CONSTRAINT `nfpublish_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfschedule`
--
ALTER TABLE `nfschedule`
  ADD CONSTRAINT `nfschedule_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfsphinx`
--
ALTER TABLE `nfsphinx`
  ADD CONSTRAINT `nfsphinx_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfsubscriptions`
--
ALTER TABLE `nfsubscriptions`
  ADD CONSTRAINT `nfsubscriptions_ibfk_1` FOREIGN KEY (`apitoken`) REFERENCES `api_tokens` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nfsubscriptions_ibfk_2` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nfvalue`
--
ALTER TABLE `nfvalue`
  ADD CONSTRAINT `nfvalue_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `owners`
--
ALTER TABLE `owners`
  ADD CONSTRAINT `owners_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `podcasts`
--
ALTER TABLE `podcasts`
  ADD CONSTRAINT `podcasts_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `podcasts_ibfk_2` FOREIGN KEY (`ownerid`) REFERENCES `owners` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `prefs`
--
ALTER TABLE `prefs`
  ADD CONSTRAINT `prefs_ibfk_1` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pubsub`
--
ALTER TABLE `pubsub`
  ADD CONSTRAINT `pubsub_ibfk_1` FOREIGN KEY (`feedid`) REFERENCES `newsfeeds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sessions`
--
ALTER TABLE `sessions`
  ADD CONSTRAINT `sessions_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tos_accept`
--
ALTER TABLE `tos_accept`
  ADD CONSTRAINT `tos_accept_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`developer`) REFERENCES `developers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
