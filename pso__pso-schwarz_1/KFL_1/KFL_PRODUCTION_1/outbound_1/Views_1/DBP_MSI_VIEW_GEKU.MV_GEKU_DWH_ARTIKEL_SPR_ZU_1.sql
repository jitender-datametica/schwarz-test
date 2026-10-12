CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_dwh_artikel_spr_zu_1 (geku_dwh_artikel_id, kmr_quelle_id,
geku_dwh_artikel_bez, geku_dwh_artikel_bez_cz, geku_dwh_artikel_bez_pl, geku_dwh_artikel_bez_sk, geku_dwh_artikel_bez_hr
, geku_dwh_artikel_bez_ro, geku_dwh_artikel_bez_bg, geku_dwh_artikel_bez2, geku_dwh_artikel_bez2_cz,
geku_dwh_artikel_bez2_pl, geku_dwh_artikel_bez2_sk, geku_dwh_artikel_bez2_hr, geku_dwh_artikel_bez2_ro,
geku_dwh_artikel_bez2_bg) AS SELECT V01.geku_dwh_artikel_id,
 3 AS kmr_quelle_id,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez,
 MAX(CASE
   WHEN V01.spr_id = 124
   THEN V01.geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez_cz,
 MAX(CASE
   WHEN V01.spr_id = 90
   THEN V01.geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez_pl,
 MAX(CASE
   WHEN V01.spr_id = 108
   THEN V01.geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez_sk,
 MAX(CASE
   WHEN V01.spr_id = 65
   THEN V01.geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez_hr,
 MAX(CASE
   WHEN V01.spr_id = 95
   THEN V01.geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez_ro,
 MAX(CASE
   WHEN V01.spr_id = 18
   THEN V01.geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez_bg,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN CASE
    WHEN V02.alt_fg = 1 AND V02.geku_dwh_artikel_id BETWEEN 2500 AND 5999
    THEN V01.geku_dwh_artikel_bez || ' (alt 2017)'
    WHEN V02.alt_fg = 1
    THEN V01.geku_dwh_artikel_bez || ' (alt)'
    ELSE CASE
     WHEN V02.geku_artikel_id_alt IS NULL
     THEN V01.geku_dwh_artikel_bez
     ELSE V01.geku_dwh_artikel_bez || ' (' || V02.geku_artikel_id_alt || ')'
     END
    END
   ELSE NULL
   END) AS geku_dwh_artikel_bez2,
 MAX(CASE
   WHEN V01.spr_id = 124
   THEN CASE
    WHEN V02.alt_fg = 1 AND V02.geku_dwh_artikel_id BETWEEN 2500 AND 5999
    THEN V01.geku_dwh_artikel_bez || ' (alt 2017)'
    WHEN V02.alt_fg = 1
    THEN V01.geku_dwh_artikel_bez || ' (alt)'
    ELSE CASE
     WHEN V02.geku_artikel_id_alt IS NULL
     THEN V01.geku_dwh_artikel_bez
     ELSE V01.geku_dwh_artikel_bez || ' (' || V02.geku_artikel_id_alt || ')'
     END
    END
   ELSE NULL
   END) AS geku_dwh_artikel_bez2_cz,
 MAX(CASE
   WHEN V01.spr_id = 90
   THEN CASE
    WHEN V02.alt_fg = 1 AND V02.geku_dwh_artikel_id BETWEEN 2500 AND 5999
    THEN V01.geku_dwh_artikel_bez || ' (alt 2017)'
    WHEN V02.alt_fg = 1
    THEN V01.geku_dwh_artikel_bez || ' (alt)'
    ELSE CASE
     WHEN V02.geku_artikel_id_alt IS NULL
     THEN V01.geku_dwh_artikel_bez
     ELSE V01.geku_dwh_artikel_bez || ' (' || V02.geku_artikel_id_alt || ')'
     END
    END
   ELSE NULL
   END) AS geku_dwh_artikel_bez2_pl,
 MAX(CASE
   WHEN V01.spr_id = 108
   THEN CASE
    WHEN V02.alt_fg = 1 AND V02.geku_dwh_artikel_id BETWEEN 2500 AND 5999
    THEN V01.geku_dwh_artikel_bez || ' (alt 2017)'
    WHEN V02.alt_fg = 1
    THEN V01.geku_dwh_artikel_bez || ' (alt)'
    ELSE CASE
     WHEN V02.geku_artikel_id_alt IS NULL
     THEN V01.geku_dwh_artikel_bez
     ELSE V01.geku_dwh_artikel_bez || ' (' || V02.geku_artikel_id_alt || ')'
     END
    END
   ELSE NULL
   END) AS geku_dwh_artikel_bez2_sk,
 MAX(CASE
   WHEN V01.spr_id = 65
   THEN CASE
    WHEN V02.alt_fg = 1 AND V02.geku_dwh_artikel_id BETWEEN 2500 AND 5999
    THEN V01.geku_dwh_artikel_bez || ' (alt 2017)'
    WHEN V02.alt_fg = 1
    THEN V01.geku_dwh_artikel_bez || ' (alt)'
    ELSE CASE
     WHEN V02.geku_artikel_id_alt IS NULL
     THEN V01.geku_dwh_artikel_bez
     ELSE V01.geku_dwh_artikel_bez || ' (' || V02.geku_artikel_id_alt || ')'
     END
    END
   ELSE NULL
   END) AS geku_dwh_artikel_bez2_hr,
 MAX(CASE
   WHEN V01.spr_id = 95
   THEN CASE
    WHEN V02.alt_fg = 1 AND V02.geku_dwh_artikel_id BETWEEN 2500 AND 5999
    THEN V01.geku_dwh_artikel_bez || ' (alt 2017)'
    WHEN V02.alt_fg = 1
    THEN V01.geku_dwh_artikel_bez || ' (alt)'
    ELSE CASE
     WHEN V02.geku_artikel_id_alt IS NULL
     THEN V01.geku_dwh_artikel_bez
     ELSE V01.geku_dwh_artikel_bez || ' (' || V02.geku_artikel_id_alt || ')'
     END
    END
   ELSE NULL
   END) AS geku_dwh_artikel_bez2_ro,
 MAX(CASE
   WHEN V01.spr_id = 18
   THEN CASE
    WHEN V02.alt_fg = 1 AND V02.geku_dwh_artikel_id BETWEEN 2500 AND 5999
    THEN V01.geku_dwh_artikel_bez || ' (alt 2017)'
    WHEN V02.alt_fg = 1
    THEN V01.geku_dwh_artikel_bez || ' (alt)'
    ELSE CASE
     WHEN V02.geku_artikel_id_alt IS NULL
     THEN V01.geku_dwh_artikel_bez
     ELSE V01.geku_dwh_artikel_bez || ' (' || V02.geku_artikel_id_alt || ')'
     END
    END
   ELSE NULL
   END) AS geku_dwh_artikel_bez2_bg
FROM kfl_production_dbp_view.v_geku_dwh_artikel_spr_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_l_geku_dwh_artikel_1 AS V02 ON V01.geku_dwh_artikel_id = V02.geku_dwh_artikel_id
WHERE V01.geku_dwh_artikel_id IN (SELECT geku_dwh_artikel_id
   FROM kfl_production_dbp_view.v_l_geku_artikel_1)
GROUP BY V01.geku_dwh_artikel_id;