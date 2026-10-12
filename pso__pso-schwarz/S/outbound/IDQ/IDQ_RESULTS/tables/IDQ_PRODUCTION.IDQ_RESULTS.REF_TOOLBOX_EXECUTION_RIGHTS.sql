CREATE OR REPLACE TABLE idq_production_idq_results.ref_toolbox_execution_rights (
id BIGNUMERIC(38,0) NOT NULL,
mstr_user STRING(1000),
syscheck_exclude_flag BIGNUMERIC(38,0) NOT NULL,
syscheck_parameter_flag BIGNUMERIC(38,0) NOT NULL,
syscheck_alerts_flag BIGNUMERIC(38,0) NOT NULL,
syscomp_exclude_flag BIGNUMERIC(38,0) NOT NULL,
syscomp_parameter_flag BIGNUMERIC(38,0) NOT NULL,
syscomp_alerts_flag BIGNUMERIC(38,0) NOT NULL,
relevance_exclude_flag BIGNUMERIC(38,0) NOT NULL,
relevance_parameter_flag BIGNUMERIC(38,0) NOT NULL,
relevance_alerts_flag BIGNUMERIC(38,0) NOT NULL,
rule_catalog_flag BIGNUMERIC(38,0) NOT NULL,
toolbox_admin_flag BIGNUMERIC(38,0) NOT NULL,
mail_kfl_ek_nr_flag BIGNUMERIC(38,0) NOT NULL,
mail_sp_flag BIGNUMERIC(38,0) NOT NULL,
PRIMARY KEY (id) NOT ENFORCED
);