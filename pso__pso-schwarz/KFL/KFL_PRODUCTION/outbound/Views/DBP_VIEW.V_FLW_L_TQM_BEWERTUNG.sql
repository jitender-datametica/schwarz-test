CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_l_tqm_bewertung AS SELECT mandant_id,
 fehler_prozent_bis,
 system_id,
 fehler_prozent_von,
 punkte_sap_kf,
 punkte_sap_vk,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_l_tqm_bewertung;