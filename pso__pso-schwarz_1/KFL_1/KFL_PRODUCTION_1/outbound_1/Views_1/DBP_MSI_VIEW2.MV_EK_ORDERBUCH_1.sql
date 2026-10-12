CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_ek_orderbuch_1 (art_id, mandant_id, wup_id, nb_id, gp_id,
orderbuch_gueltig) AS SELECT DISTINCT art_id,
 mandant_id,
 wup_id,
 nb_id,
 gp_id,
 'gültiger Orderbucheintrag' AS orderbuch_gueltig
FROM kfl_production_dbp_view.v_ek_orderbuch_1 AS V01
WHERE mandant_id = 1
 AND gesperrt_fg = 0
 AND DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN dat_von AND dat_bis
UNION ALL
SELECT DISTINCT art_id,
 mandant_id,
 wup_id,
 nb_id,
 gp_id,
 'ungültiger Orderbucheintrag' AS orderbuch_gueltig
FROM kfl_production_dbp_view.v_ek_orderbuch_1 AS V02
WHERE mandant_id = 1
 AND (art_id, mandant_id, wup_id, nb_id, gp_id) NOT IN (SELECT (art_id, mandant_id, wup_id, nb_id, gp_id)
   FROM (SELECT DISTINCT art_id,
      mandant_id,
      wup_id,
      nb_id,
      gp_id
     FROM kfl_production_dbp_view.v_ek_orderbuch_1
     WHERE mandant_id = 1
      AND gesperrt_fg = 0
      AND DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN dat_von AND dat_bis) AS t4);