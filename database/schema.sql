CREATE TABLE `migrations` (
  `migration` varchar(255) not null, 
  `batch` integer not null
);

CREATE TABLE `users` (
  `id` integer not null primary key auto_increment, 
  `name` varchar(255) not null, 
  `email` varchar(255) not null, 
  `password` varchar(255) not null, 
  `remember_token` varchar(255) null, 
  `created_at` datetime not null, 
  `updated_at` datetime not null
);

CREATE UNIQUE INDEX users_email_unique on `users` (`email`);

CREATE TABLE `password_resets` (
  `email` varchar(255) not null, 
  `token` varchar(255) not null, 
  `created_at` datetime not null
);

CREATE INDEX password_resets_email_index on `password_resets` (`email`);
CREATE INDEX password_resets_token_index on `password_resets` (`token`);

CREATE TABLE `systems` (
  `id` varchar(255) not null, 
  `created_at` datetime not null, 
  `updated_at` datetime not null,
  `contact_name` varchar(255) null, 
  `contact_email` varchar(255) null, 
  `website` varchar(255) null
);

CREATE TABLE `systems_bodies` (
  `system_id` integer not null, 
  `body_id` integer not null, 
  
  foreign key(`system_id`) references `systems`(`id`) on delete cascade, 
  foreign key(`body_id`) references `bodies`(`id`) on delete cascade
);

CREATE TABLE `bodies` (
  `id` integer not null primary key auto_increment, 
  `created_at` datetime not null, 
  `updated_at` datetime not null, 
  `short_name` varchar(255) not null, 
  `name` varchar(255) not null, 
  `website` varchar(255) null, 
  `license` varchar(255) null, 
  `license_valid_since` date null, 
  `rgs` varchar(255) not null, 
  `equivalent_body` text null, 
  `contact_email` varchar(255) null, 
  `contact_name` varchar(255) null, 
  `system_id` integer null, 
  `keyword` text null, 
  `classification` varchar(255) null, 
  
  foreign key(`system_id`) references `systems`(`id`)
);

CREATE UNIQUE INDEX bodies_short_name_unique on `bodies` (`short_name`);
CREATE UNIQUE INDEX bodies_name_unique on `bodies` (`name`);

CREATE TABLE `people` (
  `id` integer not null primary key auto_increment, 
  `created_at` datetime not null, 
  `updated_at` datetime not null, 
  `body_id` integer null, 
  `name` varchar(255) not null, 
  `family_name` varchar(255) null, 
  `given_name` varchar(255) null, 
  `form_of_address` varchar(255) null, 
  `title` varchar(255) null, 
  `gender` varchar(255) null, 
  `phone` varchar(255) null, 
  `email` varchar(255) null, 
  `street_address` varchar(255) null, 
  `postal_code` varchar(255) null, 
  `locality` varchar(255) null, 
  `status` varchar(255) null, 
  `keyword` text null, 
  
  foreign key(`body_id`) references `bodies`(`id`)
);

CREATE TABLE `legislativeterms` (
  `id` integer not null primary key auto_increment, 
  `created_at` datetime not null, 
  `updated_at` datetime not null, 
  `body_id` integer not null, 
  `name` varchar(255) not null, 
  `start_date` date null, 
  `end_date` date null, 
  
  foreign key(`body_id`) references `bodies`(`id`)
);

CREATE TABLE `organizations` (
  `id` integer not null primary key auto_increment, 
  `created_at` datetime not null, 
  `updated_at` datetime not null, 
  `body_id` integer null, 
  `name` varchar(255) not null, 
  `short_name` varchar(255) not null, 
  `post` varchar(255) null, 
  `suborganization_of` integer null, 
  `classification` varchar(255) null, 
  `keyword` text null,
  `start_date` date null, 
  `end_date` date null, 
  `website` varchar(255) null, 

  foreign key(`body_id`) references `bodies`(`id`) on delete cascade, 
  foreign key(`suborganization_of`) references `organizations`(`id`) on delete cascade
);

CREATE UNIQUE INDEX organizations_name_unique on `organizations` (`name`);
CREATE UNIQUE INDEX organizations_short_name_unique on `organizations` (`short_name`);

CREATE TABLE `memberships` (
  `id` integer not null primary key auto_increment, 
  `created_at` datetime not null, 
  `updated_at` datetime not null, 
  `person_id` integer null, 
  `organization_id` integer null, 
  `role` varchar(255) null, 
  `post` varchar(255) null, 
  `on_behalf_of` varchar(255) null, 
  `voting_right` tinyint null, 
  `start_date` date null, 
  `end_date` date null, 

  foreign key(`person_id`) references `people`(`id`), 
  foreign key(`organization_id`) references `organizations`(`id`)
);

CREATE TABLE `consultations` (
  `id` integer not null primary key auto_increment, 
  `created_at` datetime not null, 
  `updated_at` datetime not null, 
  `paper_id` integer null, 
  `agenda_item_id` integer null, 
  `authoritative` tinyint null, 
  `role` varchar(255) null, 
  `keyword` text null, 

  foreign key(`paper_id`) references `papers`(`id`), 
  foreign key(`agenda_item_id`) references `agendaitems`(`id`)
);

CREATE TABLE `consulations_organizations` (
  `consulation_id` integer not null, 
  `organization_id` integer not null, 

  foreign key(`consulation_id`) references `consultations`(`id`), 
  foreign key(`organization_id`) references `organizations`(`id`)
);

