CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_platzierungswg_sm_verkaufsmoebel_wup_zu_2 (mandant_id,
sok_platzierungswg_id, vs_id, sok_sm_id, sok_verkaufsmoebel_id, sok_menge_soll_flaeche, sok_flaeche_einh_id, wup_id) AS
SELECT VM.mandant_id,
 VM.platzierungswg_id AS sok_platzierungswg_id,
 VM.vs_id,
 VM.sm_id AS sok_sk_id,
 VM.verkaufsmoebel_id AS sok_verkaufsmoebel_id,
 VM.menge_soll_flaeche AS sok_menge_soll_flaeche,
 VM.flaeche_einh_id AS sok_flaeche_einh_id,
 WUP.wup_id
FROM kfl_production_dbp_view.v_platzierungswg_vs_sm_verkaufsmoebel_zu_2 AS VM
 INNER JOIN kfl_production_dbp_data.wup_2 AS WUP_2 ON VM.vs_id = WUP.vs_id AND VM.mandant_id = WUP.mandant_id
 INNER JOIN kfl_production_dbp_view.v_platzierungswg_wup_zu_2 AS PWUP ON VM.mandant_id = PWUP.mandant_id AND VM.platzierungswg_id
      = PWUP.platzierungswg_id AND WUP.wup_id = PWUP.wup_id AND VM.sm_id = PWUP.sm_id
WHERE WUP.nb_id = 0
 AND WUP.aktuell_wup_id = WUP.wup_id;