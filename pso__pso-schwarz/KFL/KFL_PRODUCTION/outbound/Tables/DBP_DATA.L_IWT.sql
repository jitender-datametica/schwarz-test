--==============================================================
-- Table: l_iwt
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_iwt
   generated from Powerdesigner on Mittwoch, 27. September 2023 15:37:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_iwt (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant    '),
iwt_id STRING(1) NOT NULL
OPTIONS(description='IWT Kennzeichen. IDs that show if a product is ordered by KFL in one country for its own use (\'\'/0) or to be exported to KFL in other company (E) or it is imported from KFL from another country (I)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, iwt_id) NOT ENFORCED
);