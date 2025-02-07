SET @DEFAULT_HOST = ''; -- Please fill with name of your current host name

BEGIN;
DELIMITER ##
CREATE PROCEDURE update_server_host(IN DEFAULT_HOST TEXT)
BEGIN
        START TRANSACTION;
        SET FOREIGN_KEY_CHECKS = 0;
        SET @DEFAULT_HOST = DEFAULT_HOST;
        IF DEFAULT_HOST = '' THEN
                SELECT 'Please fill @DEFAULT_HOST parameter' as Error;
                ROLLBACK;
        ELSE
                ALTER TABLE `push_session` DROP INDEX `i_push_usn`;
                ALTER TABLE `push_session` DROP INDEX `i_push_ut`;
                ALTER TABLE `push_session` ADD COLUMN `server_host` VARCHAR (191) NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `push_session` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `push_session` ADD PRIMARY KEY (`server_host`, `username`(191), `timestamp`);
                ALTER TABLE `push_session` ADD UNIQUE INDEX `i_push_session_susn` (`server_host`, `username`(191), `service`(191), `node`(191));
                ALTER TABLE `push_session` ADD INDEX `i_push_session_sh_username_timestamp` (`server_host`, `username`(191), `timestamp`);
                ALTER TABLE `roster_version` DROP PRIMARY KEY;
                ALTER TABLE `roster_version` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `roster_version` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `roster_version` ADD PRIMARY KEY (`server_host`, `username`);
                ALTER TABLE `muc_online_room` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `host`;
                ALTER TABLE `muc_online_room` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `motd` DROP PRIMARY KEY;
                ALTER TABLE `motd` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `motd` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `motd` ADD PRIMARY KEY (`server_host`, `username`);
                ALTER TABLE `rosterusers` DROP INDEX `i_rosteru_username`;
                ALTER TABLE `rosterusers` DROP INDEX `i_rosteru_jid`;
                ALTER TABLE `rosterusers` DROP INDEX `i_rosteru_user_jid`;
                ALTER TABLE `rosterusers` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `rosterusers` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `rosterusers` ADD UNIQUE INDEX `i_rosteru_sh_user_jid` (`server_host`, `username`(75), `jid`(75));
                ALTER TABLE `rosterusers` ADD INDEX `i_rosteru_sh_jid` (`server_host`, `jid`);
                ALTER TABLE `private_storage` DROP INDEX `i_private_storage_username_namespace`;
                ALTER TABLE `private_storage` DROP INDEX `i_private_storage_username`;
                ALTER TABLE `private_storage` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `private_storage` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `private_storage` ADD PRIMARY KEY (`server_host`, `username`, `namespace`);
                ALTER TABLE `mqtt_pub` DROP INDEX `i_mqtt_topic`;
                ALTER TABLE `mqtt_pub` ADD COLUMN `server_host` VARCHAR (191) NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `mqtt_pub` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `mqtt_pub` ADD UNIQUE INDEX `i_mqtt_topic_server` (`topic`(191), `server_host`);
                ALTER TABLE `vcard_search` DROP PRIMARY KEY;
                ALTER TABLE `vcard_search` DROP INDEX `i_vcard_search_lgiven`;
                ALTER TABLE `vcard_search` DROP INDEX `i_vcard_search_lmiddle`;
                ALTER TABLE `vcard_search` DROP INDEX `i_vcard_search_lnickname`;
                ALTER TABLE `vcard_search` DROP INDEX `i_vcard_search_lbday`;
                ALTER TABLE `vcard_search` DROP INDEX `i_vcard_search_lctry`;
                ALTER TABLE `vcard_search` DROP INDEX `i_vcard_search_lfn`;
                ALTER TABLE `vcard_search` DROP INDEX `i_vcard_search_lemail`;
                ALTER TABLE `vcard_search` DROP INDEX `i_vcard_search_lorgunit`;
                ALTER TABLE `vcard_search` DROP INDEX `i_vcard_search_llocality`;
                ALTER TABLE `vcard_search` DROP INDEX `i_vcard_search_lorgname`;
                ALTER TABLE `vcard_search` DROP INDEX `i_vcard_search_lfamily`;
                ALTER TABLE `vcard_search` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `lusername`;
                ALTER TABLE `vcard_search` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `vcard_search` ADD INDEX `i_vcard_search_sh_lfn` (`server_host`, `lfn`);
                ALTER TABLE `vcard_search` ADD INDEX `i_vcard_search_sh_llocality` (`server_host`, `llocality`);
                ALTER TABLE `vcard_search` ADD PRIMARY KEY (`server_host`, `lusername`);
                ALTER TABLE `vcard_search` ADD INDEX `i_vcard_search_sh_lnickname` (`server_host`, `lnickname`);
                ALTER TABLE `vcard_search` ADD INDEX `i_vcard_search_sh_lctry` (`server_host`, `lctry`);
                ALTER TABLE `vcard_search` ADD INDEX `i_vcard_search_sh_lgiven` (`server_host`, `lgiven`);
                ALTER TABLE `vcard_search` ADD INDEX `i_vcard_search_sh_lmiddle` (`server_host`, `lmiddle`);
                ALTER TABLE `vcard_search` ADD INDEX `i_vcard_search_sh_lorgname` (`server_host`, `lorgname`);
                ALTER TABLE `vcard_search` ADD INDEX `i_vcard_search_sh_lfamily` (`server_host`, `lfamily`);
                ALTER TABLE `vcard_search` ADD INDEX `i_vcard_search_sh_lbday` (`server_host`, `lbday`);
                ALTER TABLE `vcard_search` ADD INDEX `i_vcard_search_sh_lemail` (`server_host`, `lemail`);
                ALTER TABLE `vcard_search` ADD INDEX `i_vcard_search_sh_lorgunit` (`server_host`, `lorgunit`);
                ALTER TABLE `last` DROP PRIMARY KEY;
                ALTER TABLE `last` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `last` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `last` ADD PRIMARY KEY (`server_host`, `username`);
                ALTER TABLE `sr_group` DROP INDEX `i_sr_group_name`;
                ALTER TABLE `sr_group` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `name`;
                ALTER TABLE `sr_group` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `sr_group` ADD UNIQUE INDEX `i_sr_group_sh_name` (`server_host`, `name`);
                ALTER TABLE `muc_registered` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `host`;
                ALTER TABLE `muc_registered` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `sm` DROP INDEX `i_node`;
                ALTER TABLE `sm` DROP INDEX `i_username`;
                ALTER TABLE `sm` DROP INDEX `i_sid`;
                ALTER TABLE `sm` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `sm` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `sm` ADD INDEX `i_sm_node` (`node`(75));
                ALTER TABLE `sm` ADD INDEX `i_sm_sh_username` (`server_host`, `username`);
                ALTER TABLE `sm` ADD PRIMARY KEY (`usec`, `pid`(75));
                ALTER TABLE `privacy_list` DROP INDEX `i_privacy_list_username_name`;
                ALTER TABLE `privacy_list` DROP INDEX `i_privacy_list_username`;
                ALTER TABLE `privacy_list` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `privacy_list` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `privacy_list` ADD UNIQUE INDEX `i_privacy_list_sh_username_name` USING BTREE (`server_host`, `username`(75), `name`(75));
                ALTER TABLE `sr_user` DROP INDEX `i_sr_user_jid`;
                ALTER TABLE `sr_user` DROP INDEX `i_sr_user_grp`;
                ALTER TABLE `sr_user` DROP INDEX `i_sr_user_jid_group`;
                ALTER TABLE `sr_user` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `jid`;
                ALTER TABLE `sr_user` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `sr_user` ADD UNIQUE INDEX `i_sr_user_sh_jid_group` (`server_host`, `jid`, `grp`);
                ALTER TABLE `sr_user` ADD INDEX `i_sr_user_sh_grp` (`server_host`, `grp`);
                ALTER TABLE `muc_online_users` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `host`;
                ALTER TABLE `muc_online_users` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `vcard` DROP PRIMARY KEY;
                ALTER TABLE `vcard` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `vcard` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `vcard` ADD PRIMARY KEY (`server_host`, `username`);
                ALTER TABLE `archive_prefs` DROP PRIMARY KEY;
                ALTER TABLE `archive_prefs` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `archive_prefs` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `archive_prefs` ADD PRIMARY KEY (`server_host`, `username`);
                ALTER TABLE `mix_pam` DROP INDEX `i_mix_pam`;
                ALTER TABLE `mix_pam` DROP INDEX `i_mix_pam_u`;
                ALTER TABLE `mix_pam` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `mix_pam` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `mix_pam` ADD UNIQUE INDEX `i_mix_pam` (`username`(191), `server_host`, `channel`(191), `service`(191));
                ALTER TABLE `route` CHANGE COLUMN `server_host` `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL;
                ALTER TABLE `users` DROP PRIMARY KEY;
                ALTER TABLE `users` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `users` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `users` ADD PRIMARY KEY (`server_host`, `username`);
                ALTER TABLE `privacy_default_list` DROP PRIMARY KEY;
                ALTER TABLE `privacy_default_list` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `privacy_default_list` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `privacy_default_list` ADD PRIMARY KEY (`server_host`, `username`);
                ALTER TABLE `rostergroups` DROP INDEX `pk_rosterg_user_jid`;
                ALTER TABLE `rostergroups` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `rostergroups` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `rostergroups` ADD INDEX `i_rosterg_sh_user_jid` (`server_host`, `username`(75), `jid`(75));
                ALTER TABLE `muc_room` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `host`;
                ALTER TABLE `muc_room` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `spool` DROP INDEX `i_despool`;
                ALTER TABLE `spool` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `spool` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `spool` ADD INDEX `i_spool_sh_username` USING BTREE (`server_host`, `username`);
                ALTER TABLE `archive` DROP INDEX `i_username_timestamp`;
                ALTER TABLE `archive` DROP INDEX `i_username_peer`;
                ALTER TABLE `archive` DROP INDEX `i_username_bare_peer`;
                ALTER TABLE `archive` DROP INDEX `i_timestamp`;
                ALTER TABLE `archive` ADD COLUMN `server_host` VARCHAR (191) COLLATE `utf8mb4_unicode_ci` NOT NULL DEFAULT @DEFAULT_HOST AFTER `username`;
                ALTER TABLE `archive` ALTER COLUMN `server_host` DROP DEFAULT;
                ALTER TABLE `archive` ADD INDEX `i_archive_sh_username_bare_peer` USING BTREE (`server_host`, `username`, `bare_peer`);
                ALTER TABLE `archive` ADD INDEX `i_archive_sh_timestamp` USING BTREE (`server_host`, `timestamp`);
                ALTER TABLE `archive` ADD INDEX `i_archive_sh_username_timestamp` USING BTREE (`server_host`, `username`, `timestamp`);
                ALTER TABLE `archive` ADD INDEX `i_archive_sh_username_peer` USING BTREE (`server_host`, `username`, `peer`);
        END IF;
        SET FOREIGN_KEY_CHECKS = 1;
END;
##
DELIMITER ;

CALL update_server_host(@DEFAULT_HOST);

DROP PROCEDURE update_server_host;

COMMIT;
