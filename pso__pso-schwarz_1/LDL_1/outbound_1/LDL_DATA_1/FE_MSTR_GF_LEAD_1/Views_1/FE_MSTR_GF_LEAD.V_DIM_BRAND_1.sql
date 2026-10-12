CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_dim_brand_1 (brand_name OPTIONS(description='The name of the brand.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THE BRAND_1 DIMENSION LISTS THE NAMES UNDER WHICH PRODUCTS ARE MARKETED. (E.G. MILKA, LEGO, ...)`)
AS SELECT *
FROM ldl_data_core_dim.t_dim_brand_1 AS MAIN;