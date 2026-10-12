/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_DISTRIBUTION_ZONE_TAX_CLASS_2
   GENERATED FROM POWERDESIGNER ON Dienstag, 15. Juli 2025 11:06:51
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_DISTRIBUTION_ZONE_TAX_CLASS_2 (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
   DIST_ZONE_CD                        VARCHAR(5)      NOT NULL COMMENT 'The unique code for a distribution zone ( f.e. BAL , CAN, etc)',
   TAX_CLASS_CD                        VARCHAR(5)      NOT NULL COMMENT 'The code identifying the tax class',
   ACTIVE_FROM_DT                      DATE            NOT NULL COMMENT 'The first date when this record became valid from a business perspective in the real world (not to be confused with technical validity_2 date - when record is inserted in some system)',
   ACTIVE_TO_DT                        DATE            NOT NULL COMMENT 'The last date until this record was valid from a business perspective in the real world (not to be confused with technical validity_2 date - when record expired in some system)',
   ACTIVE_FG                           BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record from a business perspective, i.e. where the current date is between active_from_dt and active_to_dt',
   TAX_CLASS_PCT                       NUMERIC(38,5)   NOT NULL COMMENT 'The tax percentage for the tax class.',
   COUNTRY_CD                          VARCHAR(5)      COMMENT 'The unique code for a country_2 according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',   
   CONSTRAINT PK_T_DIM_DISTRIBUTION_ZONE_TAX_CLASS PRIMARY KEY (TAX_CLASS_CD, WSHOP_CD, DIST_ZONE_CD, ACTIVE_FROM_DT) NOT ENFORCED 
)  COMMENT = 'This minor dimension defines tax classes for distribution zones. A distribution zone is a division within the Lidl Webshop, typically used when territories are separated from a mainland e,g CAN = Canary Islands, BLR = Balearic Islands etc.. A Webshop can have one or more distribution zones, defined according to official administrative divisions within each country. These different distribution zones may have variations in assortment, promotion dates, campaigns, pricing for end customers (due to VAT differences), tax information, shipping costs, delivery times, and additional services.';
