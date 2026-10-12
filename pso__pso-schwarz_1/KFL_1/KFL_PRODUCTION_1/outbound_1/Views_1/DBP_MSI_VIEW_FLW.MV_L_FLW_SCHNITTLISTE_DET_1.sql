CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_schnittliste_det_1 (mandant_id, schnittliste_id,
schnitt_id, sek_schl_typ_id, sek_schl_id, schnitt_verwendung_prozent) AS SELECT mandant_id,
 schnittliste_id,
 schnitt_id,
 sek_schl_typ_id,
 sek_schl_id,
 schnitt_verwendung_prozent
FROM kfl_production_dbp_view.v_flw_schnittliste_det_1
WHERE sek_schl_typ_id IN ('M', 'P');