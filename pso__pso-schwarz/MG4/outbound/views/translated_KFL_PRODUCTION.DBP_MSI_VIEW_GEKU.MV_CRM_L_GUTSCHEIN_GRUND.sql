-- 17.07.2019 twie: SPEC0059158 Lookup CRM Gutschein Grund

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_crm_l_gutschein_grund (crm_gutschein_grund_id) AS SELECT
 crm_gutschein_grund_id
FROM kfl_production_dbp_view.v_crm_l_gutschein_grund;