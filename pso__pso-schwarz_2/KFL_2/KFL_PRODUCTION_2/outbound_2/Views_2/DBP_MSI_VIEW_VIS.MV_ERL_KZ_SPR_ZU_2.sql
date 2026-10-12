CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_erl_kz_spr_zu_2 (erl_kz, erl_kz_bez_de, erl_kz_bez,
erl_kz_bez_cz, erl_kz_bez_sk, erl_kz_bez_hr, erl_kz_bez_pl, erl_kz_bez_ro, erl_kz_bez_bg) AS SELECT erl_kz,
 MAX(CASE
   WHEN spr_id = 22
   THEN erl_kz_bez
   ELSE TRIM(erl_kz)
   END) AS erl_kz_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN erl_kz_bez
   ELSE TRIM(erl_kz)
   END) AS erl_kz_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN erl_kz_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN erl_kz_bez
    ELSE TRIM(erl_kz)
    END)) AS erl_kz_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN erl_kz_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN erl_kz_bez
    ELSE TRIM(erl_kz)
    END)) AS erl_kz_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN erl_kz_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN erl_kz_bez
    ELSE TRIM(erl_kz)
    END)) AS erl_kz_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN erl_kz_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN erl_kz_bez
    ELSE TRIM(erl_kz)
    END)) AS erl_kz_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN erl_kz_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN erl_kz_bez
    ELSE TRIM(erl_kz)
    END)) AS erl_kz_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN erl_kz_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN erl_kz_bez
    ELSE TRIM(erl_kz)
    END)) AS erl_kz_bez_bg
FROM kfl_production_dbp_view.v_erl_kz_spr_zu_2
GROUP BY erl_kz;