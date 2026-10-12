CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_artkz_eigenmarke_spr_zu AS SELECT mandant_id,
 eigenmarke_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN eigenmarke_bez
   ELSE NULL
   END) AS eigenmarke_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN eigenmarke_bez
   ELSE NULL
   END) AS eigenmarke_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN eigenmarke_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN eigenmarke_bez
    ELSE NULL
    END)) AS eigenmarke_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN eigenmarke_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN eigenmarke_bez
    ELSE NULL
    END)) AS eigenmarke_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN eigenmarke_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN eigenmarke_bez
    ELSE NULL
    END)) AS eigenmarke_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN eigenmarke_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN eigenmarke_bez
    ELSE NULL
    END)) AS eigenmarke_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN eigenmarke_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN eigenmarke_bez
    ELSE NULL
    END)) AS eigenmarke_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN eigenmarke_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN eigenmarke_bez
    ELSE NULL
    END)) AS eigenmarke_bez_bg
FROM kfl_production_dbp_view.v_artkz_eigenmarke
GROUP BY mandant_id,
 eigenmarke_id;