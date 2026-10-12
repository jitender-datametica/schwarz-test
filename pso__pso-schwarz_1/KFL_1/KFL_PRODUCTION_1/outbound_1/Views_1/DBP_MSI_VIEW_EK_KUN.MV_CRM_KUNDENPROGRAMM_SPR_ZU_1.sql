CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_crm_kundenprogramm_spr_zu_1 AS SELECT crm_kundenprogramm_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN crm_kundenprogramm_bez
   ELSE NULL
   END) AS crm_kundenprogramm_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN crm_kundenprogramm_bez
   ELSE NULL
   END) AS crm_kundenprogramm_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN crm_kundenprogramm_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN crm_kundenprogramm_bez
    ELSE NULL
    END)) AS crm_kundenprogramm_bez_en,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 124
     THEN crm_kundenprogramm_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN crm_kundenprogramm_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN crm_kundenprogramm_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN crm_kundenprogramm_bez
    ELSE NULL
    END)) AS crm_kundenprogramm_bez_cz,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 108
     THEN crm_kundenprogramm_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN crm_kundenprogramm_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN crm_kundenprogramm_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN crm_kundenprogramm_bez
    ELSE NULL
    END)) AS crm_kundenprogramm_bez_sk,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 65
     THEN crm_kundenprogramm_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN crm_kundenprogramm_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN crm_kundenprogramm_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN crm_kundenprogramm_bez
    ELSE NULL
    END)) AS crm_kundenprogramm_bez_hr,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 90
     THEN crm_kundenprogramm_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN crm_kundenprogramm_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN crm_kundenprogramm_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN crm_kundenprogramm_bez
    ELSE NULL
    END)) AS crm_kundenprogramm_bez_pl,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 95
     THEN crm_kundenprogramm_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN crm_kundenprogramm_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN crm_kundenprogramm_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN crm_kundenprogramm_bez
    ELSE NULL
    END)) AS crm_kundenprogramm_bez_ro,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 18
     THEN crm_kundenprogramm_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN crm_kundenprogramm_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN crm_kundenprogramm_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN crm_kundenprogramm_bez
    ELSE NULL
    END)) AS crm_kundenprogramm_bez_bg
FROM kfl_production_dbp_view.v_crm_kundenprogramm_spr_zu_1
GROUP BY crm_kundenprogramm_id;