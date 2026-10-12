CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_wug_spr_zu_2 AS SELECT V01.mandant_id,
 V01.arthiertyp_id,
 V01.wg_id,
 V01.wug_id,
 MAX(COALESCE(CASE
    WHEN INSTR(UPPER(CASE
        WHEN V01.mandant_id = 1
        THEN 'Gesperrt'
        WHEN V01.mandant_id = 2
        THEN 'BLOKOV\u00c1NO'
        WHEN V01.mandant_id = 3
        THEN 'zablokowane'
        WHEN V01.mandant_id = 5
        THEN 'Blokované'
        WHEN V01.mandant_id = 6
        THEN 'ZATVORENO'
        WHEN V01.mandant_id = 7
        THEN '\u00ceNCHIS'
        WHEN V01.mandant_id = 8
        THEN 'Блокирана'
        ELSE NULL
        END), V02.wug_bez) = 1
    THEN 1
    ELSE NULL
    END, 0)) AS wug_gesperrt,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.wug_bez
    ELSE NULL
    END), 'N/A') AS wug_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.wug_bez
    ELSE NULL
    END), 'N/A') AS wug_bez_de,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.wug_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.wug_bez
     ELSE NULL
     END), 'N/A')) AS wug_bez_bg
FROM kfl_production_dbp_view.v_wug_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_wug_spr_zu_2 AS V02 ON V01.wg_id = V02.wg_id AND V01.wug_id = V02.wug_id
WHERE V01.arthiertyp_id = 2
 AND V02.arthiertyp_id = 2
GROUP BY V01.mandant_id,
 V01.arthiertyp_id,
 V01.wg_id,
 V01.wug_id;