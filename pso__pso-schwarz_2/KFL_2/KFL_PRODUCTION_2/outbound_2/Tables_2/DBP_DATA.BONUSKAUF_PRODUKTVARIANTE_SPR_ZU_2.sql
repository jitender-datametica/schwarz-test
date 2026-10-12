--==============================================================
-- Table: bonuskauf_produktvariante_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bonuskauf_produktvariante_spr_zu_2
   generated from Powerdesigner on Freitag, 18. Februar 2022 09:43:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.bonuskauf_produktvariante_spr_zu_2 (
bonuskauf_produktvariante_id STRING(10) NOT NULL OPTIONS(description='Produktvariante'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschlüssel'),
bonuskauf_produktvariante_bez STRING(60) OPTIONS(description='Bezeichnung Produktvariante'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='This table provides the name to the product variety ID (Produktvariante) - means how the customer has to combine the products to get a discount          Example: 0 = Any Products, 1 = Same Products, 2 = Different Products');