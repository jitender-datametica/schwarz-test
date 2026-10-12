CREATE OR REPLACE TABLE ldl_data_production_meta.t_data_quality_issue_2 (
dq_issue_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the data quality issue.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
dq_issue_name STRING(250) NOT NULL OPTIONS(description='The name by which the data quality issue is known.'),
dq_issue_creation_dt DATE NOT NULL
OPTIONS(description='The date when the data quality issue was first observed. (In case the issue is closed and re_2-opened after some time, the creation date does not change.)'),
dq_issue_status_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the resolution status_2 of a data quality issue.'),
dq_issue_reason_cd STRING(20) OPTIONS(description='The code identifying the root cause for a data quality issue.'),
support_grp_cd STRING(20) OPTIONS(description='The code which identifies the support group.'),
analysis_comment_txt STRING(32000) OPTIONS(description='A free text comment to the analysis of the data quality issue.'),
resolution_comment_txt STRING(32000)
OPTIONS(description='A free text comment to the resolution of the data quality issue.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (dq_issue_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A problem caused by insufficient data quality. A data quality issue is documented by one or several data quality checks. An issue may be resolved and re_2-opened some time later.');