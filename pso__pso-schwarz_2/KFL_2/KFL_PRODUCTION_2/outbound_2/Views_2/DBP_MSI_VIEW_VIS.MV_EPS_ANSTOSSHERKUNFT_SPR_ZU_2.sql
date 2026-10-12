CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_eps_anstossherkunft_spr_zu_2 AS SELECT anstossherkunft_kz,
 MAX(CASE
   WHEN spr_id = 22
   THEN anstossherkunft_bez
   ELSE NULL
   END) AS anstossherkunft_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN anstossherkunft_bez
   ELSE NULL
   END) AS anstossherkunft_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN anstossherkunft_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN anstossherkunft_bez
    ELSE NULL
    END)) AS anstossherkunft_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN anstossherkunft_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN anstossherkunft_bez
    ELSE NULL
    END)) AS anstossherkunft_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN anstossherkunft_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN anstossherkunft_bez
    ELSE NULL
    END)) AS anstossherkunft_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN anstossherkunft_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN anstossherkunft_bez
    ELSE NULL
    END)) AS anstossherkunft_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN anstossherkunft_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN anstossherkunft_bez
    ELSE NULL
    END)) AS anstossherkunft_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN anstossherkunft_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN anstossherkunft_bez
    ELSE NULL
    END)) AS anstossherkunft_bez_bg
FROM kfl_production_dbp_view.v_eps_anstossherkunft_spr_zu_2
GROUP BY anstossherkunft_kz;