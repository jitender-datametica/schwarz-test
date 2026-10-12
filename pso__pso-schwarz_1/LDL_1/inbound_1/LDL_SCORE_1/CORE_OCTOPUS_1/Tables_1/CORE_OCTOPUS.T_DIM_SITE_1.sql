CREATE TABLE CORE_OCTOPUS.T_DIM_SITE_1 (
   site_sid                            NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the site.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   site_nr                             VARCHAR(20)     NOT NULL COMMENT 'A numeric or alphanumeric value which identifies the site for the business.',
   site_abbr_name                      VARCHAR(100)    COMMENT 'A short abbreviation for the site that identifies it.',
   site_name                           VARCHAR(100)    COMMENT 'The name by which the site is known.',
   site_type_cd                        VARCHAR(20)     NOT NULL COMMENT 'The code for the type of site e.g. TRANS = Warenumschlagplatz.',
   site_type_descr                     VARCHAR(100)    NOT NULL COMMENT 'A textual description for the site_type_cd written out in group language (German).',
   country_cd                          VARCHAR(2)      COMMENT 'The code for the country_1 to which t_site_1 references on. ',
   country_descr                       VARCHAR(100)    COMMENT 'A textual description for country_cd written out in group language (German).',
   longitude                           NUMBER(9, 6)    COMMENT 'Object.address_1-data.coordinates x',
   latitude                            NUMBER(9, 6)    COMMENT 'Object.address_1-data.coordinates y',
   city_name                           VARCHAR(100)    COMMENT 'Name of the city',
   zip                                 VARCHAR(15)     COMMENT 'Zip code / PLZ',
   street_name                         VARCHAR(100)    COMMENT 'Name of the street',
   transpoint_type_cd                  VARCHAR(20)     COMMENT 'The code for the type of transshipment point e.g. WH = Lager, HEAD = Firmensitz.',
   transpoint_type_descr               VARCHAR(100)    NOT NULL COMMENT 'A textual description for the transpoint_type_cd written out in group language (German).',
   site_status_cd                      VARCHAR(20)     NOT NULL COMMENT 'The code for the status_1 of the site.',
   site_status_descr                   VARCHAR(100)    NOT NULL COMMENT 'A textual description for the site_status_cd written out in group language (German).',
   gln_nr                              VARCHAR(13)     COMMENT 'The Global Location_1 Number (GLN) is part of the GS1 systems of standards. It is a simple tool used to identify a location_1 and can identify locations uniquely where required.',
   site_operator_sid                   NUMBER          COMMENT 'The unique identifier (surrogate key) for the site operator. Either its operated by internal organization or external party. ',
   external_wh_fg                      BOOLEAN         NOT NULL COMMENT 'An indicator showing whether the warehouse is an external one to add capacity to a central warehouse.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_SITE PRIMARY KEY (site_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'This dimension contains all sites that are known, e.g. central warehouses, cross-docks or supplier_1 sites where products are collected by the hauler.
             
             A site is a physical (or electronic) facility, place or area that is used in the course of conducting business. This includes, buildings, such as office buildings, factories or warehouses, as well as public (or semi-public) places, such as ports, airports or container terminals.
             
             A site has a physical address_1 and, typically, serves a certain purpose. (Note that large sites may have several addresses, e.g. in case there are several entrances.) A change in the address_1 does not necessarily result in a new site. A site may be located within another site.
             
             A site may or may not be owned or operated by the enterprise (Lidl).';
