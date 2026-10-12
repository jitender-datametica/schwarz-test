CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artkz_lead (mandant_id, lead_id, lead_bez, lead_bez_de,
lead_bez_cz, lead_bez_sk, lead_bez_hr, lead_bez_pl, lead_bez_ro, lead_bez_bg) AS SELECT mandant_id,
 lead_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN lead_bez
    ELSE NULL
    END), 'N/A') AS lead_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN lead_bez
    ELSE NULL
    END), 'N/A') AS lead_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN lead_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN lead_bez
     ELSE NULL
     END), 'N/A')) AS lead_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN lead_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN lead_bez
     ELSE NULL
     END), 'N/A')) AS lead_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN lead_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN lead_bez
     ELSE NULL
     END), 'N/A')) AS lead_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN lead_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN lead_bez
     ELSE NULL
     END), 'N/A')) AS lead_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN lead_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN lead_bez
     ELSE NULL
     END), 'N/A')) AS lead_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN lead_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN lead_bez
     ELSE NULL
     END), 'N/A')) AS lead_bez_bg
FROM kfl_production_dbp_view.v_artkz_lead AS V01
WHERE mandant_id <> 1
GROUP BY mandant_id,
 lead_id;