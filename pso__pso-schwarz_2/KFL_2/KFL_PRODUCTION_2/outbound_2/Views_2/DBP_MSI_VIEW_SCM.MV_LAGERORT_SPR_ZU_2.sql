CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_lagerort_spr_zu_2 AS SELECT V01.mandant_id,
 V01.lagerort_id,
 V01.nb_id,
 V01.wup_id,
   CAST(V01.wup_id AS STRING) || ' ' || MAX(CASE
    WHEN V01.spr_id = 22
    THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
    ELSE NULL
    END) AS lagerort_bez,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
   ELSE NULL
   END) AS lagerort_bez_de,
   CAST(V01.wup_id AS STRING) || ' ' || COALESCE(MAX(CASE
     WHEN V01.spr_id = 124
     THEN V01.lagerort_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V01.spr_id = 22
     THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
     ELSE NULL
     END)) AS lagerort_bez_cz,
   CAST(V01.wup_id AS STRING) || ' ' || COALESCE(MAX(CASE
     WHEN V01.spr_id = 108
     THEN V01.lagerort_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V01.spr_id = 22
     THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
     ELSE NULL
     END)) AS lagerort_bez_sk,
   CAST(V01.wup_id AS STRING) || ' ' || COALESCE(MAX(CASE
     WHEN V01.spr_id = 65
     THEN V01.lagerort_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V01.spr_id = 22
     THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
     ELSE NULL
     END)) AS lagerort_bez_hr,
   CAST(V01.wup_id AS STRING) || ' ' || COALESCE(MAX(CASE
     WHEN V01.spr_id = 90
     THEN V01.lagerort_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V01.spr_id = 22
     THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
     ELSE NULL
     END)) AS lagerort_bez_pl,
   CAST(V01.wup_id AS STRING) || ' ' || COALESCE(MAX(CASE
     WHEN V01.spr_id = 95
     THEN V01.lagerort_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V01.spr_id = 22
     THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
     ELSE NULL
     END)) AS lagerort_bez_ro,
   CAST(V01.wup_id AS STRING) || ' ' || COALESCE(MAX(CASE
     WHEN V01.spr_id = 18
     THEN V01.lagerort_bez
     ELSE NULL
     END), MAX(CASE
     WHEN V01.spr_id = 22
     THEN COALESCE(V02.lagerort_bez, V01.lagerort_bez)
     ELSE NULL
     END)) AS lagerort_bez_bg
FROM kfl_production_dbp_view.v_lagerort_spr_zu_2 AS V01
 LEFT JOIN kfl_production_dbp_msi_view3.ts_lagerort_altn_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id
      = V02.wup_id AND V01.lagerort_id = V02.lagerort_id AND V01.spr_id = V02.spr_id
WHERE V01.lagerort_id NOT IN ('-1', '-2', '-3')
GROUP BY V01.mandant_id,
 V01.lagerort_id,
 V01.nb_id,
 V01.wup_id;