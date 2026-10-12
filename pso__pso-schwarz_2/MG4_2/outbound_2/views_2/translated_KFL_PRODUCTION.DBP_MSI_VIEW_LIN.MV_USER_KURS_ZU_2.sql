CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_user_kurs_zu_2 (mandant_id, lin_kurs_id, kursverantwortung_fg)
AS SELECT v01.mandant_id,
 v01.lin_kurs_id,
 1 AS kursverantwortung_fg
FROM kfl_production_dbp_view.v_l_lin_kurs_2 AS v01
 INNER JOIN (SELECT v021.mandant_id,
   v021.user_id,
   v021.lin_kurs_id
  FROM kfl_production_dbp_msi_view_lin.ts_lin_kurs_user_zu_2 AS v021
   INNER JOIN kfl_production_dbp_msi_data.akt_msi_user_2 AS v022 ON v021.user_id = v022.user_id) AS v03 ON v01.mandant_id
   = v03.mandant_id AND v01.lin_kurs_id = v03.lin_kurs_id
GROUP BY v01.mandant_id,
 v01.lin_kurs_id,
 kursverantwortung_fg;