CREATE TABLE CORE_OCTOPUS.T_DIM_WAREHOUSE_2 (
   wh_sid                              NUMBER          NOT NULL COMMENT 'Unique identifier for the warehouse',
   regional_org_sid                    NUMBER          COMMENT 'The unique identifier (surrogate key) for the regional organization.',
   country_cd                          VARCHAR(2)      COMMENT 'The code for the country_2 in which the site (cross docks) resides in.',
   country_descr                       VARCHAR(100)    COMMENT 'A textual description for country_cd written out in group language (German).',
   wh_nr                               VARCHAR(20)     COMMENT 'The number which identifies the warehouse in ',
   wh_abbr_name                        VARCHAR(100)    COMMENT 'The abbreviated name of the warehouse.',
   wh_name                             VARCHAR(100)    COMMENT 'The name of the warehouse.',
   external_wh_fg                      BOOLEAN         COMMENT 'An indicator showing whether the warehouse is an external one to add capacity to a central warehouse.',
   longitude                           NUMBER(9, 6)    COMMENT 'Object.address_2-data.coordinates x',
   latitude                            NUMBER(9, 6)    COMMENT 'Object.address_2-data.coordinates y',
   city_name                           VARCHAR(100)    COMMENT 'Name of the city',
   zip                                 VARCHAR(15)     COMMENT 'Zip code / PLZ',
   street_name                         VARCHAR(100)    COMMENT 'Name of the street',
   gln_nr                              VARCHAR(13)     COMMENT 'The Global Location_2 Number where the supplier_2 is located.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_WAREHOUSE PRIMARY KEY (wh_sid) NOT ENFORCED 
)  COMMENT = 'Warehouses where the products are stored. A flag indicates whether it''s an external warehouse (not run by Lidl) or internal warehouse (run by Lidl). ';
