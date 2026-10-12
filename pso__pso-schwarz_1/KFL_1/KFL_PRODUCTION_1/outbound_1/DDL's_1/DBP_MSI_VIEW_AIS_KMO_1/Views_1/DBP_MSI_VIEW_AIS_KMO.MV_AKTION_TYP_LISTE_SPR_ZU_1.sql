CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_aktion_typ_liste_spr_zu_1 (mandant_id, aktion_typ_liste_id,
aktion_typ_liste_bez, aktion_typ_liste_bez_de, aktion_typ_liste_bez_cz, aktion_typ_liste_bez_sk, aktion_typ_liste_bez_hr
, aktion_typ_liste_bez_pl, aktion_typ_liste_bez_ro, aktion_typ_liste_bez_bg) AS SELECT mandant_id,
 aktion_typ_liste_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN aktion_typ_liste_bez
    ELSE NULL
    END), 'N/A') AS aktion_typ_liste_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN aktion_typ_liste_bez
    ELSE NULL
    END), 'N/A') AS aktion_typ_liste_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN aktion_typ_liste_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktion_typ_liste_bez
     ELSE NULL
     END), 'N/A')) AS aktion_typ_liste_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN aktion_typ_liste_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktion_typ_liste_bez
     ELSE NULL
     END), 'N/A')) AS aktion_typ_liste_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN aktion_typ_liste_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktion_typ_liste_bez
     ELSE NULL
     END), 'N/A')) AS aktion_typ_liste_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN aktion_typ_liste_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktion_typ_liste_bez
     ELSE NULL
     END), 'N/A')) AS aktion_typ_liste_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN aktion_typ_liste_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktion_typ_liste_bez
     ELSE NULL
     END), 'N/A')) AS aktion_typ_liste_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN aktion_typ_liste_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN aktion_typ_liste_bez
     ELSE NULL
     END), 'N/A')) AS aktion_typ_liste_bez_bg
FROM kfl_production_dbp_view.v_aktion_typ_liste_spr_zu_1
GROUP BY mandant_id,
 aktion_typ_liste_id;