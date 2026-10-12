CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_mandant_spr_zu_2 (mandant_id, mandant_kbez, mandant_bez,
mandant_bez_de, mandant_bez_cz, mandant_bez_sk, mandant_bez_hr, mandant_bez_pl, mandant_bez_ro, mandant_bez_bg) AS
SELECT V01.mandant_id,
 MAX(V02.land_id) AS mandant_kbez,
 COALESCE(MAX(CASE
    WHEN V02.mandant_id = 1
    THEN V02.land_bez
    ELSE NULL
    END), 'N/A') AS mandant_bez,
 COALESCE(MAX(CASE
    WHEN V02.mandant_id = 1
    THEN V02.land_bez
    ELSE NULL
    END), 'N/A') AS mandant_bez_de,
 COALESCE(MAX(CASE
    WHEN V02.mandant_id = 2
    THEN V02.land_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.mandant_id = 1
     THEN V02.land_bez
     ELSE NULL
     END), 'N/A')) AS mandant_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.mandant_id = 5
    THEN V02.land_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.mandant_id = 1
     THEN V02.land_bez
     ELSE NULL
     END), 'N/A')) AS mandant_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.mandant_id = 6
    THEN V02.land_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.mandant_id = 1
     THEN V02.land_bez
     ELSE NULL
     END), 'N/A')) AS mandant_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.mandant_id = 3
    THEN V02.land_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.mandant_id = 1
     THEN V02.land_bez
     ELSE NULL
     END), 'N/A')) AS mandant_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.mandant_id = 7
    THEN V02.land_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.mandant_id = 1
     THEN V02.land_bez
     ELSE NULL
     END), 'N/A')) AS mandant_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.mandant_id = 8
    THEN V02.land_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.mandant_id = 1
     THEN V02.land_bez
     ELSE NULL
     END), 'N/A')) AS mandant_bez_bg
FROM kfl_production_dbp_data.mandant_2 AS V01
 INNER JOIN kfl_production_dbp_data.land_2 AS V02 ON CASE
   WHEN V01.mandant_kbez = 'D'
   THEN 'DE'
   ELSE V01.mandant_kbez
   END = V02.land_id
WHERE V01.mandant_id <> 1
GROUP BY V01.mandant_id;