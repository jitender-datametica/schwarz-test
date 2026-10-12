-- 22.07.2019 twie: SPEC0059158 Lookup CRM Fremdkoerper
 CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_crm_l_fremdkoerper_2
(crm_fremdkoerper_id) AS SELECT crm_fremdkoerper_id
FROM kfl_production_dbp_view.v_crm_l_fremdkoerper_2;