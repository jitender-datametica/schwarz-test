-- 10.05.2022 twie: SPEC0145413 Lookup CRM Marke

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_crm_l_brand (crm_brand_id) AS SELECT
 crm_brand_id
FROM kfl_production_dbp_view.v_crm_l_brand;