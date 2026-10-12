CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_bvv_akte_spr_zu_1 AS SELECT V01.bvv_akte_id,
 V01.mandant_id,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN V02.bvv_akte_bez
   ELSE NULL
   END) AS bvv_akte_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.bvv_akte_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_akte_bez
    ELSE NULL
    END)) AS bvv_akte_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.bvv_akte_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_akte_bez
    ELSE NULL
    END)) AS bvv_akte_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.bvv_akte_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_akte_bez
    ELSE NULL
    END)) AS bvv_akte_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.bvv_akte_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_akte_bez
    ELSE NULL
    END)) AS bvv_akte_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.bvv_akte_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_akte_bez
    ELSE NULL
    END)) AS bvv_akte_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN V02.bvv_akte_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_akte_bez
    ELSE NULL
    END)) AS bvv_akte_bez_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.bvv_akte_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.bvv_akte_bez
    ELSE NULL
    END)) AS bvv_akte_bez_bg
FROM kfl_production_dbp_view.v_ivs_l_bvv_akte_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_ivs_bvv_akte_spr_zu_1 AS V02 ON V01.bvv_akte_id = V02.bvv_akte_id AND V01.mandant_id
    = V02.mandant_id
GROUP BY V01.bvv_akte_id,
 V01.mandant_id;