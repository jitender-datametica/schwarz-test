--==============================================================
-- Table: ts_personalteilbereich_wup_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_personalteilbereich_wup_zu
   generated from Powerdesigner on Montag, 22. August 2022 13:18:09
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_PERSONALTEILBEREICH_WUP_ZU (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant im DWH',
   personalteilbereich_id              VARCHAR(4)      NOT NULL COMMENT 'Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_PERSONALTEILBEREICH_WUP_ZU PRIMARY KEY (mandant_id, personalteilbereich_id, wup_id) NOT ENFORCED
)  COMMENT = 'Zuordnung Personalteilbereich (Hydra) zu Verteilzentrum';
