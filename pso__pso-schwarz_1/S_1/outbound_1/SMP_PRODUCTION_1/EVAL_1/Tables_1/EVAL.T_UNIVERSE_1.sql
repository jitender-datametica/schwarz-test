CREATE OR REPLACE TABLE smp_production_eval.t_universe_1 (
division_id STRING(100) NOT NULL OPTIONS(description='Division Lidl or Kaufland (LDL/KFL)'),
country_id STRING(100) NOT NULL OPTIONS(description='Country_1 iso code'),
universe_id STRING(100) NOT NULL OPTIONS(description='SMP Universe ID'),
universe_name STRING(1000) NOT NULL
OPTIONS(description='Name of the Universe from jira Task, must match with SMP Universe Name, Alternative key for custom_audience'),
source_system_id STRING(100) NOT NULL OPTIONS(description='Sourcesystem, e.g. DWH, SMP, PIQ'),
create_tmsp DATETIME NOT NULL OPTIONS(description='Creation timestamp_ntz(9)'),
load_id INTEGER NOT NULL OPTIONS(description='Generated load id of the transformation job'),
jira_task_link STRING(1000) DEFAULT '' NOT NULL
OPTIONS(description='link of the jira task in case for the ab universe request'),
advertiser_id_smp STRING(100) OPTIONS(description='identifier advertiser smp source')
);