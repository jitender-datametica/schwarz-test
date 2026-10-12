CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_mondphase_spr_zu_1 AS SELECT mondphase_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN mondphase_bez
   ELSE NULL
   END) AS mondphase_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN mondphase_bez
   ELSE NULL
   END) AS mondphase_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN mondphase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mondphase_bez
    ELSE NULL
    END)) AS mondphase_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN mondphase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mondphase_bez
    ELSE NULL
    END)) AS mondphase_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN mondphase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mondphase_bez
    ELSE NULL
    END)) AS mondphase_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN mondphase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mondphase_bez
    ELSE NULL
    END)) AS mondphase_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN mondphase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mondphase_bez
    ELSE NULL
    END)) AS mondphase_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN mondphase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mondphase_bez
    ELSE NULL
    END)) AS mondphase_bez_bg
FROM kfl_production_dbp_view.v_mondphase_spr_zu_1 AS V01
GROUP BY mondphase_id;