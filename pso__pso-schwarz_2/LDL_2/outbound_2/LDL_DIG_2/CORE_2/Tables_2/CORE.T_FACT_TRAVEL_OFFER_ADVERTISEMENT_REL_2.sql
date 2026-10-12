/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_TRAVEL_OFFER_ADVERTISEMENT_REL_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 17. August 2022 08:13:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_travel_offer_advertisement_rel_2 (
trav_print_adv_cd STRING(20) NOT NULL OPTIONS(description='The unique code for print advertisement'),
trav_offer_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the travel offering'),
trav_offer_operator_cd STRING(100) OPTIONS(description='The code for the travel offer operator'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (trav_print_adv_cd, trav_offer_sid) NOT ENFORCED
)
OPTIONS(description='The factless fact table that holds the combination of which travel offers are assigned to which print advertisements');