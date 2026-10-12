CREATE TABLE CORE.T_DIM_DISTRIBUTION_ZONE_2 (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
   DIST_ZONE_CD                        VARCHAR(5)      NOT NULL COMMENT 'The unique code for a distribution zone ( f.e. BAL , CAN, etc)',
   DIST_ZONE_NAME                      VARCHAR(250)    NOT NULL COMMENT 'The name for a distribution zone  ( f.e. ''Balearic Islands'' etc)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_DISTRIBUTION_ZONE PRIMARY KEY (WSHOP_CD, DIST_ZONE_CD) NOT ENFORCED 
)  COMMENT = 'A distribution zone is a division within the Lidl Webshop, typically used when territories are separated from a mainland. A Webshop can have one or more distribution zones, defined according to official administrative divisions within each country. These different distribution zones may have variations in assortment, promotion dates, campaigns, pricing for end customers (due to VAT differences), tax information, shipping costs, delivery times, and additional services.';
