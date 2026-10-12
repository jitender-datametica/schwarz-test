--==============================================================
-- Table: hydra_taetigkeit_tag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hydra_taetigkeit_tag_1
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:21:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hydra_taetigkeit_tag_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
pers_teilbereich_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ (Company Division, in the case on KL Logistic it is 1:1 with Disctribution Centers)'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_1-TT'),
taetigkeit_id STRING(3) NOT NULL
OPTIONS(description='Tätigkeit ID (mit führenden Nullen, z.B. 001) (local activity type code)'),
kostenstelle_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Kostenstelle, z.Bsp. 9676-400'),
dauer NUMERIC(9,2) OPTIONS(description='Personalzeiterfassung (Dauer in Stunden_1) - duration in work-hours'),
abrechnung_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag gibt an ob die Abrechnung erfolgt ist und die Daten sich somit nicht mehr ändern'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat, taetigkeit_id) NOT ENFORCED
)
OPTIONS(description='Summary of work-hours spent per day by Company  Division and Activity  Type  (in Logistic - warehouse tasks)');