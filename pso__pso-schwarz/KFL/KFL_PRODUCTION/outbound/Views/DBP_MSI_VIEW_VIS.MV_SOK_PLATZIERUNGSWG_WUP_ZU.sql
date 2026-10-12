CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_platzierungswg_wup_zu (mandant_id, sok_platzierungswg_id,
wup_id, nb_id, sok_sm_id, sok_sap_sm_id, sok_anz_artikel, sok_menge_soll_flaeche_regio) AS SELECT WUP.mandant_id,
 WUP.platzierungswg_id AS sok_platzierungswg_id,
 WUP.wup_id,
 WUP.nb_id,
 WUP.sm_id AS sok_sm_id,
 sm.sap_sm_id AS sok_sap_sm_id,
 WUP.anz_artikel AS sok_anz_artikel,
 WUP.menge_soll_flaeche_regio AS sok_menge_soll_flaeche_regio
FROM kfl_production_dbp_view.v_platzierungswg_wup_zu AS WUP
 INNER JOIN (SELECT DISTINCT mandant_id,
   sm_id,
   sap_sm_id
  FROM kfl_production_dbp_view.v_sm) AS sm ON WUP.mandant_id = sm.mandant_id AND WUP.sm_id = sm.sm_id;