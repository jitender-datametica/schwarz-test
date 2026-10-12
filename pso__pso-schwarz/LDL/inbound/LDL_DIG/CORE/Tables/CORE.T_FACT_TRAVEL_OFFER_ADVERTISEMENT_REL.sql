/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_TRAVEL_OFFER_ADVERTISEMENT_REL
   GENERATED FROM POWERDESIGNER ON Mittwoch, 17. August 2022 08:13:42
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_TRAVEL_OFFER_ADVERTISEMENT_REL (
   TRAV_PRINT_ADV_CD                   VARCHAR(20)     NOT NULL COMMENT 'The unique code for print advertisement',
   TRAV_OFFER_SID                      NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the travel offering',
   TRAV_OFFER_OPERATOR_CD              VARCHAR(100)    COMMENT 'The code for the travel offer operator',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_FACT_TRAVEL_OFFER_ADVERTISEMENT_REL PRIMARY KEY (TRAV_PRINT_ADV_CD, TRAV_OFFER_SID) NOT ENFORCED
 )  COMMENT= 'The factless fact table that holds the combination of which travel offers are assigned to which print advertisements';
