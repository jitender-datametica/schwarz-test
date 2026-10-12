CREATE TABLE CORE.T_DIM_TRAVEL_BOOKING_FOOD_PACKAGE_2 (
   trav_booking_food_pack_type_cd      VARCHAR(5)      NOT NULL COMMENT 'The code for the food & beverage packages (All inclusive | half board | …)',
   trav_booking_food_pack_type_descr   VARCHAR(250)    NOT NULL COMMENT 'A textual description for the  food & beverage packages (All inclusive | half board | …) in group language (German).',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_TRAVEL_BOOKING_FOOD_PACKAGE PRIMARY KEY (trav_booking_food_pack_type_cd)
)
COMMENT = 'This minor dimension defines the categorization of food & beverage packages for travel booking  (All inclusive | half board | …). Because of different sources may be different from the food package_2 in travel offer';
