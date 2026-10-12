CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_booking_food_package (
trav_booking_food_pack_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for the food & beverage packages (All inclusive | half board | …)'),
trav_booking_food_pack_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the  food & beverage packages (All inclusive | half board | …) in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.')
)
OPTIONS(description='This minor dimension defines the categorization of food & beverage packages for travel offer  (All inclusive | half board | …). Because of different sources may be different from the food package in travel offer');