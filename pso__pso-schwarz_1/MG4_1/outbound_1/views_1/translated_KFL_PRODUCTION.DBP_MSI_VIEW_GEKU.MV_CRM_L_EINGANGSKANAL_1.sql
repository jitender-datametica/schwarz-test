-- 17.07.2019 twie: SPEC0059158 Lookup CRM Eingangskanal

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_crm_l_eingangskanal_1 (crm_eingangskanal_id) AS SELECT crm_eingangskanal_id
FROM kfl_production_dbp_view.v_crm_l_eingangskanal_1;