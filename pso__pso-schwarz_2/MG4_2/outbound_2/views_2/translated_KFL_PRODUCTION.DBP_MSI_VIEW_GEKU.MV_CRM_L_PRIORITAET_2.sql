-- 17.07.2019 twie: SPEC0059158 Lookup CRM Prioritaet
 CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_crm_l_prioritaet_2 (crm_prioritaet_id
) AS SELECT crm_prioritaet_id
FROM kfl_production_dbp_view.v_crm_l_prioritaet_2;