CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_bestand_wg_1 (mandant_id, nb_id, wup_id, bezugsweg_id,
relevant_fg, arthiertyp_id, abt_id, wg_id, gj, kjmo, kjwo, dat, offen, anz_artikel_bestand, anz_artikel_fehlmengen,
anz_artikel_nullbestand, anz_artikel_minusbestand) AS SELECT V01.mandant_id,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
  CASE
  WHEN V01.abt_id = 1 AND V01.bezugsweg_id = 1
  THEN V01.bezugsweg_id + 3
  ELSE V01.bezugsweg_id
  END AS bezugsweg_id,
 V01.relevant_fg,
 V01.arthiertyp_id,
 V01.abt_id,
 V01.wg_id,
 V01.gj,
 V01.kjmo,
 V01.kjwo,
 V01.dat,
 V02.offen,
 V01.anz_artikel_bestand,
 V01.anz_artikel_fehlmengen,
 V01.anz_artikel_nullbestand,
 V01.anz_artikel_minusbestand
FROM kfl_production_dbp_msi_v_view.v_vis_tag_bestand_wg_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wupcal_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id AND
    V01.dat = V02.dat AND V02.offen = 1
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;