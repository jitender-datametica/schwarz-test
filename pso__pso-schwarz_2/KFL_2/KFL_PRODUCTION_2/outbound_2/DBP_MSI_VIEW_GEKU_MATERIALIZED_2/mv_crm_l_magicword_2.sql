-- 10.05.2022 twie: SPEC0145413 Lookup CRM Zauberwort

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_crm_l_magicword_2 (crm_magicword_id) AS SELECT
 crm_magicword_id
FROM dbp_view.v_crm_l_magicword_2;