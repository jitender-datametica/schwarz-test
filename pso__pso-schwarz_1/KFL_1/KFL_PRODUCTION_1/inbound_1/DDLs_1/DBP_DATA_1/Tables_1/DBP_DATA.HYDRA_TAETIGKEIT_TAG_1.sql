--==============================================================
-- Table: hydra_taetigkeit_tag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hydra_taetigkeit_tag_1
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:21:38
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HYDRA_TAETIGKEIT_TAG_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   pers_teilbereich_id                 VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ (Company Division, in the case on KL Logistic it is 1:1 with Disctribution Centers)',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM_1-TT',
   taetigkeit_id                       VARCHAR(3)       NOT NULL COMMENT 'Tätigkeit ID (mit führenden Nullen, z.B. 001) (local activity type code)',
   kostenstelle_id                     VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'ID der Kostenstelle, z.Bsp. 9676-400',
   dauer                               NUMBER(9,2)      COMMENT 'Personalzeiterfassung (Dauer in Stunden_1) - duration in work-hours',
   abrechnung_fg                       NUMBER(38,0)     COMMENT 'Flag gibt an ob die Abrechnung erfolgt ist und die Daten sich somit nicht mehr ändern',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_HYDRA_TAETIGKEIT_TAG PRIMARY KEY (mandant_id, pers_teilbereich_id, dat, taetigkeit_id, kostenstelle_id) NOT ENFORCED
)  COMMENT = 'Summary of work-hours spent per day by Company  Division and Activity  Type  (in Logistic - warehouse tasks)';
