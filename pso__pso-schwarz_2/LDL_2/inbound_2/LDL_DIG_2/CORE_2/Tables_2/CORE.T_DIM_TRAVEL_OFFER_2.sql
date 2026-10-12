/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_TRAVEL_OFFER_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 7. Juni 2023 09:12:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_TRAVEL_OFFER_2 (
   TRAV_OFFER_SID                      NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the travel offering',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   TRAV_OFFER_OPERATOR_CD              VARCHAR(100)    NOT NULL COMMENT 'The code for the travel offer operator',
   TRAV_OFFER_TITLE                    VARCHAR(1000)   COMMENT 'Title of the offer',
   TRAV_OFFER_DESC                     VARCHAR(250)    COMMENT 'The textual description for the travel offer',
   ACTIVE_FROM_DT                      DATE            COMMENT 'A date from which travel offer can  be booked',
   ACTIVE_TO_DT                        DATE            COMMENT 'A date until which travel offer can  be booked',
   TRAV_OFFER_TYPE_LVL1_NAME           VARCHAR(250)    COMMENT 'The textual description for the offer type at highest hierarchy_2 - level 1',
   TRAV_OFFER_TYPE_LVL2_NAME           VARCHAR(250)    COMMENT 'The textual description for the offer type at level 2''',
   TRAV_OFFER_TYPE_LVL3_NAME           VARCHAR(250)    COMMENT 'The textual description for the offer type at level 3''',
   TRAV_OFFER_TYPE_LVL4_NAME           VARCHAR(250)    COMMENT 'The textual description for the offer type at lowest hierarchy_2 - level 4''',
   TRAV_OFFER_FOOD_PACK_TYPE_CD        VARCHAR(50)     COMMENT 'The code for the food & beverage packages (All inclusive | half board | …)',
   TRAV_OFFER_ROOM_TYPE_CD             VARCHAR(50)     COMMENT 'The code for the categorization of room type (Single | double | …)',
   TRAV_OFFER_TRIP_TYPE_CD             VARCHAR(50)     COMMENT 'The code for the categorization of trip type ( Cruise | bathing holiday | round trip | …)',
   TRAV_OFFER_PROD_CLASS_CD            VARCHAR(50)     COMMENT 'The code for the categorization of a product.(Deluxe | Premium | Standard)',
   PROD_RELATED_ADDONS_FG              BOOLEAN         COMMENT 'The indicator showing if there are related product addons',
   TRAV_PRINT_ADV_ID                   VARCHAR(20)     COMMENT 'The identifier or the print media in which offer will be advertised. To be reviewed when the print media feed will be available',
   TRAV_PRINT_ADV_HEADLINE_TXT         VARCHAR(1000)   COMMENT 'The headline for the print media in which offer will be advertised. To be reviewed when the print media feed will be available',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   CONSTRAINT PK_T_DIM_TRAVEL_OFFER PRIMARY KEY (TRAV_OFFER_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'A general advertised offer for a travel';
