--==============================================================
-- Table: plantour_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: plantour_1
   generated from Powerdesigner on Monday, March 28, 2022 2:22:32 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.PLANTOUR_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   plantour_id                         NUMBER(38,0)    NOT NULL COMMENT 'Plantournummer',
   tour_id                             NUMBER(18,0)    COMMENT 'Nummer des Transportes (Tour_1)',
   trailer_fg                          NUMBER(38,0)    COMMENT 'Kennzeichen Trailertour',
   trailer_id                          VARCHAR(10)     DEFAULT 'no Lookup' COMMENT 'Trailer-ID',
   dat_trailer                         DATE            COMMENT 'Übernahmedatum Trailer',
   zeit_trailer                        TIME(6)         COMMENT 'Übernahmezeit Trailer',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_PLANTOUR PRIMARY KEY (mandant_id, wup_id, nb_id, plantour_id) NOT ENFORCED
)  COMMENT = 'Plantouren: Kopfdaten';
