--==============================================================
-- Table: bonuskauf_dimension_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bonuskauf_dimension_spr_zu_2
   generated from Powerdesigner on Freitag, 18. Februar 2022 09:42:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bonuskauf_dimension_spr_zu_2 (
bonuskauf_dimension_id STRING(10) NOT NULL OPTIONS(description='Produktdimension'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschlüssel'),
bonuskauf_dimension_bez STRING(60) OPTIONS(description='Bezeichnung Produktdimension'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='This table provides the name to the product dimension ID (Produktdimension) - shows if the discount is for one or more products          Example: 01 = Product, 02 = Product Group, 03 = Merchandise Category');