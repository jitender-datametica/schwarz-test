--==============================================================
-- Table: t_ref_geographical_region
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_geographical_region
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_GEOGRAPHICAL_REGION (
   geo_region_cd                       VARCHAR(30)      NOT NULL COMMENT 'Surrogate key for the Lidl defined region of this country',
   geo_region_descr                    VARCHAR(100)     COMMENT 'Description for the Lidl defined  region of this country',
   geo_region_descr_de                 VARCHAR(100)     COMMENT 'Description in German for the Lidl defined region of this country in German',
   geo_region_descr_en                 VARCHAR(100)     COMMENT 'Description fin English for the Lidl defined region of this country in English',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',   
   CONSTRAINT PK_T_REF_GEOGRAPHICAL_REGION PRIMARY KEY (geo_region_cd) NOT ENFORCED 
)  COMMENT = 'The LIDL defined Geographical region to which a country belongs e.g. Middle East';

