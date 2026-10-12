CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_qa_deklarationsfehler_spr_zu (mandant_id,
qa_deklarationsfehler_id, qa_deklarationsfehler_bez, qa_deklarationsfehler_bez_de, qa_deklarationsfehler_bez_cz,
qa_deklarationsfehler_bez_sk, qa_deklarationsfehler_bez_hr, qa_deklarationsfehler_bez_pl, qa_deklarationsfehler_bez_ro,
qa_deklarationsfehler_bez_b) AS SELECT mandant_id,
 qa_deklarationsfehler_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN qa_deklarationsfehler_bez
   ELSE NULL
   END) AS qa_deklarationsfehler_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN qa_deklarationsfehler_bez
   ELSE NULL
   END) AS qa_deklarationsfehler_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN qa_deklarationsfehler_bez
   ELSE NULL
   END) AS qa_deklarationsfehler_bez_cz,
 MAX(CASE
   WHEN spr_id = 108
   THEN qa_deklarationsfehler_bez
   ELSE NULL
   END) AS qa_deklarationsfehler_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN qa_deklarationsfehler_bez
   ELSE NULL
   END) AS qa_deklarationsfehler_bez_hr,
 MAX(CASE
   WHEN spr_id = 90
   THEN qa_deklarationsfehler_bez
   ELSE NULL
   END) AS qa_deklarationsfehler_bez_pl,
 MAX(CASE
   WHEN spr_id = 95
   THEN qa_deklarationsfehler_bez
   ELSE NULL
   END) AS qa_deklarationsfehler_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN qa_deklarationsfehler_bez
   ELSE NULL
   END) AS qa_deklarationsfehler_bez_b
FROM kfl_production_dbp_view.v_qa_deklarationsfehler_spr_zu AS V01
GROUP BY qa_deklarationsfehler_id,
 mandant_id
UNION DISTINCT
SELECT mandant_id,
 '-1',
 CAST(NULL AS STRING),
 CAST(NULL AS STRING),
 CAST(NULL AS STRING),
 CAST(NULL AS STRING),
 CAST(NULL AS STRING),
 CAST(NULL AS STRING),
 CAST(NULL AS STRING),
 CAST(NULL AS STRING)
FROM kfl_production_dbp_view.v_mandant AS V01;