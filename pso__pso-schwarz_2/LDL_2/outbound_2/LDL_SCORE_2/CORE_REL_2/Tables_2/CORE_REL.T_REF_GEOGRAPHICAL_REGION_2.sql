--==============================================================
-- Table: t_ref_geographical_region_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_geographical_region_2
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_geographical_region_2 (
geo_region_cd STRING(30) NOT NULL OPTIONS(description='Surrogate key for the Lidl defined region_2 of this country_2'),
geo_region_descr STRING(100) OPTIONS(description='Description for the Lidl defined  region_2 of this country_2'),
geo_region_descr_de STRING(100)
OPTIONS(description='Description in German for the Lidl defined region_2 of this country_2 in German'),
geo_region_descr_en STRING(100)
OPTIONS(description='Description fin English for the Lidl defined region_2 of this country_2 in English'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
PRIMARY KEY (geo_region_cd) NOT ENFORCED
) OPTIONS(description='The LIDL defined Geographical region_2 to which a country_2 belongs e.g. Middle East');