-- 22.07.2019 twie: SPEC0059158 Lookup CRM Prozess
 CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_crm_l_prozess_2 (crm_prozess_id
) AS SELECT crm_prozess_id
FROM kfl_production_dbp_view.v_crm_l_prozess_2;