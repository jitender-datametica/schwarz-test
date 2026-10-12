-- 17.07.2019 twie: SPEC0059158 Lookup CRM Eigenmarke
 CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_crm_l_eigenmarke_1 (crm_eigenmarke_id
) AS SELECT crm_eigenmarke_id
FROM kfl_production_dbp_view.v_crm_l_eigenmarke_1;