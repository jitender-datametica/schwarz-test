CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_dim_real_estate_replacement_type (real_estate_replacement_type_cd
OPTIONS(description='The code identifying the way, how a real estate object can replace another object. There are two types of replacments: Relocations and demolition and a new construction.'),
real_estate_replacement_type_descr
OPTIONS(description='A textual description for the way, how a real estate object can replace another object. (Description in group language, i.e. in German)'),
real_estate_replacement_type_descr_de
OPTIONS(description='A textual description for the way, how a real estate object can replace another object. (Description in German)'),
real_estate_replacement_type_descr_en
OPTIONS(description='A textual description for the way, how a real estate object can replace another object. (Description in English)'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION DEFINES THE WAY, HOW A REAL ESTATE OBJECT CAN REPLACE ANOTHER OBJECT. THERE ARE TWO TYPES OF REPLACMENTS: RELOCATIONS AND DEMOLITION AND A NEW CONSTRUCTION.`)
AS SELECT *
FROM ldl_data_core_dim.t_dim_real_estate_replacement_type AS MAIN;