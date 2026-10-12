CREATE OR REPLACE VIEW ldl_data_production_meta.v_tenant_1 (tenant_cd
OPTIONS(description='The code identifying the tenant, i.e. the organizational unit_1 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.'),
tenant_name
OPTIONS(description='The name of the tenant, i.e. the organizational unit_1 within the Schwarz Group which operates its own data warehouse. I.e. Lidl, Kaufland, Lidl Digital, etc.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'), dwh_load_id
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'))
OPTIONS(DESCRIPTION = `THE TENANT DESCRIBES AN ORGANIZATIONAL UNIT_1 WITHIN THE SCHWARZ GROUP WHICH OPERATES ITS OWN DATA WAREHOUSE. I.E. LIDL, KAUFLAND, LIDL DIGITAL, ETC.`)
AS SELECT tenant_cd,
 tenant_name,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_load_id,
 dwh_node_cd
FROM ldl_data_production_meta.t_tenant_1
UNION DISTINCT
SELECT '@',
 'Unknown tenant',
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
 - 1,
 'MANUAL';