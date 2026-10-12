--==============================================================
-- Table: predict_competitors_kaufland_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: predict_competitors_kaufland_zu
   generated from Powerdesigner on Montag, 13. September 2021 15:50:55
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.predict_competitors_kaufland_zu (
   google_place_id                     VARCHAR(27)    NOT NULL COMMENT 'Google-own ID',
   kjmo                                INTEGER    NOT NULL COMMENT 'month/year',
   mandant_id                          INTEGER    NOT NULL COMMENT 'Country the store operates in',
   wup_id                              INTEGER    NOT NULL COMMENT 'store-ID Kaufland-Stores only',
   airline_distance                    NUMBER(29,2)    DEFAULT 0 COMMENT 'Distance between competitor and nearest K-Store in km',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Possible combinations between competitor stores, Kaufland stores and calender month; Source: Predict';

