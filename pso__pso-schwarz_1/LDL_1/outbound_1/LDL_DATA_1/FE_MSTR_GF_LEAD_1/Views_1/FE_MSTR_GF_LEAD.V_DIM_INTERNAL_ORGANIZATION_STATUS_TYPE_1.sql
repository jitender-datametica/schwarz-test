CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_dim_internal_organization_status_type_1 (int_org_status_cd
OPTIONS(description='The code for the lifecycle status_1 of an internal organization.'), int_org_status_descr
OPTIONS(description='A textual description for the lifecycle status_1 of an internal organization in group language, i.e. in German.'),
int_org_status_descr_de
OPTIONS(description='A textual description for the lifecycle status_1 of an internal organization in German.'),
int_org_status_descr_en
OPTIONS(description='A textual description for the lifecycle status_1 of an internal organization in English.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.')) AS
SELECT *
FROM ldl_data_core_dim.t_dim_internal_organization_status_type_1;