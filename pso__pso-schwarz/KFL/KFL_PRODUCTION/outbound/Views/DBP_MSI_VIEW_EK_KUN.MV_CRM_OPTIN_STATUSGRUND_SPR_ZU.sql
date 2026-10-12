CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_optin_statusgrund_spr_zu (optin_statusgrund_id,
optin_statusgrund_bez, optin_statusgrund_bez_de, optin_statusgrund_bez_en, optin_statusgrund_bez_cz,
optin_statusgrund_bez_sk, optin_statusgrund_bez_hr, optin_statusgrund_bez_pl, optin_statusgrund_bez_ro,
optin_statusgrund_bez_bg) AS SELECT crm_optin_statusgrund_cd AS optin_statusgrund_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN crm_optin_statusgrund_bez
   ELSE NULL
   END) AS optin_statusgrund_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN crm_optin_statusgrund_bez
   ELSE NULL
   END) AS optin_statusgrund_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN crm_optin_statusgrund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN crm_optin_statusgrund_bez
    ELSE NULL
    END)) AS optin_statusgrund_bez_en,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 124
     THEN crm_optin_statusgrund_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN crm_optin_statusgrund_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN crm_optin_statusgrund_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN crm_optin_statusgrund_bez
    ELSE NULL
    END)) AS optin_statusgrund_bez_cz,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 108
     THEN crm_optin_statusgrund_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN crm_optin_statusgrund_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN crm_optin_statusgrund_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN crm_optin_statusgrund_bez
    ELSE NULL
    END)) AS optin_statusgrund_bez_sk,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 65
     THEN crm_optin_statusgrund_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN crm_optin_statusgrund_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN crm_optin_statusgrund_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN crm_optin_statusgrund_bez
    ELSE NULL
    END)) AS optin_statusgrund_bez_hr,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 90
     THEN crm_optin_statusgrund_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN crm_optin_statusgrund_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN crm_optin_statusgrund_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN crm_optin_statusgrund_bez
    ELSE NULL
    END)) AS optin_statusgrund_bez_pl,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 95
     THEN crm_optin_statusgrund_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN crm_optin_statusgrund_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN crm_optin_statusgrund_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN crm_optin_statusgrund_bez
    ELSE NULL
    END)) AS optin_statusgrund_bez_ro,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 18
     THEN crm_optin_statusgrund_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN crm_optin_statusgrund_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN crm_optin_statusgrund_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN crm_optin_statusgrund_bez
    ELSE NULL
    END)) AS optin_statusgrund_bez_bg
FROM kfl_production_dbp_data.crm_optin_statusgrund_spr_zu
GROUP BY optin_statusgrund_id;