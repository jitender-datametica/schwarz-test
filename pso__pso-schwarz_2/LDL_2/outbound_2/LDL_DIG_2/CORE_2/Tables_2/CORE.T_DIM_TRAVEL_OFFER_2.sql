/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_TRAVEL_OFFER_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 7. Juni 2023 09:12:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_travel_offer_2 (
trav_offer_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the travel offering'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
trav_offer_operator_cd STRING(100) NOT NULL OPTIONS(description='The code for the travel offer operator'),
trav_offer_title STRING(1000) OPTIONS(description='Title of the offer'),
trav_offer_desc STRING(250) OPTIONS(description='The textual description for the travel offer'),
active_from_dt DATE OPTIONS(description='A date from which travel offer can  be booked'),
active_to_dt DATE OPTIONS(description='A date until which travel offer can  be booked'),
trav_offer_type_lvl1_name STRING(250)
OPTIONS(description='The textual description for the offer type at highest hierarchy_2 - level 1'),
trav_offer_type_lvl2_name STRING(250) OPTIONS(description='The textual description for the offer type at level 2\''),
trav_offer_type_lvl3_name STRING(250) OPTIONS(description='The textual description for the offer type at level 3\''),
trav_offer_type_lvl4_name STRING(250)
OPTIONS(description='The textual description for the offer type at lowest hierarchy_2 - level 4\''),
trav_offer_food_pack_type_cd STRING(50)
OPTIONS(description='The code for the food & beverage packages (All inclusive | half board | …)'),
trav_offer_room_type_cd STRING(50)
OPTIONS(description='The code for the categorization of room type (Single | double | …)'),
trav_offer_trip_type_cd STRING(50)
OPTIONS(description='The code for the categorization of trip type ( Cruise | bathing holiday | round trip | …)'),
trav_offer_prod_class_cd STRING(50)
OPTIONS(description='The code for the categorization of a product.(Deluxe | Premium | Standard)'),
prod_related_addons_fg BOOL OPTIONS(description='The indicator showing if there are related product addons'),
trav_print_adv_id STRING(20)
OPTIONS(description='The identifier or the print media in which offer will be advertised. To be reviewed when the print media feed will be available'),
trav_print_adv_headline_txt STRING(1000)
OPTIONS(description='The headline for the print media in which offer will be advertised. To be reviewed when the print media feed will be available'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (trav_offer_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='A general advertised offer for a travel');