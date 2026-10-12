-- ,spr_id
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_abschriftgruppe_ebene0_spr_zu (mandant_id,
abschriftgruppe_id_ebene0, abschriftgruppe_ebene0_bez, abschriftgruppe_ebene0_bez_de, abschriftgruppe_ebene0_bez_cz,
abschriftgruppe_ebene0_bez_sk, abschriftgruppe_ebene0_bez_hr, abschriftgruppe_ebene0_bez_pl,
abschriftgruppe_ebene0_bez_ro, abschriftgruppe_ebene0_bez_bg) AS -- Standard DE--
 -- DE--
 -- CZ--
 -- SK--
 -- HR--

-- PL--
 -- RO--
 -- BG--
 -- ,abschriftgruppe_bez
 SELECT V01.mandant_id,
 V01.abschriftgruppe_id AS abschriftgruppe_id_ebene0,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.abschriftgruppe_bez
    ELSE NULL
    END), 'N/A') AS abschriftgruppe_ebene0_bez,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.abschriftgruppe_bez
    ELSE NULL
    END), 'N/A') AS abschriftgruppe_ebene0_bez_de,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.abschriftgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.abschriftgruppe_bez
     ELSE NULL
     END), 'N/A')) AS abschriftgruppe_ebene0_bez_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.abschriftgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.abschriftgruppe_bez
     ELSE NULL
     END), 'N/A')) AS abschriftgruppe_ebene0_bez_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.abschriftgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.abschriftgruppe_bez
     ELSE NULL
     END), 'N/A')) AS abschriftgruppe_ebene0_bez_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.abschriftgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.abschriftgruppe_bez
     ELSE NULL
     END), 'N/A')) AS abschriftgruppe_ebene0_bez_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.abschriftgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.abschriftgruppe_bez
     ELSE NULL
     END), 'N/A')) AS abschriftgruppe_ebene0_bez_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.abschriftgruppe_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.abschriftgruppe_bez
     ELSE NULL
     END), 'N/A')) AS abschriftgruppe_ebene0_bez_bg
FROM kfl_production_dbp_view.v_abschriftgruppe_spr_zu AS V01
 INNER JOIN kfl_production_dbp_msi_view_ais_int.mv_abschriftgruppe_ebene0 AS V02 ON V01.mandant_id = V02.mandant_id AND
   V01.abschriftgruppe_id = V02.abschriftgruppe_id_ebene0
GROUP BY V01.mandant_id,
 V01.abschriftgruppe_id;