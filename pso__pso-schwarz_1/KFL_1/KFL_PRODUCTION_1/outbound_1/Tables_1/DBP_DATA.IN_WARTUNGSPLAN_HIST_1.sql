--==============================================================
-- Table: in_wartungsplan_hist_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_wartungsplan_hist_1
   generated from Powerdesigner on Montag, 17. Juli 2023 09:37:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_wartungsplan_hist_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wart_plan_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wartungsplan'),
wart_plan_abruf_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Nummer des Wartungsplanabrufs (Maintenance Plan Call number)'),
wart_plan_abruf_zaehler BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Nummer eines Wartungspaketes ( Maintenance Package_1 Number)'),
dat_plan DATE OPTIONS(description='Plantermin (next planned date)'),
wart_plan_terminierungsart STRING(1) OPTIONS(description='Terminierungsart (Scheduling type)'),
dat_start DATE
OPTIONS(description='Startdatum (start date) - when we have several scheduled execution of same maintenance plan, this is the first date of the schedule. Same for all exeuction,'),
dat_erledigung DATE OPTIONS(description='Datum der letzten Erledigung im Wartungsplan'),
dat_abruf DATE
OPTIONS(description='Abrufdatum (Call Date) - actual execution date of the execution of this plan interation'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wart_plan_id, wart_plan_abruf_id, wart_plan_abruf_zaehler) NOT ENFORCED
)
OPTIONS(description='Wartungsplan Historie SAP IND ( history of executions of maintenance plans - 1 rec for each run of a maintenance plan)');