CREATE TABLE `meetings` (
  `id` integer not null primary key auto_increment, 
  `created_at` datetime not null, 
  `updated_at` datetime not null, 
  `start` date not null, 
  `end` date null, 
  `street_address` varchar(255) null, 
  `postal_code` varchar(255) null, 
  `locality` varchar(255) null, 
  `location_id` integer null, 
  `organization_id` integer null, 
  `chair_person_id` integer null, 
  `scribe_id` integer null, 
  `results_protocol_id` integer null, 
  `verbatim_protocol_id` integer null, 
  `keywords` text not null, 

  foreign key(`location_id`) references `locations`(`id`), 
  foreign key(`organization_id`) references `organizations`(`id`), 
  foreign key(`chair_person_id`) references `people`(`id`), 
  foreign key(`scribe_id`) references `people`(`id`), 
  foreign key(`results_protocol_id`) references `files`(`id`), 
  foreign key(`verbatim_protocol_id`) references `files`(`id`)
);

CREATE TABLE `meetings_persons` (
  `meeting_id` integer not null, 
  `participant_id` integer not null, 

  foreign key(`meeting_id`) references `meetings`(`id`), 
  foreign key(`participant_id`) references `people`(`id`)
);

CREATE TABLE `meetings_invitations` (
  `meeting_id` integer not null, 
  `invitation_id` integer not null, 

  foreign key(`meeting_id`) references `meetings`(`id`), 
  foreign key(`invitation_id`) references `files`(`id`)
);

CREATE TABLE `meetings_auxiliary_files` (
  `meeting_id` integer not null, 
  `auxiliary_id` integer not null, 

  foreign key(`meeting_id`) references `meetings`(`id`), 
  foreign key(`auxiliary_id`) references `files`(`id`)
);

CREATE TABLE `files` (
  `id` integer not null primary key auto_increment, 
  `created_at` datetime not null, 
  `updated_at` datetime not null, 
  `file_name` varchar(255) not null, 
  `file_modified` date not null, 
  `name` varchar(255) null,
  `mime_type` varchar(255) null, 
  `date` date not null, 
  `size` integer not null, 
  `sha1_checksum` varchar(255) null, 
  `text` text null, 
  `master_file_id` integer null, 
  `license` varchar(255) null, 
  `file_role` varchar(255) null, 
  `keyword` text null, 

  foreign key(`master_file_id`) references `files`(`id`)
);

CREATE TABLE `files_derivatives` (
  `file_id` integer not null, 
  `derivative_id` integer not null, 

  foreign key(`file_id`) references `files`(`id`), 
  foreign key(`derivative_id`) references `files`(`id`)
);

CREATE TABLE `papers` (
  `id` integer not null primary key auto_increment, 
  `created_at` datetime not null, 
  `updated_at` datetime not null, 
  `name` varchar(255) null, 
  `body_id` integer null, 
  `published_date` date not null, 
  `paper_type` varchar(255) null, 
  `reference` varchar(255) null, 
  `main_file_id` integer null, 
  `keywords` text not null, 
  `under_direction_of_id` integer null, 

  foreign key(`body_id`) references `bodies`(`id`) on delete cascade, 
  foreign key(`main_file_id`) references `files`(`id`), 
  foreign key(`under_direction_of_id`) references `organizations`(`id`)
);

CREATE TABLE `papers_locations` (
  `paper_id` integer not null, 
  `location_id` integer not null, 

  foreign key(`paper_id`) references `papers`(`id`), 
  foreign key(`location_id`) references `locations`(`id`)
);

CREATE TABLE `papers_related_papers` (
  `paper_id` integer not null, 
  `related_id` integer not null, 

  foreign key(`paper_id`) references `papers`(`id`), 
  foreign key(`related_id`) references `papers`(`id`)
);

CREATE TABLE `papers_auxiliary_files` (
  `paper_id` integer not null, 
  `auxiliary_id` integer not null, 

  foreign key(`paper_id`) references `papers`(`id`), 
  foreign key(`auxiliary_id`) references `files`(`id`)
);

CREATE TABLE `papers_originaters` (
  `paper_id` integer not null, 
  `originator_id` integer not null, 

  foreign key(`paper_id`) references `papers`(`id`), 
  foreign key(`originator_id`) references `people`(`id`)
);

CREATE TABLE `agendaitems` (
  `id` integer not null primary key auto_increment, 
  `created_at` datetime not null, 
  `updated_at` datetime not null, 
  `number` varchar(255) null, 
  `meeting_id` integer null, 
  `name` varchar(255) not null, 
  `public` tinyint null, 
  `consulation_id` integer null, 
  `result` varchar(255) null, 
  `resolution_id` integer null, 
  `keywords` text not null, 

  foreign key(`meeting_id`) references `meetings`(`id`), 
  foreign key(`consulation_id`) references `consultations`(`id`), 
  foreign key(`resolution_id`) references `files`(`id`)
);

CREATE TABLE `agendaitems_auxiliary_files` (
  `agendaitem_id` integer not null, 
  `auxiliary_id` integer not null, 
  `order` integer not null, 

  foreign key(`agendaitem_id`) references `agendaitems`(`id`), 
  foreign key(`auxiliary_id`) references `files`(`id`)
);

CREATE TABLE `locations` (
  `id` integer not null primary key auto_increment, 
  `created_at` datetime not null, 
  `updated_at` datetime not null, 
  `description` varchar(255) null, 
  `address` varchar(255) null, 
  `geometry` varchar(255) null, 
  `keyword` text null
);
