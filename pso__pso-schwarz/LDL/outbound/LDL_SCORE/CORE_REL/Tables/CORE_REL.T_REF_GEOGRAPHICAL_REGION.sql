--==============================================================
-- Table: t_ref_geographical_region
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_geographical_region
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_geographical_region (
geo_region_cd STRING(30) NOT NULL OPTIONS(description='Surrogate key for the Lidl defined region of this country'),
geo_region_descr STRING(100) OPTIONS(description='Description for the Lidl defined  region of this country'),
geo_region_descr_de STRING(100)
OPTIONS(description='Description in German for the Lidl defined region of this country in German'),
geo_region_descr_en STRING(100)
OPTIONS(description='Description fin English for the Lidl defined region of this country in English'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (geo_region_cd) NOT ENFORCED
) OPTIONS(description='The LIDL defined Geographical region to which a country belongs e.g. Middle East');