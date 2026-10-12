CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_dim_real_estate_type_1 (real_estate_type_cd
OPTIONS(description='The code identifying the subtype discriminator for real estate objects.'), real_estate_type_descr
OPTIONS(description='A textual description for the subtype discriminator for real estate objects. (Description in group language, i.e. in German)'),
real_estate_type_descr_de
OPTIONS(description='A textual description for the subtype discriminator for real estate objects. (Description in German)'),
real_estate_type_descr_en
OPTIONS(description='A textual description for the subtype discriminator for real estate objects. (Description in English)'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THIS MINOR DIMENSION DEFINES THE SUBTYPE DISCRIMINATOR FOR REAL ESTATE OBJECTS. IT DISTINGUISHES BETWEEN STORE BUILDINGS, WAREHOUSE BUILDINGS, ETC.`)
AS SELECT real_estate_type_cd,
 real_estate_type_descr,
 real_estate_type_descr_de,
 real_estate_type_descr_en,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_real_estate_type_1 AS main;