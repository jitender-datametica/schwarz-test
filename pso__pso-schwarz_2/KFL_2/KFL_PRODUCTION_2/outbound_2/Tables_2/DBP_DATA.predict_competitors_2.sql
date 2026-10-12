--==============================================================
-- Table: predict_competitors_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: predict_competitors_2
   generated from Powerdesigner on Montag, 13. September 2021 15:50:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.predict_competitors_2 (
google_place_id STRING(27) NOT NULL OPTIONS(description='Google-own ID'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Country_2 the store operates in'),
competitor_name STRING(20) DEFAULT ''
OPTIONS(description='The company that owns the store (e.g. Kaufland, Lidl, EDEKA, Metro)'),
wup_name STRING(160) DEFAULT '' OPTIONS(description='Name of the Store (e.g. EDEKA Lechertshuber & Wimmer)'),
wup_str STRING(160) DEFAULT '' OPTIONS(description='Street and house number of the Store'),
wup_standort STRING(160) DEFAULT '' OPTIONS(description='town of the Store'),
laengengrad BIGNUMERIC(38,16) DEFAULT - 1 OPTIONS(description='longitude of the store'),
breitengrad BIGNUMERIC(38,16) DEFAULT - 1 OPTIONS(description='latitude of the store'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Master data (= Stammdaten) for Kaufland-competitors; Source: Predict');