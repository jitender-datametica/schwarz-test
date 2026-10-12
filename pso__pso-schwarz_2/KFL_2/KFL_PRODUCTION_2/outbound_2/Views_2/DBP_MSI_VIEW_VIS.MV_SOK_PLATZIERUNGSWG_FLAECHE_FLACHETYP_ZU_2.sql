CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sok_platzierungswg_flaeche_flachetyp_zu_2 (mandant_id,
sok_platzierungswg_id, ginfo_flaeche_id, ginfo_flaeche_typ_id, techn_platz_id, flaeche_quelle_id, wup_id) AS SELECT FL.mandant_id
 ,
 FL.platzierungswg_id AS sok_platzierungswg_id,
 FL.ginfo_flaeche_id,
 FL.ginfo_flaeche_typ_id,
 FL.techn_platz_id,
 FL.flaeche_quelle_id,
 TPL.wup_id
FROM kfl_production_dbp_view.v_platzierungswg_flaeche_flachetyp_zu_2 AS FL
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_wup_techn_platz_2 AS TPL ON FL.techn_platz_id = TPL.techn_platz_id;