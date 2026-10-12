CREATE OR REPLACE TABLE smp_production_etl_process.t_ab_universe_cell_group_1 (
division_id STRING(100) NOT NULL OPTIONS(description='LDL or KFL'),
country_id STRING(100) NOT NULL OPTIONS(description='Country_1 Iso Code'),
universe_name STRING(100) NOT NULL
OPTIONS(description='Name of the Universe from jira Task, must match with SMP Universe Name'),
jira_task_link STRING(1000) DEFAULT '' NOT NULL
OPTIONS(description='Link of the jira task for the AB universe request '),
shopper_id STRING(100) NOT NULL OPTIONS(description='Reference to the shopper_1 '),
cell_group_id STRING(10) NOT NULL OPTIONS(description='Cell group A/B (Test_1/Control)'),
advertiser_id_smp STRING(100) OPTIONS(description='Referenct to the SMP Advertiser'),
create_tmsp DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='timestamp_ntz(9) of creation, only for information, current_timestamp of inserting the data')
);