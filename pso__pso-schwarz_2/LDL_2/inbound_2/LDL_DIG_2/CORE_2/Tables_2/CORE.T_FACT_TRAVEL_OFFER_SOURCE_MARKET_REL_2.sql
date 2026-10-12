/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_TRAVEL_OFFER_SOURCE_MARKET_REL_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 17. August 2022 08:14:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_TRAVEL_OFFER_SOURCE_MARKET_REL_2 (
   TRAV_SOURCE_MARKET_CD               VARCHAR(5)      NOT NULL COMMENT 'The code for the source market in Lidl Travel',
   TRAV_OFFER_SID                      NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the travel offering',
   TRAV_OFFER_ACTIVE_FROM_TMSP         TIMESTAMP_LTZ(9) COMMENT 'The timestamp from when the travel offer is valid',
   TRAV_OFFER_ACTIVE_TO_TMSP           TIMESTAMP_LTZ(9) COMMENT 'The timestamp till when the travel offer is valid',
   TRAV_OFFER_ACTIVE_FG                BOOLEAN         COMMENT 'The indicator for identifying the active offers',
   TRAV_OFFER_OPERATOR_CD              VARCHAR(100)    COMMENT 'The code for the travel offer operator',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source table',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_TRAVEL_OFFER_SOURCE_MARKET_REL PRIMARY KEY (TRAV_SOURCE_MARKET_CD, TRAV_OFFER_SID) NOT ENFORCED
 )  COMMENT= 'This factless fact table holds the details of travel offers that can be activated for several markets.
             ';
