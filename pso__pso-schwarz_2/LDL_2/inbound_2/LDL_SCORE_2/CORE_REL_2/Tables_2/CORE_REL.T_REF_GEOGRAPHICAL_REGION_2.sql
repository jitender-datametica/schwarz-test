--==============================================================
-- Table: t_ref_geographical_region_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_geographical_region_2
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_GEOGRAPHICAL_REGION_2 (
   geo_region_cd                       VARCHAR(30)      NOT NULL COMMENT 'Surrogate key for the Lidl defined region_2 of this country_2',
   geo_region_descr                    VARCHAR(100)     COMMENT 'Description for the Lidl defined  region_2 of this country_2',
   geo_region_descr_de                 VARCHAR(100)     COMMENT 'Description in German for the Lidl defined region_2 of this country_2 in German',
   geo_region_descr_en                 VARCHAR(100)     COMMENT 'Description fin English for the Lidl defined region_2 of this country_2 in English',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_REF_GEOGRAPHICAL_REGION PRIMARY KEY (geo_region_cd) NOT ENFORCED 
)  COMMENT = 'The LIDL defined Geographical region_2 to which a country_2 belongs e.g. Middle East';

