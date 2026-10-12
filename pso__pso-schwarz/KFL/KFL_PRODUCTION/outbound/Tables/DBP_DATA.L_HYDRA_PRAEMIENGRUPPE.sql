--==============================================================
-- Table: l_hydra_praemiengruppe
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_hydra_praemiengruppe
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:18:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_hydra_praemiengruppe (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
pers_teilbereich_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ (Company Division, in the case on KL Logistic it is 1:1 with Disctribution Centers)'),
praemiengrp_id STRING(8) NOT NULL
OPTIONS(description='Prämiengruppe, z.B. 304001A1 - Code of the work group. 304 is code of distribution center, 001 code of task that this group should be doing, A1 is code for complecity of the task'),
praemiengrp_bez STRING(30) NOT NULL OPTIONS(description='Bezeichnung Prämiengruppe, z.B. 304001A1 = "TK MP Komis"'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, praemiengrp_id) NOT ENFORCED
)
OPTIONS(description='Group of employees that do the same task(s) ( OG MP - obst gemuse mixed pallets), and therefore are subject to common group bonus             We do not have translations in different languages. We have only a description in this table and no _SPR_ZU table');