--==============================================================
-- Table: in_wartungsplan_status_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_wartungsplan_status_per
   generated from Powerdesigner on Dienstag, 2. Mai 2023 09:47:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_wartungsplan_status_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wart_plan_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wartungsplan'),
wart_plan_status_id STRING(5) NOT NULL
OPTIONS(description='Status of the maintenace plan (for example relevant = I0320)'),
status_fg BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichen: Status inaktiv (flag indicating if the status is active or inactive)'),
dat_von DATE NOT NULL OPTIONS(description='Gültig von'),
dat_bis DATE OPTIONS(description='Gültig bis'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wart_plan_id, wart_plan_status_id, dat_von) NOT ENFORCED
)
OPTIONS(description='Wartungsplan Status  SAP IND (historical information for statuses of  maintenance plans. A maintenanca plan is a type of Work Plan (in_plangruppe))');