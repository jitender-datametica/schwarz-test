--==============================================================
-- Table: t_dim_country_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_country_2
   generated from Powerdesigner on Dienstag, 2. April 2024 06:38:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_COUNTRY_2 (
   country_cd                          VARCHAR(2)       NOT NULL COMMENT 'The code for the country_2 in which the site (cross docks) resides in.',
   country_descr                       VARCHAR(100)     COMMENT 'A textual description for country_cd written out in group language (German).',
   country_descr_de                    VARCHAR(100)     COMMENT 'A textual description for country_cd written out in German.',
   country_descr_en                    VARCHAR(100)     COMMENT 'A textual description for country_cd written out in English.',
   suppliers_exist_fg                  BOOLEAN          COMMENT 'Flag informs, if supplier_2 exist in this country.',
   haulers_exist_fg                    BOOLEAN          COMMENT 'Flag informs, if hauler exist in this country.',
   org_units_exist_fg                  BOOLEAN          COMMENT 'Flag informs, if Org Unit_2 exist in this country.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_COUNTRY PRIMARY KEY (country_cd) NOT ENFORCED 
)  COMMENT = 'Is by definition the opposite from the business country. Here we don''t separate islands from the country. ';

