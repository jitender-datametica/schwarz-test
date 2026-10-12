CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_dim_tenant_2 (dwh_tenant_cd, dwh_tenant_name, dwh_created_tmsp,
dwh_updated_tmsp) AS SELECT *
FROM ugs_aris_production_core.t_dim_tenant_2;