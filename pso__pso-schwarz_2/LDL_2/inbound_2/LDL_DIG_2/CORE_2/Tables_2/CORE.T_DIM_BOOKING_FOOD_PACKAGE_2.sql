CREATE TABLE CORE.T_DIM_BOOKING_FOOD_PACKAGE_2 (
	TRAV_BOOKING_FOOD_PACK_TYPE_CD VARCHAR(5) NOT NULL COMMENT 'The code for the food & beverage packages (All inclusive | half board | …)',
	TRAV_BOOKING_FOOD_PACK_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the  food & beverage packages (All inclusive | half board | …) in group language (German).',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.'
)COMMENT='This minor dimension defines the categorization of food & beverage packages for travel offer  (All inclusive | half board | …). Because of different sources may be different from the food package_2 in travel offer'
;