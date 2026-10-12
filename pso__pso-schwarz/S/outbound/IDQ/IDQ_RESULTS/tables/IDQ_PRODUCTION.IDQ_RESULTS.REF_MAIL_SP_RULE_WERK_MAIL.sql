CREATE OR REPLACE TABLE idq_production_idq_results.ref_mail_sp_rule_werk_mail (
id BIGNUMERIC(38,0) NOT NULL,
rule_id BIGNUMERIC(38,0) NOT NULL,
ref_mail_sp_werk_id BIGNUMERIC(38,0),
ref_mail_sp_matart_id BIGNUMERIC(38,0),
ref_mail_sp_wg_id BIGNUMERIC(38,0),
mail_id BIGNUMERIC(38,0) NOT NULL,
PRIMARY KEY (id) NOT ENFORCED
);