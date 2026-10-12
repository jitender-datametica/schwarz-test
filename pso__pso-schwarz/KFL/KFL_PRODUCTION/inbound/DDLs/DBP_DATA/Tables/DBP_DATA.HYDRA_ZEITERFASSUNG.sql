--==============================================================
-- Table: hydra_zeiterfassung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hydra_zeiterfassung
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:20:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HYDRA_ZEITERFASSUNG (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   pers_teilbereich_id                 VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ (Company Division, in the case on KL Logistic it is 1:1 with Disctribution Centers)',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
   dauer                               NUMBER(9,2)      COMMENT 'Personalzeiterfassung (Dauer in Stunden) - duration in work-hours',
   abrechnung_fg                       NUMBER(38,0)     COMMENT 'Flag gibt an ob die Abrechnung erfolgt ist und die Daten sich somit nicht mehr ändern',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_HYDRA_ZEITERFASSUNG PRIMARY KEY (mandant_id, pers_teilbereich_id, dat) NOT ENFORCED
)  COMMENT = 'Summary of work-hours spent per day by Company  Division (in Logistic - warehouse tasks)';
