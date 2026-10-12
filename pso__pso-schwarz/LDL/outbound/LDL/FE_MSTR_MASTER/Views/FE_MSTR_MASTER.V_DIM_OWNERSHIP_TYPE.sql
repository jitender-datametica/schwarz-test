CREATE OR REPLACE VIEW fe_mstr_master.v_dim_ownership_type (ownership_type_cd
OPTIONS(description='The code identifying the ownership type of a real estate object, i.e. if it has been bought or if it is rented.'),
ownership_type_descr
OPTIONS(description='A textual description for the ownership type of a real estate object, (Description in group language, i.e. in German)'),
ownership_type_descr_de
OPTIONS(description='A textual description for the ownership type of a real estate object, (Description in German)'),
ownership_type_descr_en
OPTIONS(description='A textual description for the ownership type of a real estate object, (Description in English)'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION DEFINES THE OWNERSHIP TYPE OF A REAL ESTATE OBJECT, I.E. IF IT HAS BEEN BOUGHT OR IF IT IS RENTED.`)
AS SELECT *
FROM ldl_data_core_dim.t_dim_ownership_type AS MAIN;