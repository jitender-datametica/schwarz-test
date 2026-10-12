CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_dim_ownership_ratio_type (ownership_ratio_type_cd
OPTIONS(description='The code identifying the ownership ratio of a real estate object, i.e. if it is fully owned or partly owned.'),
ownership_ratio_type_descr
OPTIONS(description='A textual description for the ownership ratio of a real estate object, (Description in group language, i.e. in German)'),
ownership_ratio_type_descr_de
OPTIONS(description='A textual description for the ownership ratio of a real estate object, (Description in German)'),
ownership_ratio_type_descr_en
OPTIONS(description='A textual description for the ownership ratio of a real estate object, (Description in English)'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION DEFINES THE OWNERSHIP RATIO OF A REAL ESTATE OBJECT, I.E. IF IT IS FULLY OWNED OR PARTLY OWNED.`)
AS SELECT ownership_ratio_type_cd,
 ownership_ratio_type_descr,
 ownership_ratio_type_descr_de,
 ownership_ratio_type_descr_en,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_ownership_ratio_type AS main;