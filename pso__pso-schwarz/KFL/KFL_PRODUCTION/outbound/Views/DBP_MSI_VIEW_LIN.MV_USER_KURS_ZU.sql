CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lin.mv_user_kurs_zu (mandant_id, lin_kurs_id, kursverantwortung_fg)
AS SELECT V01.mandant_id,
 V01.lin_kurs_id,
 1 AS kursverantwortung_fg
FROM kfl_production_dbp_view.v_l_lin_kurs AS V01
 INNER JOIN (SELECT V021.mandant_id,
   V021.user_id,
   V021.lin_kurs_id
  FROM kfl_production_dbp_msi_view_lin.ts_lin_kurs_user_zu AS V021
   INNER JOIN kfl_production_dbp_msi_data.akt_msi_user AS V022 ON V021.user_id = V022.user_id) AS v03 ON V01.mandant_id
   = v03.mandant_id AND V01.lin_kurs_id = v03.lin_kurs_id
GROUP BY V01.mandant_id,
 V01.lin_kurs_id,
 kursverantwortung_fg;