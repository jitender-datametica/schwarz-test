CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_phase_spr_zu_ref_monat_2 AS SELECT projekt_phase_id,
 mandant_id,
 dat_von,
 dat_bis,
 ref_monat,
 MAX(CASE
   WHEN spr_id = 22
   THEN cpr_phase_bez
   ELSE NULL
   END) AS cpr_phase_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN cpr_phase_langtext
   ELSE NULL
   END) AS cpr_phase_langtext,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN cpr_phase_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_langtext
    ELSE NULL
    END)) AS cpr_phase_langtext_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN cpr_phase_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_langtext
    ELSE NULL
    END)) AS cpr_phase_langtext_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN cpr_phase_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_langtext
    ELSE NULL
    END)) AS cpr_phase_langtext_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN cpr_phase_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_langtext
    ELSE NULL
    END)) AS cpr_phase_langtext_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN cpr_phase_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_langtext
    ELSE NULL
    END)) AS cpr_phase_langtext_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN cpr_phase_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_langtext
    ELSE NULL
    END)) AS cpr_phase_langtext_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN cpr_phase_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN cpr_phase_langtext
    ELSE NULL
    END)) AS cpr_phase_langtext_bg
FROM (SELECT V02.projekt_phase_id,
   V04.mandant_id,
   V02.dat_von,
   V02.dat_bis,
   T.ref_monat,
   V02.spr_id,
   V02.cpr_phase_bez,
    COALESCE(V02.cpr_phase_langtext, '') || COALESCE(CASE
      WHEN V02.spr_id = 22 AND V06.spr_id <> 22
      THEN ' ' || V05.cpr_phase_langtext
      ELSE ''
      END, '') AS cpr_phase_langtext
  FROM kfl_production_dbp_view.v_cpr_phase_spr_zu_per_2 AS V02
   INNER JOIN kfl_production_dbp_view.v_cpr_phase_per_2 AS V03 ON V02.projekt_phase_id = V03.projekt_phase_id
   INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per_2 AS V04 ON V03.projekt_id = V04.projekt_id
   LEFT JOIN kfl_production_dbp_view.v_mandant_spr_zu_2 AS V06 ON V04.mandant_id = V06.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_cpr_phase_spr_zu_per_2 AS V05 ON V02.projekt_phase_id = V05.projekt_phase_id AND
     V06.spr_id = V05.spr_id
   LEFT JOIN kfl_production_dbp_msi_view_ios.mv_ref_monat_2 AS T ON T.ref_monat <= CURRENT_DATE
  WHERE T.ref_monat BETWEEN V02.dat_von AND V02.dat_bis
   AND T.ref_monat BETWEEN V03.dat_von AND V03.dat_bis
   AND T.ref_monat BETWEEN V04.dat_von AND V04.dat_bis
   AND (T.ref_monat BETWEEN V05.dat_von AND V05.dat_bis OR V05.dat_von IS NULL)) AS v111
GROUP BY projekt_phase_id,
 mandant_id,
 dat_von,
 dat_bis,
 ref_monat;