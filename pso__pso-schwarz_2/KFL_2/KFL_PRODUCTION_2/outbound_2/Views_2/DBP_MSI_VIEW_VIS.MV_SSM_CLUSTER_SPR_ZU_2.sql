CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ssm_cluster_spr_zu_2 AS SELECT mandant_id,
 wup_bereich_id,
 wup_abt_id,
 ssm_cluster_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ssm_cluster_bez
   ELSE NULL
   END) AS ssm_cluster_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN ssm_cluster_bez
   ELSE NULL
   END) AS ssm_cluster_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN ssm_cluster_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ssm_cluster_bez
    ELSE NULL
    END)) AS ssm_cluster_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN ssm_cluster_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ssm_cluster_bez
    ELSE NULL
    END)) AS ssm_cluster_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN ssm_cluster_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ssm_cluster_bez
    ELSE NULL
    END)) AS ssm_cluster_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN ssm_cluster_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ssm_cluster_bez
    ELSE NULL
    END)) AS ssm_cluster_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN ssm_cluster_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ssm_cluster_bez
    ELSE NULL
    END)) AS ssm_cluster_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN ssm_cluster_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ssm_cluster_bez
    ELSE NULL
    END)) AS ssm_cluster_bez_bg
FROM kfl_production_dbp_view.v_ssm_cluster_spr_zu_2 AS V01
GROUP BY mandant_id,
 wup_bereich_id,
 wup_abt_id,
 ssm_cluster_id;