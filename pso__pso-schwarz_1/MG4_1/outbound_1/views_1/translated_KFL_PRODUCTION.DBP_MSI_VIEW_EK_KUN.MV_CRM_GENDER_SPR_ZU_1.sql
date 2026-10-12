-- CZ
 -- BG
 -- SK
 -- HR
 -- RO
 -- standard
 -- DE (for coalesce only)
 -- EN
 -- PL

CREATE OR REPLACE VIEW dbp_msi_view_ek_kun.mv_crm_gender_spr_zu_1 (gender_id, gender_bez, gender_bez_de, gender_bez_en,
gender_bez_cz, gender_bez_sk, gender_bez_hr, gender_bez_pl, gender_bez_ro, gender_bez_bg) AS SELECT gender_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN gender_bez
   ELSE NULL
   END) AS gender_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN gender_bez
   ELSE NULL
   END) AS gender_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN gender_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN gender_bez
    ELSE NULL
    END)) AS gender_bez_en,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 124
     THEN gender_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN gender_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN gender_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN gender_bez
    ELSE NULL
    END)) AS gender_bez_cz,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 108
     THEN gender_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN gender_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN gender_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN gender_bez
    ELSE NULL
    END)) AS gender_bez_sk,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 65
     THEN gender_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN gender_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN gender_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN gender_bez
    ELSE NULL
    END)) AS gender_bez_hr,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 90
     THEN gender_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN gender_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN gender_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN gender_bez
    ELSE NULL
    END)) AS gender_bez_pl,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 95
     THEN gender_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN gender_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN gender_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN gender_bez
    ELSE NULL
    END)) AS gender_bez_ro,
 COALESCE(COALESCE(MAX(CASE
     WHEN spr_id = 18
     THEN gender_bez
     ELSE NULL
     END), COALESCE(MAX(CASE
      WHEN spr_id = 24
      THEN gender_bez
      ELSE NULL
      END), MAX(CASE
      WHEN spr_id = 22
      THEN gender_bez
      ELSE NULL
      END))), MAX(CASE
    WHEN spr_id = 22
    THEN gender_bez
    ELSE NULL
    END)) AS gender_bez_bg
FROM kfl_production_dbp_view.v_crm_gender_spr_zu_1
GROUP BY gender_id;