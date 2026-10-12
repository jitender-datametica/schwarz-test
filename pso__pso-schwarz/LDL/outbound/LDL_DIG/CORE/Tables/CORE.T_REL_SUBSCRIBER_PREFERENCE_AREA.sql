CREATE TABLE IF NOT EXISTS ldl_dig_core.t_rel_subscriber_preference_area (
country_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for a country according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
subscr_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the customer'),
subscr_pref_area_cd STRING(20) NOT NULL OPTIONS(description='The code for the area subscriber is interested in'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
subscr_status_cd STRING(5)
OPTIONS(description='The code for the status of  subscription to particular area ( requested, unsubscribed, subscribed)'),
subscr_channel_name STRING(100) OPTIONS(description='The name that defines the channel of customer subscription'),
subscr_origin_form_name STRING(100) OPTIONS(description='The name of the form for origin of customer subscription'),
legal_txt_version_name STRING(100) OPTIONS(description='Legal Text version name'),
subscr_tmsp TIMESTAMP OPTIONS(description='The timestamp when the actual subscription took place'),
subscr_processed_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the request for subscribing took place'),
unsubscr_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the actual unsubscription took place'),
unsubscr_processed_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the request for unsubscribing took place'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (country_cd, subscr_sid, subscr_pref_area_cd, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='Subscriber can subscribe to different areas of interest');