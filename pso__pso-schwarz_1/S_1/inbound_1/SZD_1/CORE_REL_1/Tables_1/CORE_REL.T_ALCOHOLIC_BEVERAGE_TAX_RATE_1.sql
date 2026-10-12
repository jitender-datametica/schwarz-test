/* --------------------------------------------------------------------------------
   DDL for table: T_ALCOHOLIC_BEVERAGE_TAX_RATE_1
   generated from Powerdesigner on Donnerstag, 3. August 2023 09:23:09
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_ALCOHOLIC_BEVERAGE_TAX_RATE_1 (
   COUNTRY_LOCATION_SID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the political country.',
   ALCOHOLIC_BEVERAGE_TAX_RATE_CD      VARCHAR(50)     NOT NULL COMMENT 'The unique code of the tax rate for alcoholic beverages within the country.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   ALCOHOLIC_BEVERAGE_TAX_RATE_DESCR   VARCHAR(250)    NOT NULL COMMENT 'A brief description of the tax rate for alcoholic beverages.',
   EXCISE_TAX_RATE_VAL                 NUMBER(38, 5)   NOT NULL COMMENT 'The excise rate per liter.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source.',   
   CONSTRAINT PK_ALCOHOLIC_BEVERAGE_TAX_RATE PRIMARY KEY (COUNTRY_LOCATION_SID, ALCOHOLIC_BEVERAGE_TAX_RATE_CD, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - Contains the tax rates for alcoholic beverages in a certain country. - Source - Manual';
