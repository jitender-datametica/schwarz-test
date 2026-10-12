/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_COUNTRY_POLITICAL_2
   generated from Powerdesigner on Montag, 22. Januar 2024 09:24:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_COUNTRY_POLITICAL_2 (
   LOCATION_SID                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the political country.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   ISO_COUNTRY_CD                      VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The ISO code of the country.',
   COUNTRY_NAME_DE                     VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - The german name of the country.',
   COUNTRY_NAME_EN                     VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - The english name of the country.',
   CURR_CD                             VARCHAR(3)      NOT NULL COMMENT 'Denormalized Attribute - The code of the currency used in the country.',
   LATITUDE                            NUMBER(9, 6)    COMMENT 'The latitude of the geographical position of the country.',
   LONGITUDE                           NUMERIC(9,6)    COMMENT 'The longitude of the geographical position of the country.',
   EU_MEMBER_FG                        BOOLEAN         NOT NULL COMMENT 'Flag indicating whether the country_2 is member of the EU.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_COUNTRY_POLITICAL PRIMARY KEY (LOCATION_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Dimension - Contains the political countries with their codes, names in different languages and used currencies. - Source - Manual';
