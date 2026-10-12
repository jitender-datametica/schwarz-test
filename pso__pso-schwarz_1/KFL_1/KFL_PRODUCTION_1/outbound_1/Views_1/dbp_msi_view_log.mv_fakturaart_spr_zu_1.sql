CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_fakturaart_spr_zu_1 (mandant_id, fakturaart_id, fakturaart_bez,
fakturaart_bez_de, fakturaart_bez_cz, fakturaart_bez_sk, fakturaart_bez_hr, fakturaart_bez_pl, fakturaart_bez_ro,
fakturaart_bez_bg) AS SELECT mandant_id,
 fakturaart_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN fakturaart_bez
   ELSE NULL
   END) AS fakturaart_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN fakturaart_bez
   ELSE NULL
   END) AS fakturaart_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN fakturaart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN fakturaart_bez
    ELSE NULL
    END)) AS fakturaart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN fakturaart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN fakturaart_bez
    ELSE NULL
    END)) AS fakturaart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN fakturaart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN fakturaart_bez
    ELSE NULL
    END)) AS fakturaart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN fakturaart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN fakturaart_bez
    ELSE NULL
    END)) AS fakturaart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN fakturaart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN fakturaart_bez
    ELSE NULL
    END)) AS fakturaart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN fakturaart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN fakturaart_bez
    ELSE NULL
    END)) AS fakturaart_bez_bg
FROM kfl_production_dbp_view.v_fakturaart_spr_zu_1 AS V01
WHERE fakturaart_id IN ('G2', 'ZGLT', 'ZGWP', 'ZEWP', 'L2', 'ZVLT', 'ZMWP', 'S1', 'ZSLT', 'ZSMP', 'S2', 'Z5LT', 'Z5MP',
   'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZIVS', 'ZLF2', 'ZLG2', 'ZLIG', 'ZLL2', 'ZLLS', 'ZLRE', 'ZLRS', 'ZLS2', 'ZLUL', 'ZLUS'
   , 'ZIST', 'ZIVT')
GROUP BY mandant_id,
 fakturaart_id;