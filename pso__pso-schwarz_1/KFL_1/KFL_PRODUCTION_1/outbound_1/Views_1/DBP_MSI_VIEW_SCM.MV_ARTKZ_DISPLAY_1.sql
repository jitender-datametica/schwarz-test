CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_artkz_display_1 AS SELECT mandant_id,
 display_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN display_bez
    ELSE NULL
    END), '0') AS display_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN display_bez
    ELSE NULL
    END), '0') AS display_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN display_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN display_bez
     ELSE NULL
     END), '0')) AS display_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN display_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN display_bez
     ELSE NULL
     END), '0')) AS display_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN display_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN display_bez
     ELSE NULL
     END), '0')) AS display_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN display_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN display_bez
     ELSE NULL
     END), '0')) AS display_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN display_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN display_bez
     ELSE NULL
     END), '0')) AS display_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN display_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN display_bez
     ELSE NULL
     END), '0')) AS display_bez_bg
FROM kfl_production_dbp_view.v_artkz_display_1
GROUP BY mandant_id,
 display_id;