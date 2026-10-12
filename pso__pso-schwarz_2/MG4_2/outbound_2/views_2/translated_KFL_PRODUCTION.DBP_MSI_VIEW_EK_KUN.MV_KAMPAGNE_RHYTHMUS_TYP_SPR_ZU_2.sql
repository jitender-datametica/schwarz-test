-- PL
 -- BG
 -- DE (Standard)
 -- HR
 -- EN
 -- RO
 -- SK
 -- CZ

CREATE OR REPLACE VIEW dbp_msi_view_ek_kun.mv_kampagne_rhythmus_typ_spr_zu_2 (mandant_id, kampagne_rhythmus_typ_id,
kampagne_rhythmus_typ_bez_en, kampagne_rhythmus_typ_bez, kampagne_rhythmus_typ_bez_cz, kampagne_rhythmus_typ_bez_sk,
kampagne_rhythmus_typ_bez_hr, kampagne_rhythmus_typ_bez_pl, kampagne_rhythmus_typ_bez_ro, kampagne_rhythmus_typ_bez_bg)
AS SELECT mandant_id,
 kampagne_rhythmus_typ_id,
 MAX(CASE
   WHEN spr_id = 24
   THEN kampagne_rhythmus_typ_bez
   ELSE NULL
   END) AS kampagne_rhythmus_typ_bez_en,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN kampagne_rhythmus_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN kampagne_rhythmus_typ_bez
    ELSE NULL
    END)) AS kampagne_rhythmus_typ_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN kampagne_rhythmus_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN kampagne_rhythmus_typ_bez
    ELSE NULL
    END)) AS kampagne_rhythmus_typ_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN kampagne_rhythmus_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN kampagne_rhythmus_typ_bez
    ELSE NULL
    END)) AS kampagne_rhythmus_typ_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN kampagne_rhythmus_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN kampagne_rhythmus_typ_bez
    ELSE NULL
    END)) AS kampagne_rhythmus_typ_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN kampagne_rhythmus_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN kampagne_rhythmus_typ_bez
    ELSE NULL
    END)) AS kampagne_rhythmus_typ_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN kampagne_rhythmus_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN kampagne_rhythmus_typ_bez
    ELSE NULL
    END)) AS kampagne_rhythmus_typ_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN kampagne_rhythmus_typ_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 24
    THEN kampagne_rhythmus_typ_bez
    ELSE NULL
    END)) AS kampagne_rhythmus_typ_bez_bg
FROM kfl_production_dbp_view.v_kampagne_rhythmus_typ_spr_zu_2
GROUP BY mandant_id,
 kampagne_rhythmus_typ_id;