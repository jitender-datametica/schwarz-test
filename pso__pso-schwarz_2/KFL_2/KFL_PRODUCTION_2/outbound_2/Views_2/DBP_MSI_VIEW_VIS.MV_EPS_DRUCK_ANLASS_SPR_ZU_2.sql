CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_eps_druck_anlass_spr_zu_2 AS SELECT druck_anlass_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN druck_anlass_bez
   ELSE NULL
   END) AS druck_anlass_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN druck_anlass_bez
   ELSE NULL
   END) AS druck_anlass_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN druck_anlass_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN druck_anlass_bez
    ELSE NULL
    END)) AS druck_anlass_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN druck_anlass_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN druck_anlass_bez
    ELSE NULL
    END)) AS druck_anlass_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN druck_anlass_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN druck_anlass_bez
    ELSE NULL
    END)) AS druck_anlass_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN druck_anlass_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN druck_anlass_bez
    ELSE NULL
    END)) AS druck_anlass_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN druck_anlass_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN druck_anlass_bez
    ELSE NULL
    END)) AS druck_anlass_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN druck_anlass_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN druck_anlass_bez
    ELSE NULL
    END)) AS druck_anlass_bez_bg
FROM kfl_production_dbp_view.v_eps_druck_anlass_spr_zu_2
GROUP BY druck_anlass_id;