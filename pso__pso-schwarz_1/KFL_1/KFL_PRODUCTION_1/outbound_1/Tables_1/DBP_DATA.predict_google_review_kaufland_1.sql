--==============================================================
-- Table: predict_google_review_kaufland_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: predict_google_review_kaufland_1
   generated from Powerdesigner on Montag, 13. September 2021 15:50:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.predict_google_review_kaufland_1 (
google_place_id STRING(27) NOT NULL OPTIONS(description='Google-own ID'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='month/year'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Country_1 the store operates in'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='store-ID (Kaufland-Stores only)'),
predict_review_count BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Amount of reviews for this store in the respective month'),
predict_rating_avg NUMERIC(3,2) NOT NULL OPTIONS(description='Average star rating (range 1-5)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Aggregated google reviews on a monthly basis for Kaufland-stores; Source: Predict');