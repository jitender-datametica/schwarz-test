/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_assortment_area_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 13:12:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_assortment_area_1 (
nfpo_assortment_area_id BIGNUMERIC(38,0) NOT NULL,
nfpo_assortment_area_name STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_assortment_area_id) NOT ENFORCED
);