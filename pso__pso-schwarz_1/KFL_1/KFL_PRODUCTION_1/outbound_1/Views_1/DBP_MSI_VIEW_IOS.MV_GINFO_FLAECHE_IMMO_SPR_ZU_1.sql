CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_ginfo_flaeche_immo_spr_zu_1 (ginfo_flaeche_id,
ginfo_flaeche_typ_id, mandant_id, techn_platz_id, ginfo_flaeche_bez, ginfo_flaeche_bez_cz, ginfo_flaeche_bez_sk,
ginfo_flaeche_bez_hr, ginfo_flaeche_bez_pl, ginfo_flaeche_bez_ro, ginfo_flaeche_bez_en, ginfo_flaeche_bez_bg) AS SELECT
 ginfo_flaeche_id,
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
WHERE flaeche_quelle_id IN (2)
GROUP BY ginfo_flaeche_id,
 ginfo_flaeche_typ_id,
 mandant_id,
 techn_platz_id;