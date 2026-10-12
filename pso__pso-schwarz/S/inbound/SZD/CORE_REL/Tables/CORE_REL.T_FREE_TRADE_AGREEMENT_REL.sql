/* --------------------------------------------------------------------------------
   DDL for table: T_FREE_TRADE_AGREEMENT_REL
   generated from Powerdesigner on Donnerstag, 6. Juli 2023 09:09:15
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_FREE_TRADE_AGREEMENT_REL (
   AGREEMENT_SID                       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key of the free trade agreement..',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   IMPORT_COUNTRY_LOCATION_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the import country as one party of the free trade agreement..',
   ORIGIN_COUNTRY_LOCATION_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the origin country as one party of the free trade agreement.',
   FREE_TRADE_AGREEMENT_CATEGORY_CD    VARCHAR(50)     NOT NULL COMMENT 'The unique code of the category of a free trade agreement.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_FREE_TRADE_AGREEMENT_REL PRIMARY KEY (AGREEMENT_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Bridge - Contains information about an existing free trade agreement between an import country and an origin country. - Source - Manual';
