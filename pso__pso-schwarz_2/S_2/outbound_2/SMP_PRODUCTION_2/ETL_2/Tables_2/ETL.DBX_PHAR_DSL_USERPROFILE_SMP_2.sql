CREATE OR REPLACE TABLE smp_production_etl.dbx_phar_dsl_userprofile_smp_2 (
customer_id STRING(16777216),
country_2 STRING(16777216),
last_legal_terms_accepted_ts DATETIME,
last_legal_terms_declined_ts DATETIME,
last_countrychange_ts DATETIME,
notification_push_enabled BOOL,
notification_mail_enabled BOOL,
notification_sms_enabled BOOL,
notification_postal_enabled BOOL,
last_notificationchange_ts DATETIME,
active_country STRING(16777216),
alcohol_content_allowed BOOL,
alcohol_content_allowed_ts DATETIME,
load_tms_utc DATETIME NOT NULL,
retailer_id STRING(16777216) NOT NULL
);