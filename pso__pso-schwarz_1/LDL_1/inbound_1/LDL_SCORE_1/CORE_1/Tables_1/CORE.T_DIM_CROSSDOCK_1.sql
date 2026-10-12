--==============================================================
-- Table: t_dim_crossdock_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_dim_crossdock_1
   generated from Powerdesigner on Montag, 5. August 2024 15:29:19
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CROSSDOCK_1 (
   crossdock_sid                       NUMBER          NOT NULL COMMENT 'Contains crossdock and operating hauler_sid. In addition the crossdock_name. ',
   operating_hauler_sid                NUMBER          NOT NULL COMMENT 'Hauler (Spediteur) who is running the crossdock',
   country_cd                          VARCHAR(2)      NOT NULL COMMENT 'The code for the country_1 in which the site (cross docks) resides in.',
   country_descr                       VARCHAR(100)    COMMENT 'A textual description for country_cd written out in group language (German).',
   crossdock_nr                        VARCHAR(20)     COMMENT 'Contains crossdock and operating hauler_sid. In addition the crossdock_name. ',
   crossdock_abbr_name                 VARCHAR(100)    COMMENT 'Contains crossdock and operating hauler_sid. In addition the crossdock_name. ',
   crossdock_name                      VARCHAR(100)    COMMENT 'Contains crossdock and operating hauler_sid. In addition the crossdock_name. ',
   longitude                           NUMBER(9, 6)    COMMENT 'Object.address_1-data.coordinates x',
   latitude                            NUMBER(9, 6)    COMMENT 'Object.address_1-data.coordinates y',
   city_name                           VARCHAR(100)    COMMENT 'Name of the city',
   zip                                 VARCHAR(10)     COMMENT 'Zip code / PLZ',
   street_name                         VARCHAR(100)    COMMENT 'Name of the street',
   gln_nr                              VARCHAR(13)     COMMENT 'The Global Location_1 Number where the supplier_1 is located.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_CROSSDOCK PRIMARY KEY (crossdock_sid) NOT ENFORCED 
)  COMMENT = 'This entity contains all cross-docks that are known. A cross-dock is a subtype of a site. 
             Different goods are delivered by different carriers at a main hub. In addition, goods also leave from a crossdock. 
             The operating hauler (Spediteur) is the entity which runs and manages the crossdock.';
