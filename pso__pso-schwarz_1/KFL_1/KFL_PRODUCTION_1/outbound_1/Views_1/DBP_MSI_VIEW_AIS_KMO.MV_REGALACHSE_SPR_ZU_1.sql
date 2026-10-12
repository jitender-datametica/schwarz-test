CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_regalachse_spr_zu_1 (mandant_id, fbb_nr, regalachse_bez,
regalachse_bez_de, regalachse_bez_cz, regalachse_bez_sk, regalachse_bez_hr, regalachse_bez_pl, regalachse_bez_ro,
regalachse_bez_bg, dat_bis_neu) AS SELECT V01.mandant_id,
 V01.fbb_nr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.layoutbaustein_bez
    ELSE NULL
    END), 'N/A') AS regalachse_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.layoutbaustein_bez
    ELSE NULL
    END), 'N/A') AS regalachse_bez_de,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.layoutbaustein_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.layoutbaustein_bez
     ELSE NULL
     END), 'N/A')) AS regalachse_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.layoutbaustein_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.layoutbaustein_bez
     ELSE NULL
     END), 'N/A')) AS regalachse_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.layoutbaustein_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.layoutbaustein_bez
     ELSE NULL
     END), 'N/A')) AS regalachse_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.layoutbaustein_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.layoutbaustein_bez
     ELSE NULL
     END), 'N/A')) AS regalachse_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.layoutbaustein_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.layoutbaustein_bez
     ELSE NULL
     END), 'N/A')) AS regalachse_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.layoutbaustein_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.layoutbaustein_bez
     ELSE NULL
     END), 'N/A')) AS regalachse_bez_bg,
  CASE
  WHEN SUBSTR(V01.fbb_nr, 1, 4) >= 'P150' AND V01.dat_bis <> DATE '9999-12-31'
  THEN DATE_ADD(V01.dat_bis, INTERVAL 150 DAY)
  ELSE V01.dat_bis
  END AS dat_bis_neu
FROM kfl_production_dbp_view.v_regalachse_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_layoutbaustein_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.layoutbaustein_id
    = V02.layoutbaustein_id
WHERE V01.mandant_id <> 1
 AND CASE
   WHEN SUBSTR(V01.fbb_nr, 1, 4) >= 'P150' AND V01.dat_bis <> DATE '9999-12-31'
   THEN DATE_ADD(V01.dat_bis, INTERVAL 150 DAY)
   ELSE V01.dat_bis
   END >= CURRENT_DATE
GROUP BY V01.mandant_id,
 V01.fbb_nr,
 V02.layoutbaustein_bez,
 V01.dat_bis
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(V01.mandant_id AS STRING), V01.fbb_nr ORDER BY CASE
       WHEN SUBSTR(V01.fbb_nr, 1, 4) >= 'P150' AND V01.dat_bis <> DATE '9999-12-31'
       THEN DATE_ADD(V01.dat_bis, INTERVAL 150 DAY)
       ELSE V01.dat_bis
       END IS NULL, CASE
       WHEN SUBSTR(V01.fbb_nr, 1, 4) >= 'P150' AND V01.dat_bis <> DATE '9999-12-31'
       THEN DATE_ADD(V01.dat_bis, INTERVAL 150 DAY)
       ELSE V01.dat_bis
       END)) = 1;