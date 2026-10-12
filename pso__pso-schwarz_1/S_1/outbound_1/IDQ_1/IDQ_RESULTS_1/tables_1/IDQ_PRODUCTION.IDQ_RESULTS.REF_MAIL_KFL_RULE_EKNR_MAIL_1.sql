CREATE OR REPLACE TABLE idq_production_idq_results.ref_mail_kfl_rule_eknr_mail_1 (
id BIGNUMERIC(38,0) NOT NULL,
country_id BIGNUMERIC(38,0) NOT NULL,
rule_id BIGNUMERIC(38,0) NOT NULL,
mail_ek_nr_id BIGNUMERIC(38,0),
mail_id BIGNUMERIC(38,0) NOT NULL,
ref_mail_kfl_rule_eknr_flag_id BIGNUMERIC(38,0) NOT NULL,
PRIMARY KEY (id) NOT ENFORCED
);