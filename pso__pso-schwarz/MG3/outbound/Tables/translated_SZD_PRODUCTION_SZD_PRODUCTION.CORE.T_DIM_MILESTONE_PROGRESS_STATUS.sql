CREATE OR REPLACE TABLE szd_production_core.t_dim_milestone_progress_status (
milestone_progress_detail_cd STRING(50) NOT NULL
OPTIONS(description='Code for a more detailed status of progress of a lot/container refered to as\'Container Status 1\''),
milestone_progress_overall_cd STRING(50) NOT NULL
OPTIONS(description='Code for broader status of progress of a lot/container refered to as\'Container Status 2\''),
milestone_progress_detail_descr STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - Descriptive text of a more detailed progress status of a lot/container'),
milestone_progress_overall_descr STRING(250) NOT NULL
OPTIONS(description='Descriptive Attribute - Descriptive text of a broader progress status of a lot/container'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (milestone_progress_detail_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - Combination of detailed status codes with a more broader classification of status and it\'s corresponding descriptions. - Source - Manual');