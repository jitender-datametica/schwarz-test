--==============================================================
-- Table: in_plan_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_plan_2
   generated from Powerdesigner on Montag, 20. Februar 2023 09:27:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_plan_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
plantyp_id STRING(1) NOT NULL OPTIONS(description='Plantyp (z.B. A = Wartungsplan)'),
plangruppe_id STRING(10) NOT NULL OPTIONS(description='Schlüssel der Plangruppe'),
plangruppenzaehler STRING(2) NOT NULL OPTIONS(description='Plangruppenzähler'),
plangruppenzaehler_int BIGNUMERIC(38,0) NOT NULL OPTIONS(description='interner Zähler der Plangruppe'),
werk_id BIGNUMERIC(38,0) OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
arbeitsplan_bez STRING(40) OPTIONS(description='Kurztext Plan'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, plantyp_id, plangruppe_id, plangruppenzaehler, plangruppenzaehler_int) NOT ENFORCED
)
OPTIONS(description='Arbeitsplan Kopf.( table contains one row per Work Plan, and the type of plan .. like maintenance plan etc.)');