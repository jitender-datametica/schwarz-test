CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_geschaeftsvorfall_2 (mandant_id, geschaeftsvorfall_id,
geschaeftsvorfall_bez, geschaeftsvorfall_bez_de, geschaeftsvorfall_bez_cz, geschaeftsvorfall_bez_sk,
geschaeftsvorfall_bez_hr, geschaeftsvorfall_bez_pl, geschaeftsvorfall_bez_ro, geschaeftsvorfall_bez_bg) AS SELECT V01.mandant_id
 ,
 V01.geschaeftsvorfall_id,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.geschaeftsvorfall_bez
    ELSE NULL
    END), 'N/A') AS geschaeftsvorfall_bez,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 22
    THEN V03.geschaeftsvorfall_bez
    ELSE NULL
    END), 'N/A') AS geschaeftsvorfall_bez_de,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 124
    THEN V03.geschaeftsvorfall_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V03.spr_id = 22
     THEN V03.geschaeftsvorfall_bez
     ELSE NULL
     END), 'N/A')) AS geschaeftsvorfall_bez_cz,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 108
    THEN V03.geschaeftsvorfall_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V03.spr_id = 22
     THEN V03.geschaeftsvorfall_bez
     ELSE NULL
     END), 'N/A')) AS geschaeftsvorfall_bez_sk,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 65
    THEN V03.geschaeftsvorfall_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V03.spr_id = 22
     THEN V03.geschaeftsvorfall_bez
     ELSE NULL
     END), 'N/A')) AS geschaeftsvorfall_bez_hr,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 90
    THEN V03.geschaeftsvorfall_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V03.spr_id = 22
     THEN V03.geschaeftsvorfall_bez
     ELSE NULL
     END), 'N/A')) AS geschaeftsvorfall_bez_pl,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 95
    THEN V03.geschaeftsvorfall_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V03.spr_id = 22
     THEN V03.geschaeftsvorfall_bez
     ELSE NULL
     END), 'N/A')) AS geschaeftsvorfall_bez_ro,
 COALESCE(MAX(CASE
    WHEN V03.spr_id = 18
    THEN V03.geschaeftsvorfall_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V03.spr_id = 22
     THEN V03.geschaeftsvorfall_bez
     ELSE NULL
     END), 'N/A')) AS geschaeftsvorfall_bez_bg
FROM kfl_production_dbp_view.v_l_geschaeftsvorfall_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_geschaeftsvorfall_spr_zu_2 AS V03 ON V01.geschaeftsvorfall_id = V03.geschaeftsvorfall_id
    AND V01.mandant_id = V03.mandant_id
WHERE V01.mandant_id <> 1
GROUP BY V01.mandant_id,
 V01.geschaeftsvorfall_id;