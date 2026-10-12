CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_dim_brand_type_1 (brand_type_cd
OPTIONS(description='A code that identifies the brand_1 type. (own brand_1 vs. private brand_1)'), brand_type_descr
OPTIONS(description='A textual description for the brand_1 type (own brand_1 vs. private brand_1) in group language, i.e.in German.'),
brand_type_descr_de
OPTIONS(description='A textual description for the brand_1 type (own brand_1 vs. private brand_1) in German.'),
brand_type_descr_en
OPTIONS(description='A textual description for the brand_1 type (own brand_1 vs. private brand_1) in English.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THE BRAND_1 TYPE DISTINGUISHES BETWEEN OWN BRANDS AND PRIVATE BRANDS.`) AS SELECT brand_type_cd,
 brand_type_descr,
 brand_type_descr_de,
 brand_type_descr_en,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_core_dim.t_dim_brand_type_1 AS main;