CREATE OR REPLACE TABLE idq_production_idq_results.ref_mail_sp_rule_werk_flag_1 (
id BIGNUMERIC(38,0) NOT NULL,
rule_id BIGNUMERIC(38,0) NOT NULL,
branch_id BIGNUMERIC(38,0) NOT NULL,
werk_flag BIGNUMERIC(38,0),
matart_flag BIGNUMERIC(38,0),
wg_flag BIGNUMERIC(38,0),
PRIMARY KEY (id) NOT ENFORCED
);