CREATE TABLE CORE_REL_OCTOPUS.T_REF_COUNTRY_2 (
   country_cd                          VARCHAR(2)      NOT NULL COMMENT 'The code for the country_2 to which t_site_2 references on. ',
   geo_region_cd                       VARCHAR(20)     COMMENT 'Surrogate key for the country_2 region_2 of this country_2',
   curr_cd                             VARCHAR(3)      COMMENT 'A three-character code for a currency according to ISO 4217. E.g.: ''EUR'', ''USD'', ''GBP'', …',
   country_descr                       VARCHAR(100)    NOT NULL COMMENT 'Descriptive name of a country_2 e.g. DE- Germany, GB - Great Britain',
   country_descr_de                    VARCHAR(100)    COMMENT 'A textual description for country_cd written out in German.',
   country_descr_en                    VARCHAR(100)    COMMENT 'A textual description for country_cd written out in English.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REF_COUNTRY PRIMARY KEY (country_cd) NOT ENFORCED 
)  COMMENT = 'this is the geographical country_2 with an ISO2 2-letter code e.g. Germany - DE, Italy - IT etc.';
