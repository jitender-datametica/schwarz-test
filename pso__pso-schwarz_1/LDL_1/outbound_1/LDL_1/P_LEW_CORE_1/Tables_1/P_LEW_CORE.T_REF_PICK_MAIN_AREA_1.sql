/* --------------------------------------------------------------------------------
   DDL for table: t_ref_pick_main_area_1
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 15:52:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_pick_main_area_1 (
pick_main_area_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Picking main area ID that consolidates the picking area.'),
pick_main_area_descr STRING(250) OPTIONS(description='Description of the picking main area.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (pick_main_area_nr) NOT ENFORCED
)
OPTIONS(description='Reference table of picking area to the picking main area. Picking main areas are groupings of picking areas.');