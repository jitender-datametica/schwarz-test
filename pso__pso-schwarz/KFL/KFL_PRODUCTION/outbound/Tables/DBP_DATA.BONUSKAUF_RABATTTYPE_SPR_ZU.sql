--==============================================================
-- Table: bonuskauf_rabatttyp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bonuskauf_rabatttyp_spr_zu
   generated from Powerdesigner on Freitag, 18. Februar 2022 09:43:27
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bonuskauf_rabatttype_spr_zu (
bonuskauf_rabatttype_id STRING(10) NOT NULL OPTIONS(description='Rabatttyp'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschlüssel'),
bonuskauf_rabatttype_bez STRING(60) OPTIONS(description='Bezeichnung Rabattyp'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='shows what kind of discount the customer gets (Rabatttyp) Example: 01 = Regular Price, 02 = Discount Price, 03 = Discount Amount Off, 05 = Free');