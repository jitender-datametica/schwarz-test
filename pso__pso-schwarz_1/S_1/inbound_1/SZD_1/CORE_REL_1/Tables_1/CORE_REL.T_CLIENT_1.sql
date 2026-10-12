/* --------------------------------------------------------------------------------
   DDL for table: T_CLIENT_1
   generated from Powerdesigner on Montag, 20. Januar 2025 08:40:07
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CLIENT_1 (
   PARTY_SID                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the company.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   CLIENT_NAME                         VARCHAR(100)    NOT NULL COMMENT 'Descriptive attribute - Name of the recipient',
   STREET_ADDRESS_LOCATION_SID         NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the location.',
   CLIENT_NR                           VARCHAR(250)    NOT NULL COMMENT 'Natural/Business Key - The identifying number of the internal organization',
   ADDITIONAL_NAME_1_TXT               VARCHAR(1000)   COMMENT 'Descriptive attribute - an additional name or part of the name of a company, may contains the type of legal entity of the company like ''GmbH'', ''Limited'', Co. KG'' or others but could also be just a part of a companies name',
   ADDITIONAL_NAME_2_TXT               VARCHAR(1000)   COMMENT 'Descriptive attribute - an additional name or part of the name of a company, may contains the type of legal entity of the company like ''GmbH'', ''Limited'', Co. KG'' or others but could also be just a part of a companies name',
   INTERNATIONAL_LOCATION_1_NR         NUMBER(38, 0)   COMMENT 'Natural/Business Key - First part of the international location_1 number.',
   INTERNATIONAL_LOCATION_2_NR         NUMBER(38, 0)   COMMENT 'Natural/Business Key - Second part of the international location_1 number.',
   INTERNATIONAL_LOCATION_CHECKSUM_NR  NUMBER(38, 0)   COMMENT 'Natural/Business Key - Checksum for the international location_1 numbers.',
   SORT_TXT                            VARCHAR(1000)   COMMENT 'Descriptive attribute - A simple short text used for sorting',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CLIENT PRIMARY KEY (PARTY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - A client is the party that ordered goods from an external company like a supplier. - Source - LExIS';
