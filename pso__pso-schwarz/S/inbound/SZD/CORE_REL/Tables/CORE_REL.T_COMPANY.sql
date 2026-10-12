/* --------------------------------------------------------------------------------
   DDL for table: T_COMPANY
   generated from Powerdesigner on Donnerstag, 28. November 2024 11:30:02
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_COMPANY (
   PARTY_SID                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the company.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   COMPANY_STATUS_CD                   VARCHAR(250)    NOT NULL COMMENT 'The status code for the company',
   COMPANY_TYPE_CD                     VARCHAR(50)     NOT NULL COMMENT 'The code for the type of the company (internal or external). An internal company is contracted by the internal group of companies itself. An external company is commissioned by the supplier.',
   COMPANY_ID                          VARCHAR(250)    NOT NULL COMMENT 'Natural/Business Key - A technical identifier from original source system',
   COMPANY_NR                          VARCHAR(250)    COMMENT 'Natural/Business Key - A numeric or alphanumeric value which identifies the company for the business.',
   COMPANY_NAME                        VARCHAR(100)    NOT NULL COMMENT 'Descriptive attribute - The name by which the company is known cut at 100 characters.',
   SOURCE_COMPANY_NAME_ADDRESS_CITY_TXT VARCHAR(1000)   NOT NULL COMMENT 'Descriptive attribute - The name the company and maybe it''s address, city and other things as delivered directly from source. - Source: VMT',
   RELATED_COMPANY_PARTY_SID           NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the related company.',
   EMAIL_TXT                           VARCHAR(1000)   COMMENT 'Descriptive attribute - Email of the company',
   ADDITIONAL_NAME_1_TXT               VARCHAR(1000)   COMMENT 'Descriptive attribute - an additional name or part of the name of a company, may contains the type of legal entity of the company like ''GmbH'', ''Limited'', Co. KG'' or others but could also be just a part of a companies name',
   ADDITIONAL_NAME_2_TXT               VARCHAR(1000)   COMMENT 'Descriptive attribute - an additional name or part of the name of a company, may contains the type of legal entity of the company like ''GmbH'', ''Limited'', Co. KG'' or others but could also be just a part of a companies name',
   INTERNATIONAL_LOCATION_1_NR         NUMBER(38, 0)   COMMENT 'Natural/Business Key - First part of the international location number.',
   INTERNATIONAL_LOCATION_2_NR         NUMBER(38, 0)   COMMENT 'Natural/Business Key - Second part of the international location number.',
   INTERNATIONAL_LOCATION_CHECKSUM_NR  NUMBER(38, 0)   COMMENT 'Natural/Business Key - Checksum for the international location numbers.',
   SORT_TXT                            VARCHAR(1000)   COMMENT 'Descriptive attribute - A simple short text used for sorting',
   VAT_NUMBER                          VARCHAR(250)    COMMENT 'Descriptive attribute - The VAT identification number of the company.',
   SRC_SYS_NAME                        VARCHAR(1000)   COMMENT 'Descriptive attribute - System Identifier from SAP',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_COMPANY PRIMARY KEY (PARTY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - This entity contains all companies that we interact with, e.g. Supplier ,  Hauler,  Handling agents , etc - Source - Manual / Excel Report from CDS, Broker (per Mail), VMT, LExIS';
