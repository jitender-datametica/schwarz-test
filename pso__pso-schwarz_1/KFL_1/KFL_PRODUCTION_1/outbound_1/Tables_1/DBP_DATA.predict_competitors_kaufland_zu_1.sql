--==============================================================
-- Table: predict_competitors_kaufland_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: predict_competitors_kaufland_zu_1
   generated from Powerdesigner on Montag, 13. September 2021 15:50:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.predict_competitors_kaufland_zu_1 (
google_place_id STRING(27) NOT NULL OPTIONS(description='Google-own ID'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='month/year'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Country_1 the store operates in'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='store-ID Kaufland-Stores only'),
airline_distance NUMERIC(5,2) DEFAULT 0 OPTIONS(description='Distance between competitor and nearest K-Store in km'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='Possible combinations between competitor stores, Kaufland stores and calender month; Source: Predict');