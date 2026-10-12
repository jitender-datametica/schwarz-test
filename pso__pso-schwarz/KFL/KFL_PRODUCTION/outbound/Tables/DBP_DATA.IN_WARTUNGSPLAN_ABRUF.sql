--==============================================================
-- Table: in_wartungsplan_abruf
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_wartungsplan_abruf
   generated from Powerdesigner on Montag, 17. Juli 2023 09:36:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_wartungsplan_abruf (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wart_plan_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wartungsplan'),
wart_plan_abruf_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Nummer des Wartungsplanabrufs (Maintenance Plan execution number - starts from 1 for every plan)'),
wart_plan_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Wartungsposition (this value is unique per mandant_id and is enough to indetify a wartungsplan)'),
auftrag_id STRING(20) COLLATE 'und:ci' OPTIONS(description='Auftragsnummer aus aufnr (maintenance order id)'),
dat_start_geplant DATE
OPTIONS(description='Eckstarttermin, in der Quelle nur bis zum Abruf gefüllt (wenn AUFNR gefüllt, ist das Feld in SAP leer) - scheduled start date for future executions. '),
dat_start DATE
OPTIONS(description='Eckstarttermin aus gstrp - the actual date when the process related to this order started (looked up from in_auftrag_pps)'),
dat_abschluss DATE
OPTIONS(description='Abschlußdatum des Abrufobjektes - until maintenance plan is completed this date is null. When it is completed this is the date of the completion'),
qual_meldung_id INTEGER
OPTIONS(description='ID der Qualitätsmeldung aus qmnum (QA Notification ID, similar to an INC )'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wart_plan_id, wart_plan_abruf_id, wart_plan_pos_id) NOT ENFORCED
)
OPTIONS(description='Wartungsplan Position executions -> 1 row per Maintenance plan position (step) for every past (finished) executon and future (scheduled) execution');