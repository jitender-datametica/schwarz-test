--==============================================================
-- Table: predict_google_review_competitors
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: predict_google_review_competitors
   generated from Powerdesigner on Montag, 13. September 2021 15:50:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.predict_google_review_competitors (
google_place_id STRING(27) NOT NULL OPTIONS(description='Google-own ID'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='month/year'),
predict_review_count BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Amount of reviews for this store in the respective month'),
predict_rating_avg NUMERIC(3,2) NOT NULL OPTIONS(description='Average star rating (range 1-5)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Aggregated google reviews on a monthly basis for Kaufland-competitors; Source: Predict');