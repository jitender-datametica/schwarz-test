/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_FREE_TRADE_AGREEMENT
   generated from Powerdesigner on Donnerstag, 6. Juli 2023 14:08:52
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_FREE_TRADE_AGREEMENT (
   AGREEMENT_SID                       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) of the free trade agreement.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   IMPORT_COUNTRY_LOCATION_SID         NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - The unique identifier (surrogate key) of the political country that import goods.',
   IMPORT_ISO_COUNTRY_CD               VARCHAR(50)     NOT NULL COMMENT 'Denormalized Attribute - The ISO code of the political country that import goods.',
   IMPORT_COUNTRY_NAME_DE              VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - The german name of the political country that import goods.',
   IMPORT_COUNTRY_NAME_EN              VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - The english name of the political country that import goods.',
   ORIGIN_COUNTRY_LOCATION_SID         NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - The unique identifier (surrogate key) of the political country where the goods comes from.',
   ORIGIN_ISO_COUNTRY_CD               VARCHAR(50)     NOT NULL COMMENT 'Denormalized Attribute - The ISO code of the political country where the goods comes from.',
   ORIGIN_COUNTRY_NAME_DE              VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - The german name of the political country where the goods comes from.',
   ORIGIN_COUNTRY_NAME_EN              VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - The german name of the political country where the goods comes from.',
   FREE_TRADE_AGREEMENT_CATEGORY_CD    VARCHAR(50)     NOT NULL COMMENT 'The unique code of the category of a free trade agreement.',
   FREE_TRADE_AGREEMENT_CATEGORY_NAME  VARCHAR(50)     NOT NULL COMMENT 'The name of the category.',
   FREE_TRADE_AGREEMENT_CATEGORY_DESCR VARCHAR(250)    NOT NULL COMMENT 'A brief description of the free trade agreement category.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_FREE_TRADE_AGREEMENT PRIMARY KEY (AGREEMENT_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Dimension - Contains free trade agreements between the country that import goods and the country where products are imported from. - Source - Manual';
