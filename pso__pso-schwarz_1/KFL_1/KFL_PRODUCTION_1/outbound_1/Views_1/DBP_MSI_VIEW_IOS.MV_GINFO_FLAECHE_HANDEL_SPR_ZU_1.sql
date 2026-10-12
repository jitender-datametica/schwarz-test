CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_ginfo_flaeche_handel_spr_zu_1 AS SELECT ginfo_flaeche_id,
 ginfo_flaeche_typ_id,
 mandant_id,
 techn_platz_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ginfo_flaeche_bez
   ELSE NULL
   END) AS ginfo_flaeche_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN ginfo_flaeche_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ginfo_flaeche_bez
    ELSE NULL
    END)) AS ginfo_flaeche_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN ginfo_flaeche_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ginfo_flaeche_bez
    ELSE NULL
    END)) AS ginfo_flaeche_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN ginfo_flaeche_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ginfo_flaeche_bez
    ELSE NULL
    END)) AS ginfo_flaeche_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN ginfo_flaeche_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ginfo_flaeche_bez
    ELSE NULL
    END)) AS ginfo_flaeche_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN ginfo_flaeche_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ginfo_flaeche_bez
    ELSE NULL
    END)) AS ginfo_flaeche_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN ginfo_flaeche_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ginfo_flaeche_bez
    ELSE NULL
    END)) AS ginfo_flaeche_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN ginfo_flaeche_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ginfo_flaeche_bez
    ELSE NULL
    END)) AS ginfo_flaeche_bez_bg
FROM kfl_production_dbp_view.v_ginfo_flaeche_spr_zu_1
WHERE flaeche_quelle_id = 3
GROUP BY ginfo_flaeche_id,
 ginfo_flaeche_typ_id,
 mandant_id,
 techn_platz_id;