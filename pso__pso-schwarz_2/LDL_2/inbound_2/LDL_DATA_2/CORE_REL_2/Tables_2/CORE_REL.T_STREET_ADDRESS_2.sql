/* --------------------------------------------------------------------------------
   DDL for table: t_street_address_2
   generated from Powerdesigner on Mittwoch, 22. März 2023 07:17:02
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_STREET_ADDRESS_2 (
   street_addr_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the postal address.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   country_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the country_2, in which this address_2 is located.',
   iso_country_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code identifying the country_2 according to ISO 3166.',
   country_name                        VARCHAR(100)    NOT NULL COMMENT 'The name by which the country_2 is known,',
   city_sid                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the city, in which this address_2 is located.',
   city_name                           VARCHAR(100)    NOT NULL COMMENT 'The name by which the city is known,',
   district_sid                        NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the district, in which this address_2 is located.',
   district_name                       VARCHAR(100)    COMMENT 'The name by which the district is known,',
   postal_cd_area_sid                  NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for postal code area, in which this address_2 is located.',
   zip                                 VARCHAR(15)     COMMENT 'A code used by the postal service to identify a geographical area. E.g. 74072 for Heilbronn in Germany',
   street_name                         VARCHAR(100)    COMMENT 'The name of the street, in which this address_2 is located. (This includes names of squares and similar locations.)',
   house_nr                            VARCHAR(100)    COMMENT 'The number of a house in a street.',
   reporting_country_sid               NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the reporting country. (i.e. a country_2 definition which is different from a geographical country_2)',
   reporting_country_cd                VARCHAR(20)     COMMENT 'The code which identifies the reporting country_2',
   lon                                 NUMBER(9, 6)    COMMENT 'The longitude component of the geographical coordinates of this address.',
   lat                                 NUMBER(9, 6)    COMMENT 'The latitude component of the geographical coordinates of this address.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_STREET_ADDRESS PRIMARY KEY (street_addr_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'A physical mailing address_2, typically consisting of a street name, a house number, a city or village with a zip code and (optionally) a country.';
