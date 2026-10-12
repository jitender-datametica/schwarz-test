CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_wup_zu_per_1 AS SELECT AWP.mandant_id,
 AWP.nb_id,
 AWP.wup_id,
 AWP.dat_von,
 AWP.dat_bis,
 AWP.art_id,
 AWP.bezugsweg_id,
 AWP.listung_id,
 AWP.kdis,
  AWP.vk_brutto * krs.umrechnungskurs AS vk_brutto,
 krs.nach_wrg_id AS wrg_id
FROM kfl_production_dbp_view.v_art_wup_zu_per_1 AS AWP
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_1 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS nach_wrg_id,
    1.00000 AS umrechnungskurs
   FROM kfl_production_dbp_data.kurs_1 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'EUR', 'SIT')) AS krs ON AWP.wrg_id = krs.von_wrg_id;