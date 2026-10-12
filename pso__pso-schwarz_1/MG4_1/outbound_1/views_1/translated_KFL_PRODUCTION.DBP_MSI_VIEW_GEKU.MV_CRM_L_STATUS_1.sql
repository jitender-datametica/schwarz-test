-- 17.07.2019 twie: SPEC0059158 Lookup CRM Status_1

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_l_status_1 (crm_status_id) AS SELECT crm_status_id
FROM kfl_production_dbp_view.v_crm_l_status_1;