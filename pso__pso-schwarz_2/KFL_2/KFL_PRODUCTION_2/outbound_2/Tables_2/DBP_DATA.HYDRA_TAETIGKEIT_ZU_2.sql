--==============================================================
-- Table: hydra_taetigkeit_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hydra_taetigkeit_zu_2
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:17:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hydra_taetigkeit_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
pers_teilbereich_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ (Company Division, in the case on KL Logistic it is 1:1 with Disctribution Centers)'),
taetigkeit_id STRING(3) NOT NULL
OPTIONS(description='Tätigkeit ID (mit führenden Nullen, z.B. 001) (local activity type code)'),
taetigkeit_bez STRING(30) NOT NULL OPTIONS(description='Bezeichnung der Tätigkeit (description of the local activity)'),
taetigkeit_typ_id STRING(1) NOT NULL
OPTIONS(description='BDE Verarbeitung der Tätigkeit ;Z=Zeitlohn ;D=Durchschnitt (code for activity payment type)'),
taetigkeit_int_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Internationale Tätigkeit ID ( International/group Activity Type code)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, taetigkeit_id) NOT ENFORCED
)
OPTIONS(description='Local code for the Activity Type. Here for every local code we have which is the corresponding group code.             ');