CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_risikoklasse_spr_zu_2 (geku_risikoklasse_id,
geku_risikoklasse_bez, geku_risikoklasse_bez_cz, geku_risikoklasse_bez_pl, geku_risikoklasse_bez_sk,
geku_risikoklasse_bez_hr, geku_risikoklasse_bez_ro, geku_risikoklasse_bez_bg) AS SELECT geku_risikoklasse_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN CASE
    WHEN geku_risikoklasse_id = 0
    THEN ''
    ELSE geku_risikoklasse_bez
    END
   ELSE NULL
   END) AS geku_risikoklasse_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN CASE
    WHEN geku_risikoklasse_id = 0
    THEN ''
    ELSE geku_risikoklasse_bez
    END
   ELSE NULL
   END) AS geku_risikoklasse_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN CASE
    WHEN geku_risikoklasse_id = 0
    THEN ''
    ELSE geku_risikoklasse_bez
    END
   ELSE NULL
   END) AS geku_risikoklasse_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN CASE
    WHEN geku_risikoklasse_id = 0
    THEN ''
    ELSE geku_risikoklasse_bez
    END
   ELSE NULL
   END) AS geku_risikoklasse_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN CASE
    WHEN geku_risikoklasse_id = 0
    THEN ''
    ELSE geku_risikoklasse_bez
    END
   ELSE NULL
   END) AS geku_risikoklasse_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN CASE
    WHEN geku_risikoklasse_id = 0
    THEN ''
    ELSE geku_risikoklasse_bez
    END
   ELSE NULL
   END) AS geku_risikoklasse_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN CASE
    WHEN geku_risikoklasse_id = 0
    THEN ''
    ELSE geku_risikoklasse_bez
    END
   ELSE NULL
   END) AS geku_risikoklasse_bez_bg
FROM kfl_production_dbp_view.v_geku_risikoklasse_spr_zu_2 AS V01
GROUP BY geku_risikoklasse_id;