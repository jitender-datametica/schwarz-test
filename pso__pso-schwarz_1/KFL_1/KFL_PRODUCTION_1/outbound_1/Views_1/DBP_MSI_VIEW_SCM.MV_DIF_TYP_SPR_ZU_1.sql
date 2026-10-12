CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_dif_typ_spr_zu_1 AS SELECT dif_typ_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN dif_typ_bez
   ELSE NULL
   END) AS dif_typ_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN dif_typ_bez
   ELSE NULL
   END) AS dif_typ_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN dif_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN dif_typ_bez
    ELSE NULL
    END)) AS dif_typ_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN dif_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN dif_typ_bez
    ELSE NULL
    END)) AS dif_typ_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN dif_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN dif_typ_bez
    ELSE NULL
    END)) AS dif_typ_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN dif_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN dif_typ_bez
    ELSE NULL
    END)) AS dif_typ_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN dif_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN dif_typ_bez
    ELSE NULL
    END)) AS dif_typ_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN dif_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN dif_typ_bez
    ELSE NULL
    END)) AS dif_typ_bez_bg
FROM kfl_production_dbp_view.v_dif_typ_spr_zu_1 AS V01
GROUP BY dif_typ_id;