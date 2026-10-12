--==============================================================
-- Table: t_ref_country
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_ref_country
   generated from Powerdesigner on Montag, 25. März 2024 15:58:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REF_COUNTRY (
   country_cd                          VARCHAR(2)       NOT NULL COMMENT 'The code for the country to which t_site references on. ',
   geo_region_cd                       VARCHAR(20)      COMMENT 'Surrogate key for the country region of this country',
   curr_cd                             VARCHAR(3)       COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'', ''GBP'',…',
   country_descr                       VARCHAR(100)     NOT NULL COMMENT 'Descriptive name of a country e.g. DE- Germany, GB - Great Britain',
   country_descr_de                    VARCHAR(100)     COMMENT 'A textual description for country_cd written out in German.',
   country_descr_en                    VARCHAR(100)     COMMENT 'A textual description for country_cd written out in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_COUNTRY PRIMARY KEY (country_cd) NOT ENFORCED 
)  COMMENT = 'this is the geographical country with an ISO2 2-letter code e.g. Germany - DE, Italy - IT etc.';

