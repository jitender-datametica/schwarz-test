CREATE OR REPLACE VIEW fe_mstr_master.v_dim_real_estate_current_status_2 (real_estate_status_cd
OPTIONS(description='The code identifying the lifecycle status_2 for real estate objects. (This is the business lifecycle, so it might differ from the status_2 code shown in the source system.)'),
real_estate_status_descr
OPTIONS(description='A textual description for the lifecycle status_2 for real estate objects. (Description in group language, i.e. in German)'),
real_estate_status_descr_de
OPTIONS(description='A textual description for the lifecycle status_2 for real estate objects. (Description in German)'),
real_estate_status_descr_en
OPTIONS(description='A textual description for the lifecycle status_2 for real estate objects. (Description in English)'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION DEFINES THE LIFECYCLE STATUS_2 FOR REAL ESTATE OBJECTS.. E.G. AN OBJECT MAY BE UNDER CONTRACT, OPEN, CLOSED OR TERMINATED. (THIS IS THE BUSINESS LIFECYCLE, SO IT MIGHT DIFFER FROM THE STATUS_2 CODE SHOWN IN THE SOURCE SYSTEM.), LOOKUP VIEW FOR THE ATTRIBUTE REAL ESTATE CURRENT STATUS_2`)
AS SELECT *
FROM ldl_data_core_dim.t_dim_real_estate_status_2 AS MAIN;