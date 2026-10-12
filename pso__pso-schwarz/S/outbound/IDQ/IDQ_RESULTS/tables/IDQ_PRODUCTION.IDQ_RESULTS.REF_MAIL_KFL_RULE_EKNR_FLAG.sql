CREATE OR REPLACE TABLE idq_production_idq_results.ref_mail_kfl_rule_eknr_flag (
id BIGNUMERIC(38,0) NOT NULL,
rule_id BIGNUMERIC(38,0) NOT NULL,
country_id BIGNUMERIC(38,0) NOT NULL,
ek_nr_flag BIGNUMERIC(38,0),
PRIMARY KEY (id) NOT ENFORCED
);