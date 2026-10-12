CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_f_paq_it_projekte_2 AS SELECT V01.it_projekt_id,
 COALESCE(t1.aktivierungsquote_intern, 0) AS aktivierungsquote_intern,
 COALESCE(t1.aktivierungsquote_extern, 0) AS aktivierungsquote_extern,
 COALESCE(v03.aktivierungsquote_shs, 1) AS aktivierungsquote_shs,
 COALESCE(v03.gj_aktivierungsquote_shs, 1) AS gj_aktivierungsquote_shs,
 t1.aktivierungsquote_intern_plan,
 t1.aktivierungsquote_extern_plan,
 t1.aktivierungsquote_intern_ist,
 t1.aktivierungsquote_extern_ist
FROM kfl_production_dbp_view.v_it_projekt_2 AS V01
 LEFT JOIN (SELECT plan_revision_id,
   it_projekt_id,
   aktivierungsquote_intern_plan AS aktivierungsquote_intern,
   aktivierungsquote_extern_plan AS aktivierungsquote_extern,
   aktivierungsquote_intern_plan,
   aktivierungsquote_extern_plan,
   aktivierungsquote_intern_ist,
   aktivierungsquote_extern_ist
  FROM kfl_production_dbp_view.v_it_projekt_plan_2
  WHERE dat_bis = DATE '9999-12-31'
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY it_projekt_id ORDER BY plan_revision_id IS NULL, plan_revision_id)) = 1) AS
 t1_2 ON V01.it_projekt_id = t1.it_projekt_id
 LEFT JOIN (SELECT V03A.plan_revision_id,
   V03A.it_projekt_id,
   CAST(TRUNC(CAST(SUM(CASE
          WHEN V03A.ahk_aufwand_kz = 'AHK' AND V03A.berichts_position_it_id IN (1, 2, 3)
          THEN V03A.plan_betrag
          ELSE NULL
          END) * 1.0000 / CASE
        WHEN SUM(CASE
           WHEN V03A.berichts_position_it_id IN (1, 2, 3)
           THEN V03A.plan_betrag
           ELSE NULL
           END) = 0
        THEN NULL
        ELSE SUM(CASE
          WHEN V03A.berichts_position_it_id IN (1, 2, 3)
          THEN V03A.plan_betrag
          ELSE NULL
          END)
        END AS BIGNUMERIC)) AS BIGNUMERIC) AS aktivierungsquote_shs,
   CAST(TRUNC(CAST(SUM(CASE
          WHEN V03A.ahk_aufwand_kz = 'AHK' AND V03A.berichts_position_it_id IN (1, 2, 3) AND V03A.gj = CASE
             WHEN EXTRACT(MONTH FROM CURRENT_DATE) <= 3
             THEN EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
             ELSE EXTRACT(YEAR FROM CURRENT_DATE)
             END
          THEN V03A.plan_betrag
          ELSE NULL
          END) * 1.0000 / CASE
        WHEN SUM(CASE
           WHEN V03A.berichts_position_it_id IN (1, 2, 3) AND V03A.gj = CASE
              WHEN EXTRACT(MONTH FROM CURRENT_DATE) <= 3
              THEN EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
              ELSE EXTRACT(YEAR FROM CURRENT_DATE)
              END
           THEN V03A.plan_betrag
           ELSE NULL
           END) = 0
        THEN NULL
        ELSE SUM(CASE
          WHEN V03A.berichts_position_it_id IN (1, 2, 3) AND V03A.gj = CASE
             WHEN EXTRACT(MONTH FROM CURRENT_DATE) <= 3
             THEN EXTRACT(YEAR FROM DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
             ELSE EXTRACT(YEAR FROM CURRENT_DATE)
             END
          THEN V03A.plan_betrag
          ELSE NULL
          END)
        END AS BIGNUMERIC)) AS BIGNUMERIC) AS gj_aktivierungsquote_shs,
   EXTRACT(YEAR FROM CURRENT_DATE) AS akt_kj,
    CASE
    WHEN EXTRACT(MONTH FROM CURRENT_DATE) <= 3
    THEN EXTRACT(YEAR FROM CURRENT_DATE) - 1
    ELSE EXTRACT(YEAR FROM CURRENT_DATE)
    END AS akt_gj
  FROM kfl_production_dbp_view.v_it_projekt_plan_det_2 AS V03A
   INNER JOIN (SELECT it_projekt_id,
     berichts_position_it_id,
     gj
    FROM kfl_production_dbp_view.v_it_projekt_verteilung_laender_2
    WHERE it_plan_ebene_id IN (1, 2)
    GROUP BY it_projekt_id,
     berichts_position_it_id,
     gj) AS v03b ON V03A.it_projekt_id = v03b.it_projekt_id AND V03A.berichts_position_it_id = v03b.berichts_position_it_id
       AND V03A.gj = v03b.gj
  GROUP BY V03A.plan_revision_id,
   V03A.it_projekt_id) AS v03 ON t1.plan_revision_id = v03.plan_revision_id AND t1.it_projekt_id = v03.it_projekt_id;