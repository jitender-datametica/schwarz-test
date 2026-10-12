CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_optin_bez_spr_zu_1 AS SELECT crm_optin_bez_id,
 MAX(CASE
   WHEN spr_id = 24
   THEN crm_optin_bez
   ELSE NULL
   END) AS crm_optin_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN crm_optin_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN crm_optin_bez
    ELSE NULL
    END)) AS crm_optin_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN crm_optin_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN crm_optin_bez
    ELSE NULL
    END)) AS crm_optin_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN crm_optin_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN crm_optin_bez
    ELSE NULL
    END)) AS crm_optin_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN crm_optin_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN crm_optin_bez
    ELSE NULL
    END)) AS crm_optin_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN crm_optin_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN crm_optin_bez
    ELSE NULL
    END)) AS crm_optin_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN crm_optin_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN crm_optin_bez
    ELSE NULL
    END)) AS crm_optin_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN crm_optin_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN crm_optin_bez
    ELSE NULL
    END)) AS crm_optin_bez_bg
FROM kfl_production_dbp_view.v_crm_optin_bez_spr_zu_1
GROUP BY crm_optin_bez_id;