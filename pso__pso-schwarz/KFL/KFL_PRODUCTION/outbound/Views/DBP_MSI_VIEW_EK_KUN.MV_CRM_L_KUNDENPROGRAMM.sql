CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_l_kundenprogramm AS SELECT V01.crm_kundenprogramm_id,
 V01.mandant_id,
 V02.mandant_kbez
FROM kfl_production_dbp_view.v_crm_l_kundenprogramm AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant AS V02 ON V01.mandant_id = V02.mandant_id;