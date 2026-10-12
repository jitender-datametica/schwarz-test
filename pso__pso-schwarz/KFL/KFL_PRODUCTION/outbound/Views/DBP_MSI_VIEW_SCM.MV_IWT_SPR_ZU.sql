CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_iwt_spr_zu (mandant_id, iwt_id, iwt_bez, iwt_bez_de,
iwt_bez_cz, iwt_bez_sk, iwt_bez_hr, iwt_bez_pl, iwt_bez_ro, iwt_bez_bg) AS SELECT mandant_id,
 iwt_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN iwt_bez
   ELSE NULL
   END) AS iwt_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN iwt_bez
   ELSE NULL
   END) AS iwt_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN iwt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN iwt_bez
    ELSE NULL
    END)) AS iwt_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN iwt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN iwt_bez
    ELSE NULL
    END)) AS iwt_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN iwt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN iwt_bez
    ELSE NULL
    END)) AS iwt_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN iwt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN iwt_bez
    ELSE NULL
    END)) AS iwt_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN iwt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN iwt_bez
    ELSE NULL
    END)) AS iwt_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN iwt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN iwt_bez
    ELSE NULL
    END)) AS iwt_bez_bg
FROM kfl_production_dbp_view.v_iwt_spr_zu AS V01
GROUP BY mandant_id,
 iwt_id;