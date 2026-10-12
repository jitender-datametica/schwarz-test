-- 2025-03-06,AP0205147, dknop, initial
 -- HR
 -- BG
 -- CZ
 -- SK
 -- standard == DE
 -- RO
 -- PL
 -- DE

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_qa_mangel_spr_zu_1 (mandant_id, qa_mangel_id,
qa_mangel_bez, qa_mangel_bez_de, qa_mangel_bez_cz, qa_mangel_bez_sk, qa_mangel_bez_hr, qa_mangel_bez_pl,
qa_mangel_bez_ro, qa_mangel_bez_bg) AS SELECT mandant_id,
 qa_mangel_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN qa_mangel_bez
   ELSE NULL
   END) AS qa_mangel_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN qa_mangel_bez
   ELSE NULL
   END) AS qa_mangel_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN qa_mangel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN qa_mangel_bez
    ELSE NULL
    END)) AS qa_mangel_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN qa_mangel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN qa_mangel_bez
    ELSE NULL
    END)) AS qa_mangel_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN qa_mangel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN qa_mangel_bez
    ELSE NULL
    END)) AS qa_mangel_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN qa_mangel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN qa_mangel_bez
    ELSE NULL
    END)) AS qa_mangel_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN qa_mangel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN qa_mangel_bez
    ELSE NULL
    END)) AS qa_mangel_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN qa_mangel_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN qa_mangel_bez
    ELSE NULL
    END)) AS qa_mangel_bez_bg
FROM kfl_production_dbp_view.v_qa_mangel_spr_zu_1 AS V01
GROUP BY mandant_id,
 qa_mangel_id
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
FROM kfl_production_dbp_view.v_mandant_1;