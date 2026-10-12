CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_jzg_fakt_eingabe_1 (metrik_id, typ_id, level_id, mandant_id
, nb_id, wup_id, wrg_id, gj, zielwert_eingabe, kommentar_eingabe, zielerreich_eingabe, zeitstempel) AS SELECT JZG.metrik_id
 ,
 JZG.typ_id,
 JZG.level_id,
 JZG.mandant_id,
 JZG.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 krs.nach_wrg_id AS wrg_id,
 JZG.gj,
  CASE
  WHEN JZG.metrik_id IN (10)
  THEN JZG.wert_eingabe * krs.umrechnungskurs
  ELSE JZG.wert_eingabe
  END AS zielwert_eingabe,
 JZG.kommentar_eingabe,
 JZG.zielerreich_eingabe,
 JZG.zeitstempel
FROM kfl_production_dbp_msi_view_vis.ts_vis_jzg_ziel_eingabe_2025_1 AS JZG
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_1 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_1 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON JZG.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON JZG.mandant_id = WUP.mandant_id AND JZG.wup_id = WUP.wup_id;