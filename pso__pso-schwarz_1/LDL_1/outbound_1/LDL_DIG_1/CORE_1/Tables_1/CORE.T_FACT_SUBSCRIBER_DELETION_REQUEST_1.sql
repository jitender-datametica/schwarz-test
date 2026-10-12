CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_subscriber_deletion_request_1 (
subscr_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the customer'),
country_cd STRING(5)
OPTIONS(description='The unique code for a country_1 according to ISO-3166 Alpha-2. ( -1 if not filled when request comes for global deletion)'),
deletion_requested_tmsp TIMESTAMP NOT NULL OPTIONS(description='Deletion request date'),
is_deletion_completed_fg BOOL OPTIONS(description='Deletion status_1 flag'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (subscr_sid, deletion_requested_tmsp) NOT ENFORCED
)
OPTIONS(description='The request to delete a subscriber. If subscriber has sso_id it should be deleted for all countries. If subscriber does not have an SSO_ID filled the deletion happens only for selected country.');