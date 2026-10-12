CREATE OR REPLACE TABLE idq_production_idq_results.reporting_test_list (
id BIGNUMERIC(38,0) NOT NULL,
date_of_test_run DATETIME,
test_object_id BIGNUMERIC(38,0),
rule_id BIGNUMERIC(38,0) NOT NULL,
in_report_included BIGNUMERIC(38,0),
test_run_day_id BIGNUMERIC(38,0),
PRIMARY KEY (id) NOT ENFORCED
);