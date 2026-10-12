CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kostenstelle_lohnart_zu_per_2 (mandant_id, anzahl_lohnart,
betrag_lohnart, kjmo, kostenstelle_id, krk_id, lohnart_id, wrg_id) AS SELECT V01.mandant_id,
 V01.anzahl_lohnart,
  V01.betrag_lohnart * krs.umrechnungskurs AS betrag_lohnart,
 V01.kjmo,
 V01.kostenstelle_id,
 V01.krk_id,
 V01.lohnart_id,
 krs.nach_wrg_id AS wrg_id
FROM kfl_production_dbp_view.v_kostenstelle_lohnart_zu_per_2 AS V01
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
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON V01.wrg_id = krs.von_wrg_id;