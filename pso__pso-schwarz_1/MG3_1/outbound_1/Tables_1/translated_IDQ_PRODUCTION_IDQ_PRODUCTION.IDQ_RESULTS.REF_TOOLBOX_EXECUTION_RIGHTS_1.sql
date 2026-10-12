CREATE OR REPLACE TABLE idq_production_idq_results.ref_toolbox_execution_rights_1 (
id INTEGER NOT NULL,
mstr_user STRING(1000),
syscheck_exclude_flag INTEGER NOT NULL,
syscheck_parameter_flag INTEGER NOT NULL,
syscheck_alerts_flag INTEGER NOT NULL,
syscomp_exclude_flag INTEGER NOT NULL,
syscomp_parameter_flag INTEGER NOT NULL,
syscomp_alerts_flag INTEGER NOT NULL,
relevance_exclude_flag INTEGER NOT NULL,
relevance_parameter_flag INTEGER NOT NULL,
relevance_alerts_flag INTEGER NOT NULL,
rule_catalog_flag INTEGER NOT NULL,
toolbox_admin_flag INTEGER NOT NULL,
mail_kfl_ek_nr_flag INTEGER NOT NULL,
mail_sp_flag INTEGER NOT NULL,
PRIMARY KEY (id) NOT ENFORCED
);