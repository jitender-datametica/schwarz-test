/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_SUBSCRIBER_EMAIL_ENGAGEMENT_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 15. Juni 2022 16:53:17
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_subscriber_email_engagement_2 (
subscr_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the subscriber'),
job_id BIGNUMERIC NOT NULL OPTIONS(description='The jobid number of the respective engagement event job '),
email_name STRING(100)
OPTIONS(description='The name of the email for specific event job (email name associated with jobid) '),
engagement_event_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp when the engagement event happened'),
engagement_event_cd STRING(5) OPTIONS(description='The unique code to identify the engagement event'),
email_link_name STRING(1024) OPTIONS(description='The name of the link present in the email '),
email_link_content_txt STRING(16777216) OPTIONS(description='The text content of the link present in the email'),
bounce_category_id BIGNUMERIC OPTIONS(description='The numeric identifier to uniquely identify the bounce categories'),
country_cd STRING(5)
OPTIONS(description='The unique code for a country_2 according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
coupon_cd STRING(50) OPTIONS(description='The business key that uniquely identifies a coupon'),
batch_id BIGNUMERIC OPTIONS(description='The identical number for batch associated with the group of jobs'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (subscr_sid, job_id, engagement_event_tmsp) NOT ENFORCED
) OPTIONS(description='The fact holds the email engagement events of subscribers');