CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_dispatch_group_1 (dispatch_grp_nr
OPTIONS(description='The number which identifies the dispatch group, i.e. the group of products which are handled together in the logistics process.'),
country_org_sid OPTIONS(description='The unique identifier (surrogate key) for the country_1 organization.'),
dispatch_grp_descr
OPTIONS(description='A textual description for the dispatch group. (Description in group language, i.e. in German)'),
dispatch_grp_descr_de OPTIONS(description='A textual description for the dispatch group. (Description in German)'),
dispatch_grp_descr_en OPTIONS(description='A textual description for the dispatch group. (Description in English)'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `A DISPATCH GROUP DEFINES A GROUP OF PRODUCTS WHICH ARE HANDLED TOGETHER IN THE LOGISTICS PROCESS.`)
AS SELECT *
FROM ldl_data_core_dim.t_dim_dispatch_group_1 AS MAIN;