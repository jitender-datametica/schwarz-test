--==============================================================
-- Table: in_wartungsplan_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_wartungsplan_1
   generated from Powerdesigner on Montag, 20. Februar 2023 09:29:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_wartungsplan_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wart_plan_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wartungsplan'),
wart_plan_bez STRING(30) OPTIONS(description='Wartungsplantext'),
wart_plan_sort_id STRING(40) OPTIONS(description='Sortierfeld für Wartungspläne'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wart_plan_id) NOT ENFORCED
)
OPTIONS(description='Wartungsplan Kopf SAP IND (header information for maintenance plans. A maintenanca plan is a type of Work Plan (in_plangruppe))');