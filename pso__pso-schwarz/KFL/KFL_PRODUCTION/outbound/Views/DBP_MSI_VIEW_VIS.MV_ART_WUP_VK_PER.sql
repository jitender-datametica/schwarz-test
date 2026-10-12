CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_art_wup_vk_per AS SELECT FKT.art_id,
 FKT.mandant_id,
 FKT.wup_id,
 FKT.nb_id,
 FKT.dat_von,
 FKT.dat_bis,
  FKT.vk_brutto * krs.umrechnungskurs AS vk_brutto,
 krs.nach_wrg_id AS wrg_id
FROM kfl_production_dbp_data.art_wup_vk_per AS FKT
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS nach_wrg_id,
    1.00000 AS umrechnungskurs
   FROM kfl_production_dbp_data.kurs AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'EUR', 'SIT')) AS krs ON FKT.wrg_id = krs.von_wrg_id;