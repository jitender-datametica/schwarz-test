--==============================================================
-- Table: predict_google_review_kaufland_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: predict_google_review_kaufland_2
   generated from Powerdesigner on Montag, 13. September 2021 15:50:55
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.predict_google_review_kaufland_2 (
   google_place_id                     VARCHAR(27)     NOT NULL COMMENT 'Google-own ID',
   kjmo                                NUMBER(38,0)    NOT NULL COMMENT 'month/year',
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Country_2 the store operates in',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'store-ID (Kaufland-Stores only)',
   predict_review_count                NUMBER(38,0)    NOT NULL COMMENT 'Amount of reviews for this store in the respective month',
   predict_rating_avg                  NUMBER(3,2)     NOT NULL COMMENT 'Average star rating (range 1-5)',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Aggregated google reviews on a monthly basis for Kaufland-stores; Source: Predict';

