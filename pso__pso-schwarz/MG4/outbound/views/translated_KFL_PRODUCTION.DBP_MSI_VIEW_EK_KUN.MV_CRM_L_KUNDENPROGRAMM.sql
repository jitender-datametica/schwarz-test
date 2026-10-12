CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_kundenprogramm (crm_kundenprogramm_id, mandant_id,
mandant_kbez) AS SELECT v01.crm_kundenprogramm_id,
 v01.mandant_id,
 v02.mandant_kbez
FROM kfl_production_dbp_view.v_crm_l_kundenprogramm AS v01
 INNER JOIN kfl_production_dbp_view.v_mandant AS v02 ON v01.mandant_id = v02.mandant_id;