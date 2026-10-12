CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_flaeche_status_historie_2 AS SELECT fl000.mandant_id,
 fl000.flaeche_id,
 fl000.mietvertrag_id,
 CAST(CASE
   WHEN fl000.fl_status_id_aktuell <> COALESCE(fl030.fl_status_id_minus_30_tage, '-')
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS fl_status_fg,
 fl000.fl_status_id_aktuell,
 COALESCE(fl030.fl_status_id_minus_30_tage, '-') AS fl_status_id_minus_30_tage,
 COALESCE(fl365.fl_status_id_minus_365_tage, '-') AS fl_status_id_minus_365_tage
FROM (SELECT FL.mandant_id,
   FL.flaeche_id,
   mfszp.mietvertrag_id,
   CAST(CASE
     WHEN CURRENT_DATE BETWEEN FL.dat_existiert_seit AND FL.dat_existiert_bis
     THEN TRIM(SUBSTR(CAST(mfszp.flaeche_status_id_ AS STRING), 1, 39))
     WHEN FL.dat_existiert_seit BETWEEN CURRENT_DATE AND FL.dat_existiert_bis
     THEN TRIM(SUBSTR(CAST(mfszp.flaeche_status_id_ AS STRING), 1, 39))
     ELSE '-'
     END AS STRING) AS fl_status_id_aktuell
  FROM kfl_production_dbp_view.v_ivs_flaeche_per_2 AS FL
   INNER JOIN (SELECT mandant_id,
     flaeche_id,
     mietvertrag_id,
     flaeche_status_id AS flaeche_status_id_
    FROM kfl_production_dbp_view.v_ivs_miet_fl_stat_zu_per_2 AS MFZP
    WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis) AS mfszp ON FL.mandant_id = mfszp.mandant_id AND FL.flaeche_id =
     mfszp.flaeche_id
  WHERE FL.dat_bis = DATE '9999-12-31') AS fl000
 LEFT JOIN (SELECT FL0.mandant_id,
   FL0.flaeche_id,
   mfszp.mietvertrag_id,
   CAST(CASE
     WHEN DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY) BETWEEN FL0.dat_existiert_seit AND FL0.dat_existiert_bis
     THEN TRIM(SUBSTR(CAST(mfszp.flaeche_status_id_ AS STRING), 1, 39))
     ELSE '-'
     END AS STRING) AS fl_status_id_minus_30_tage
  FROM kfl_production_dbp_view.v_ivs_flaeche_per_2 AS FL0
   INNER JOIN (SELECT mandant_id,
     flaeche_id,
     mietvertrag_id,
     flaeche_status_id AS flaeche_status_id_
    FROM kfl_production_dbp_view.v_ivs_miet_fl_stat_zu_per_2 AS MFZP
    WHERE DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY) BETWEEN dat_von AND dat_bis) AS mfszp ON FL0.mandant_id = mfszp.mandant_id
      AND FL0.flaeche_id = mfszp.flaeche_id
  WHERE DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY) BETWEEN FL0.dat_von AND FL0.dat_bis) AS fl030 ON fl000.mandant_id =
    fl030.mandant_id AND fl000.flaeche_id = fl030.flaeche_id AND fl000.mietvertrag_id = fl030.mietvertrag_id
 LEFT JOIN (SELECT FL1.mandant_id,
   FL1.flaeche_id,
   mfszp.mietvertrag_id,
   CAST(CASE
     WHEN DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY) BETWEEN FL1.dat_existiert_seit AND FL1.dat_existiert_bis
     THEN TRIM(SUBSTR(CAST(mfszp.flaeche_status_id_ AS STRING), 1, 39))
     ELSE '-'
     END AS STRING) AS fl_status_id_minus_365_tage
  FROM kfl_production_dbp_view.v_ivs_flaeche_per_2 AS FL1
   INNER JOIN (SELECT mandant_id,
     flaeche_id,
     mietvertrag_id,
     flaeche_status_id AS flaeche_status_id_
    FROM kfl_production_dbp_view.v_ivs_miet_fl_stat_zu_per_2 AS MFZP
    WHERE DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY) BETWEEN dat_von AND dat_bis) AS mfszp ON FL1.mandant_id = mfszp.mandant_id
      AND FL1.flaeche_id = mfszp.flaeche_id
  WHERE DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY) BETWEEN FL1.dat_von AND FL1.dat_bis) AS fl365 ON fl000.mandant_id =
    fl365.mandant_id AND fl000.flaeche_id = fl365.flaeche_id AND fl000.mietvertrag_id = fl365.mietvertrag_id;