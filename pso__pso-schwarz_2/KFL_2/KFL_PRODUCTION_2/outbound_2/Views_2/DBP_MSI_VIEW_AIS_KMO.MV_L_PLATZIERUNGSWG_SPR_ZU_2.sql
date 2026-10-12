CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_platzierungswg_spr_zu_2 (mandant_id, platzierungswg_id,
platzierungswg_nr, platzierungswg_bez, platzierungswg_bez_de, platzierungswg_bez_cz, platzierungswg_bez_sk,
platzierungswg_bez_hr, platzierungswg_bez_pl, platzierungswg_bez_ro, platzierungswg_bez_bg) AS SELECT V01.mandant_id,
 V01.platzierungswg_id,
 V03.platzierungswg_nr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.platzierungswg_bez
    ELSE NULL
    END), 'N/A') AS platzierungswg_bez,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.platzierungswg_bez
    ELSE NULL
    END), 'N/A') AS platzierungswg_bez_de,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.platzierungswg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.platzierungswg_bez
     ELSE NULL
     END), 'N/A')) AS platzierungswg_bez_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.platzierungswg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.platzierungswg_bez
     ELSE NULL
     END), 'N/A')) AS platzierungswg_bez_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.platzierungswg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.platzierungswg_bez
     ELSE NULL
     END), 'N/A')) AS platzierungswg_bez_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.platzierungswg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.platzierungswg_bez
     ELSE NULL
     END), 'N/A')) AS platzierungswg_bez_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.platzierungswg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.platzierungswg_bez
     ELSE NULL
     END), 'N/A')) AS platzierungswg_bez_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.platzierungswg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.platzierungswg_bez
     ELSE NULL
     END), 'N/A')) AS platzierungswg_bez_bg
FROM kfl_production_dbp_view.v_platzierungswg_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_l_platzierungswg_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.platzierungswg_id
    = V03.platzierungswg_id
WHERE V01.mandant_id <> 1
GROUP BY V01.mandant_id,
 V01.platzierungswg_id,
 V03.platzierungswg_nr;