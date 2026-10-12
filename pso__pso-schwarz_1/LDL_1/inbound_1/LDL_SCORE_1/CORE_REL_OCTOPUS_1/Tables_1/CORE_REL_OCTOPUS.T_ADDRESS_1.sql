CREATE TABLE CORE_REL_OCTOPUS.T_ADDRESS_1 (
   addr_sid                            NUMBER          NOT NULL COMMENT 'Is the unique identifier surrogate key of the address_1',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   country_cd                          VARCHAR(2)      COMMENT 'The code for the country_1 to which t_site_1 references on. ',
   city_name                           VARCHAR(100)    COMMENT 'Name of the city',
   zip                                 VARCHAR(15)     COMMENT 'Zip code / PLZ',
   street_name                         VARCHAR(100)    COMMENT 'Name of the street',
   longitude                           NUMBER(9, 6)    COMMENT 'Object.address_1-data.coordinates x',
   latitude                            NUMBER(9, 6)    COMMENT 'Object.address_1-data.coordinates y',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_ADDRESS PRIMARY KEY (addr_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'Table with Cargo adress informations';
