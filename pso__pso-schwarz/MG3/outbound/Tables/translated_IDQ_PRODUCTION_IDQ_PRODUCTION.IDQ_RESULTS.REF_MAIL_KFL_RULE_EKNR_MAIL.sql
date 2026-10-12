CREATE OR REPLACE TABLE idq_production_idq_results.ref_mail_kfl_rule_eknr_mail (
id INTEGER NOT NULL,
country_id INTEGER NOT NULL,
rule_id INTEGER NOT NULL,
mail_ek_nr_id INTEGER,
mail_id INTEGER NOT NULL,
ref_mail_kfl_rule_eknr_flag_id INTEGER NOT NULL,
PRIMARY KEY (id) NOT ENFORCED
);