/* --------------------------------------------------------------------------------
   DDL for table: t_ref_uniform_pick_area
   generated from Powerdesigner on Mittwoch, 5. Juni 2024 15:55:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_uniform_pick_area (
pick_area_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Picking area ID as per WAMAS.'),
pick_area_descr STRING(250) OPTIONS(description='Description of the picking area.'),
pick_main_area_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Main picking area ID.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The identifier of the last load run which inserted or updated this row.'),
dwh_created DATETIME NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (pick_area_nr) NOT ENFORCED
)
OPTIONS(description='The table holds picking area information like high rack (Hochregal), freezer, chiller, etc.. from the global input.');