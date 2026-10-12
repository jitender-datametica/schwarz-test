CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_art_spr_zu_2 (mandant_id, art_id, kl_art_id, int_art_id,
art_bez, art_bez_de, art_bez_cz, art_bez_sk, art_bez_hr, art_bez_pl, art_bez_ro, art_bez_bg, int_art_bez, int_art_bez_de
, int_art_bez_cz, int_art_bez_sk, int_art_bez_hr, int_art_bez_pl, int_art_bez_ro, int_art_bez_bg) AS SELECT V01.mandant_id
 ,
 V01.art_id,
 V02.kl_art_id,
 V02.int_art_id,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.art_bez
    ELSE NULL
    END), 'N/A') AS art_bez,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.art_bez
    ELSE NULL
    END), 'N/A') AS art_bez_de,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.art_bez
     ELSE NULL
     END), 'N/A')) AS art_bez_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.art_bez
     ELSE NULL
     END), 'N/A')) AS art_bez_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.art_bez
     ELSE NULL
     END), 'N/A')) AS art_bez_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.art_bez
     ELSE NULL
     END), 'N/A')) AS art_bez_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.art_bez
     ELSE NULL
     END), 'N/A')) AS art_bez_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.art_bez
     ELSE NULL
     END), 'N/A')) AS art_bez_bg,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.int_art_bez
    ELSE NULL
    END), 'N/A') AS int_art_bez,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.int_art_bez
    ELSE NULL
    END), 'N/A') AS int_art_bez_de,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.int_art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.int_art_bez
     ELSE NULL
     END), 'N/A')) AS int_art_bez_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.int_art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.int_art_bez
     ELSE NULL
     END), 'N/A')) AS int_art_bez_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.int_art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.int_art_bez
     ELSE NULL
     END), 'N/A')) AS int_art_bez_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.int_art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.int_art_bez
     ELSE NULL
     END), 'N/A')) AS int_art_bez_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.int_art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.int_art_bez
     ELSE NULL
     END), 'N/A')) AS int_art_bez_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.int_art_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V01.spr_id = 22
     THEN V01.int_art_bez
     ELSE NULL
     END), 'N/A')) AS int_art_bez_bg
FROM kfl_production_dbp_data.art_spr_zu_2 AS V01
 INNER JOIN kfl_production_dbp_data.art_2 AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
WHERE V01.mandant_id <> 1
GROUP BY V01.mandant_id,
 V01.art_id,
 V02.kl_art_id,
 V02.int_art_id;