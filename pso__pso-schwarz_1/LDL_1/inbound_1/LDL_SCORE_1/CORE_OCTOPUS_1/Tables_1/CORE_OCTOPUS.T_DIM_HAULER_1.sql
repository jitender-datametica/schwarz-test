CREATE TABLE CORE_OCTOPUS.T_DIM_HAULER_1 (
   hauler_sid                          NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the hauler',
   hauler_nr                           VARCHAR(20)     COMMENT 'The number which identifies the hauler in ',
   hauler_name                         VARCHAR(100)    COMMENT 'The name of the hauler',
   hauler_short_name                   VARCHAR(100)    COMMENT 'The short name of the hauler (Cargo: Kurzbezeichnung).',
   hauler_abbr_name                    VARCHAR(100)    COMMENT 'Shortcut for hauler_name',
   vat_nr                              VARCHAR(20)     COMMENT 'The vat number (Umsatzsteuer ID). ',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_DIM_HAULER PRIMARY KEY (hauler_sid) NOT ENFORCED 
)  COMMENT = 'Pickups products from one place to another via a vehicle (LKW, Schiff..). 
             A crossdock is run by one hauler but one hauler can run many crossdocks. ';
