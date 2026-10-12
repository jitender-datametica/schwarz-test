--==============================================================
-- Table: predict_competitors_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: predict_competitors_1
   generated from Powerdesigner on Montag, 13. September 2021 15:50:55
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.predict_competitors_1 (
   google_place_id                     VARCHAR(27)     NOT NULL COMMENT 'Google-own ID',
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Country_1 the store operates in',
   competitor_name                     VARCHAR(20)     DEFAULT '' COMMENT 'The company that owns the store (e.g. Kaufland, Lidl, EDEKA, Metro)',
   wup_name                            VARCHAR(160)    DEFAULT '' COMMENT 'Name of the Store (e.g. EDEKA Lechertshuber & Wimmer)',
   wup_str                             VARCHAR(160)    DEFAULT '' COMMENT 'Street and house number of the Store',
   wup_standort                        VARCHAR(160)    DEFAULT '' COMMENT 'town of the Store',
   laengengrad                         NUMBER(38, 16)  DEFAULT -1 COMMENT 'longitude of the store',
   breitengrad                         NUMBER(38, 16)  DEFAULT -1 COMMENT 'latitude of the store',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Master data (= Stammdaten) for Kaufland-competitors; Source: Predict';

