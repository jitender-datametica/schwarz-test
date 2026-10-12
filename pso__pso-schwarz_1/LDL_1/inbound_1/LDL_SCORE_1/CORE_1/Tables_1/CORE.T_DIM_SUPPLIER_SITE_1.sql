--==============================================================
-- Table: t_dim_supplier_site_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_supplier_site_1
   generated from Powerdesigner on Mittwoch, 7. August 2024 10:43:21
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_SUPPLIER_SITE_1 (
   supplier_site_sid                   NUMBER          NOT NULL COMMENT 'Supplier_1 site where the goods are provided, for KoL (Komplettladung / Direktlogistik) logistic types',
   supplier_sid                        NUMBER          NOT NULL COMMENT 'Unique identifier for the supplier_1',
   country_cd                          VARCHAR(2)      COMMENT 'The code for the country_1 in which the site (cross docks) resides in.',
   country_descr                       VARCHAR(100)    COMMENT 'A textual description for country_cd written out in group language (German).',
   supplier_site_nr                    VARCHAR(20)     COMMENT 'The number which identifies the   in ',
   supplier_site_abbr_name             VARCHAR(100)    COMMENT 'The abbreviated name of the supplier_1',
   supplier_site_name                  VARCHAR(100)    COMMENT 'The name by which a site is known which is run by a supplier. ',
   supplier_site_transpoint_type_cd    VARCHAR(20)     COMMENT 'The type of the supplier_1 e.g. (PROD = Produktionsstätte, HEAD = Firmensitz, LOAD = Verladestandort)',
   supplier_site_transpoint_type_descr VARCHAR(100)    COMMENT 'The german description for the supplier_site_transpoint_type_cd',
   longitude                           NUMBER(9, 6)    COMMENT 'Object.address_1-data.coordinates x',
   latitude                            NUMBER(9, 6)    COMMENT 'Object.address_1-data.coordinates y',
   city_name                           VARCHAR(100)    COMMENT 'Name of the city',
   zip                                 VARCHAR(15)     COMMENT 'Zip code / PLZ',
   street_name                         VARCHAR(100)    COMMENT 'Name of the street',
   gln_nr                              VARCHAR(13)     COMMENT 'The Global Location_1 Number where the supplier_1 is located.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_SUPPLIER_SITE PRIMARY KEY (supplier_site_sid) NOT ENFORCED 
)  COMMENT = 'This entity contains sites which are operated by supplier_1, such as factories or distribution warehouses. ';
