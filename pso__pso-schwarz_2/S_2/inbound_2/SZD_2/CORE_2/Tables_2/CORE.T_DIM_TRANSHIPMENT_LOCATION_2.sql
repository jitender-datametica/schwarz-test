/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_TRANSHIPMENT_LOCATION_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_TRANSHIPMENT_LOCATION_2 (
   LOCATION_SID                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the transhipment location.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   COUNTRY_LOCATION_SID                NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - The unique identifier (surrogate key) of the political country.',
   ISO_COUNTRY_CD                      VARCHAR(50)     NOT NULL COMMENT 'Denormalized Attribute - The ISO code of the country.',
   COUNTRY_NAME_DE                     VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - The german name of the country.',
   COUNTRY_NAME_EN                     VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - The english name of the country.',
   TRANSHIPMENT_LOCATION_CD            VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The unique code of the transhipment location.',
   TRANSHIPMENT_LOCATION_NAME          VARCHAR(100)    NOT NULL COMMENT 'The name of the transhipment location.',
   CITY_NAME                           VARCHAR(100)    COMMENT 'The name of the city where the transhipment location_2 is located.',
   TRANSHIPMENT_LOCATION_TYPE_CD       VARCHAR(50)     NOT NULL COMMENT 'The unique code of the type of transhipment location.',
   TRANSHIPMENT_LOCATION_TYPE_NAME     VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - The name of the transhipment location.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_TRANSHIPMENT_LOCATION PRIMARY KEY (LOCATION_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Dimension - At the goods transshipment location_2, goods are reloaded from one transport medium (e.g. a ship) to another transport medium (e.g. a truck) in order to then be transported on to the destination. - Source - Manual';
