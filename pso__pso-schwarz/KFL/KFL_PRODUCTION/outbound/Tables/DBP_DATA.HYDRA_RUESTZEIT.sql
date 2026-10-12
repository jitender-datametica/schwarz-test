--==============================================================
-- Table: hydra_ruestzeit
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hydra_ruestzeit
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:21:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hydra_ruestzeit (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
pers_teilbereich_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ (Company Division, in the case on KL Logistic it is 1:1 with Disctribution Centers)'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM-TT'),
praemiengrp_id STRING(8) NOT NULL
OPTIONS(description='Prämiengruppe, z.B. 304001A1 - Code of the work group. 304 is code of distribution center, 001 code of task that this group should be doing, A1 is code for complecity of the task'),
transport_gv_id STRING(18) OPTIONS(description='Geschäftsvorfall'),
lagernummer_id STRING(4) COLLATE 'und:ci' OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'),
ewm_fg BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='Indicates if the LGNUM is an SAP EWM-run warehouse'),
dauer_ist NUMERIC(9,2)
OPTIONS(description='Lohnscheindauer in Stunden (gesamt, entspricht dem Wert in der Tabelle hydra_leistungsgrad und wird in den folgenden Spalten aufgegliedert)            Total sum of work-hours including actual activity time and overhead time. The overhead time is broken down in the columns dauer_ruest,dauer_wechsel,dauer_sonstiges. The actual activity time is the value in this columns - the sum of other 3 cols'),
dauer_ruest NUMERIC(9,2)
OPTIONS(description='Dauer Rüstzeit je Prämiengruppe in Stunden - Duration Set-up time per bonus group in hours'),
dauer_wechsel NUMERIC(9,2)
OPTIONS(description='Dauer Wechselzeit je Prämiengruppe in Stunden - Duration of changeover time per premium group in hours'),
dauer_sonstiges NUMERIC(9,2)
OPTIONS(description='Dauer Sonstige Zeit je Prämiengruppe in Stunden - Duration Other time per premium group in hours'),
abrechnung_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag gibt an ob die Abrechnung erfolgt ist und die Daten sich somit nicht mehr ändern'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat, praemiengrp_id) NOT ENFORCED
)
OPTIONS(description='Summary of work-hours spent per day by Company  Division and Work Group (in Logistic - warehouse tasks)');