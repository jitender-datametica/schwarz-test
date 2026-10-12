CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_jzg_ziel_wert_2 (mandant_id, nb_id, wup_id, wrg_id, gj,
metrik_id, typ_id, level_id, wert_eingabe, kommentar_eingabe, zeitstempel) AS SELECT JZG.mandant_id,
 JZG.nb_id,
 JZG.wup_id,
 krs.nach_wrg_id AS wrg_id,
 JZG.gj,
 JZG.metrik_id,
 JZG.typ_id,
 JZG.level_id,
  CASE
  WHEN JZG.metrik_id IN (10)
  THEN JZG.wert_eingabe * krs.umrechnungskurs
  ELSE JZG.wert_eingabe
  END AS wert_eingabe,
 JZG.kommentar_eingabe,
 JZG.zeitstempel
FROM kfl_production_dbp_msi_view_vis.ts_vis_jzg_ziel_eingabe_2 AS JZG
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_2 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_2 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON JZG.wrg_id = krs.von_wrg_id;