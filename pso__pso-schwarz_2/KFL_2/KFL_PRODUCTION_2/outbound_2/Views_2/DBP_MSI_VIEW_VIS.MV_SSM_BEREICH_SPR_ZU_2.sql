CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ssm_bereich_spr_zu_2 AS SELECT wup_bereich_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN wup_bereich_bez
   ELSE NULL
   END) AS wup_bereich_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN wup_bereich_bez
   ELSE NULL
   END) AS wup_bereich_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN wup_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wup_bereich_bez
    ELSE NULL
    END)) AS wup_bereich_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN wup_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wup_bereich_bez
    ELSE NULL
    END)) AS wup_bereich_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN wup_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wup_bereich_bez
    ELSE NULL
    END)) AS wup_bereich_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN wup_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wup_bereich_bez
    ELSE NULL
    END)) AS wup_bereich_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN wup_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wup_bereich_bez
    ELSE NULL
    END)) AS wup_bereich_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN wup_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN wup_bereich_bez
    ELSE NULL
    END)) AS wup_bereich_bez_bg
FROM kfl_production_dbp_view.v_ssm_bereich_spr_zu_2 AS V01
GROUP BY wup_bereich_id;