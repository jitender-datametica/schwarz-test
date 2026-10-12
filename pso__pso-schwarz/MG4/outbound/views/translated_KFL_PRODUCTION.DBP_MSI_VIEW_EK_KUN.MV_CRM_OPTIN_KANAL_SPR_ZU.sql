-- DE (standard)
 -- CZ
 -- PL
 -- EN
 -- RO
 -- BG
 -- HR
 -- SK

CREATE OR REPLACE VIEW dbp_msi_view_ek_kun.mv_crm_optin_kanal_spr_zu (crm_optin_kanal_id, crm_optin_kanal_bez_en,
crm_optin_kanal_bez, crm_optin_kanal_bez_cz, crm_optin_kanal_bez_sk, crm_optin_kanal_bez_hr, crm_optin_kanal_bez_pl,
crm_optin_kanal_bez_ro, crm_optin_kanal_bez_bg) AS SELECT crm_optin_kanal_id,
 MAX(CASE
   WHEN spr_id = 24 AND crm_optin_kanal_id = 709250006
   THEN 'Strong Alcohol_PL'
   ELSE crm_optin_kanal_bez
   END) AS crm_optin_kanal_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 22 AND crm_optin_kanal_id = 709250006
    THEN 'Strong Alcohol_PL'
    ELSE crm_optin_kanal_bez
    END), MAX(CASE
    WHEN spr_id = 24 AND crm_optin_kanal_id = 709250006
    THEN 'Strong Alcohol_PL'
    ELSE crm_optin_kanal_bez
    END)) AS crm_optin_kanal_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124 AND crm_optin_kanal_id = 709250006
    THEN 'Strong Alcohol_PL'
    ELSE crm_optin_kanal_bez
    END), MAX(CASE
    WHEN spr_id = 24 AND crm_optin_kanal_id = 709250006
    THEN 'Strong Alcohol_PL'
    ELSE crm_optin_kanal_bez
    END)) AS crm_optin_kanal_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108 AND crm_optin_kanal_id = 709250006
    THEN 'Strong Alcohol_PL'
    ELSE crm_optin_kanal_bez
    END), MAX(CASE
    WHEN spr_id = 24 AND crm_optin_kanal_id = 709250006
    THEN 'Strong Alcohol_PL'
    ELSE crm_optin_kanal_bez
    END)) AS crm_optin_kanal_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65 AND crm_optin_kanal_id = 709250006
    THEN 'Strong Alcohol_PL'
    ELSE crm_optin_kanal_bez
    END), MAX(CASE
    WHEN spr_id = 24 AND crm_optin_kanal_id = 709250006
    THEN 'Strong Alcohol_PL'
    ELSE crm_optin_kanal_bez
    END)) AS crm_optin_kanal_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90 AND crm_optin_kanal_id = 709250006
    THEN 'Strong Alcohol_PL'
    ELSE crm_optin_kanal_bez
    END), MAX(CASE
    WHEN spr_id = 24 AND crm_optin_kanal_id = 709250006
    THEN 'Strong Alcohol_PL'
    ELSE crm_optin_kanal_bez
    END)) AS crm_optin_kanal_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95 AND crm_optin_kanal_id = 709250006
    THEN 'Strong Alcohol_PL'
    ELSE crm_optin_kanal_bez
    END), MAX(CASE
    WHEN spr_id = 24 AND crm_optin_kanal_id = 709250006
    THEN 'Strong Alcohol_PL'
    ELSE crm_optin_kanal_bez
    END)) AS crm_optin_kanal_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18 AND crm_optin_kanal_id = 709250006
    THEN 'Strong Alcohol_PL'
    ELSE crm_optin_kanal_bez
    END), MAX(CASE
    WHEN spr_id = 24 AND crm_optin_kanal_id = 709250006
    THEN 'Strong Alcohol_PL'
    ELSE crm_optin_kanal_bez
    END)) AS crm_optin_kanal_bez_bg
FROM kfl_production_dbp_view.v_crm_optin_kanal_spr_zu
GROUP BY crm_optin_kanal_id;