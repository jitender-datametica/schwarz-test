CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_hwg_spr_zu_2 (hwg_id, hwg_bez, hwg_bez_de, hwg_bez_cz,
hwg_bez_sk, hwg_bez_hr, hwg_bez_pl, hwg_bez_ro, hwg_bez_bg, mandant_id, arthiertyp_id, abt_id) AS SELECT V01.hwg_id,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.hwg_bez
    ELSE NULL
    END), 'N/A') AS hwg_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.hwg_bez
    ELSE NULL
    END), 'N/A') AS hwg_bez_de,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.hwg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.hwg_bez
     ELSE NULL
     END), 'N/A')) AS hwg_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.hwg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.hwg_bez
     ELSE NULL
     END), 'N/A')) AS hwg_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.hwg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.hwg_bez
     ELSE NULL
     END), 'N/A')) AS hwg_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.hwg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.hwg_bez
     ELSE NULL
     END), 'N/A')) AS hwg_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.hwg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.hwg_bez
     ELSE NULL
     END), 'N/A')) AS hwg_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.hwg_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.hwg_bez
     ELSE NULL
     END), 'N/A')) AS hwg_bez_bg,
 V01.mandant_id,
 V01.arthiertyp_id,
 V01.abt_id
FROM kfl_production_dbp_view.v_hwg_per_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_hwg_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.hwg_id = V02.hwg_id
WHERE V01.arthiertyp_id = 2
 AND V01.dat_bis = DATE '9999-12-31'
GROUP BY V01.hwg_id,
 V01.mandant_id,
 V01.arthiertyp_id,
 V01.abt_id;