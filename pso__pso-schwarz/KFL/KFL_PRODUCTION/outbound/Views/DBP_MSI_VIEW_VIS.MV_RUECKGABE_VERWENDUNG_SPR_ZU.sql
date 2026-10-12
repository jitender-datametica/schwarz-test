CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_rueckgabe_verwendung_spr_zu (rueckgabe_verwendung_kz,
rueckgabe_verwendung_bez_de, rueckgabe_verwendung_bez, rueckgabe_verwendung_bez_cz, rueckgabe_verwendung_bez_sk,
rueckgabe_verwendung_bez_hr, rueckgabe_verwendung_bez_pl, rueckgabe_verwendung_bez_ro, rueckgabe_verwendung_bez_bg) AS
SELECT rueckgabe_verwendung_kz,
 MAX(CASE
   WHEN spr_id = 22
   THEN rueckgabe_verwendung_bez
   ELSE TRIM(rueckgabe_verwendung_kz)
   END) AS rueckgabe_verwendung_bez_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN rueckgabe_verwendung_bez
   ELSE TRIM(rueckgabe_verwendung_kz)
   END) AS reklamationsgrund_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN rueckgabe_verwendung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rueckgabe_verwendung_bez
    ELSE TRIM(rueckgabe_verwendung_kz)
    END)) AS rueckgabe_verwendung_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN rueckgabe_verwendung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rueckgabe_verwendung_bez
    ELSE TRIM(rueckgabe_verwendung_kz)
    END)) AS rueckgabe_verwendung_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN rueckgabe_verwendung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rueckgabe_verwendung_bez
    ELSE TRIM(rueckgabe_verwendung_kz)
    END)) AS rueckgabe_verwendung_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN rueckgabe_verwendung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rueckgabe_verwendung_bez
    ELSE TRIM(rueckgabe_verwendung_kz)
    END)) AS rueckgabe_verwendung_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN rueckgabe_verwendung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rueckgabe_verwendung_bez
    ELSE TRIM(rueckgabe_verwendung_kz)
    END)) AS rueckgabe_verwendung_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN rueckgabe_verwendung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN rueckgabe_verwendung_bez
    ELSE TRIM(rueckgabe_verwendung_kz)
    END)) AS rueckgabe_verwendung_bez_bg
FROM kfl_production_dbp_view.v_rueckgabe_verwendung_spr_zu AS RUECK
GROUP BY rueckgabe_verwendung_kz;