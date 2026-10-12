CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_gp_lts_2 (mandant_id, gp_id, gp_name, gp_name_de, gp_name_cz,
gp_name_pl, gp_name_md, gp_name_sk, gp_name_hr, gp_name_ro, gp_name_bg, gp_teilsortiment_id, gp_teilsortiment_bez,
gp_teilsortiment_bez_de, gp_teilsortiment_bez_cz, gp_teilsortiment_bez_sk, gp_teilsortiment_bez_hr,
gp_teilsortiment_bez_pl, gp_teilsortiment_bez_ro, gp_teilsortiment_bez_bg, zek_id, zahlungsziel_id) AS SELECT V01.mandant_id
 ,
 V01.gp_id,
 V03.gp_name_lat AS gp_name,
 V03.gp_name_lat AS gp_name_de,
 V03.gp_name_lat AS gp_name_cz,
 V03.gp_name_lat AS gp_name_pl,
 V03.gp_name_lat AS gp_name_md,
 V03.gp_name_lat AS gp_name_sk,
 V03.gp_name_lat AS gp_name_hr,
 V03.gp_name_lat AS gp_name_ro,
 V03.gp_name_lat AS gp_name_bg,
 V01.gp_teilsortiment_id,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), 'N/A') AS gp_teilsortiment_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), 'N/A') AS gp_teilsortiment_bez_de,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.gp_teilsortiment_bez
     ELSE NULL
     END), 'N/A')) AS gp_teilsortiment_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.gp_teilsortiment_bez
     ELSE NULL
     END), 'N/A')) AS gp_teilsortiment_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.gp_teilsortiment_bez
     ELSE NULL
     END), 'N/A')) AS gp_teilsortiment_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.gp_teilsortiment_bez
     ELSE NULL
     END), 'N/A')) AS gp_teilsortiment_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.gp_teilsortiment_bez
     ELSE NULL
     END), 'N/A')) AS gp_teilsortiment_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.gp_teilsortiment_bez
     ELSE NULL
     END), 'N/A')) AS gp_teilsortiment_bez_bg,
 V01.zek_id,
 V01.zahlungsziel_id
FROM kfl_production_dbp_view.v_l_gp_teilsortiment_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_gp_teilsortiment_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.gp_id =
    V02.gp_id AND V01.gp_teilsortiment_id = V02.gp_teilsortiment_id
 INNER JOIN kfl_production_dbp_view.v_gp_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.gp_id = V03.gp_id
WHERE V01.gp_id <> - 1
GROUP BY V01.mandant_id,
 V01.gp_id,
 gp_name,
 gp_name_de,
 gp_name_cz,
 gp_name_pl,
 gp_name_md,
 gp_name_sk,
 gp_name_hr,
 gp_name_ro,
 gp_name_bg,
 V01.gp_teilsortiment_id,
 V01.zek_id,
 V01.zahlungsziel_id
UNION ALL
SELECT V01.mandant_id,
 V03.gp_id,
 V03.gp_name_lat AS gp_name,
 V03.gp_name_lat AS gp_name_de,
 V03.gp_name_lat AS gp_name_cz,
 V03.gp_name_lat AS gp_name_pl,
 V03.gp_name_lat AS gp_name_md,
 V03.gp_name_lat AS gp_name_sk,
 V03.gp_name_lat AS gp_name_hr,
 V03.gp_name_lat AS gp_name_ro,
 V03.gp_name_lat AS gp_name_bg,
 V01.gp_teilsortiment_id,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), 'N/A') AS gp_teilsortiment_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), 'N/A') AS gp_teilsortiment_bez_de,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.gp_teilsortiment_bez
     ELSE NULL
     END), 'N/A')) AS gp_teilsortiment_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.gp_teilsortiment_bez
     ELSE NULL
     END), 'N/A')) AS gp_teilsortiment_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.gp_teilsortiment_bez
     ELSE NULL
     END), 'N/A')) AS gp_teilsortiment_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.gp_teilsortiment_bez
     ELSE NULL
     END), 'N/A')) AS gp_teilsortiment_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.gp_teilsortiment_bez
     ELSE NULL
     END), 'N/A')) AS gp_teilsortiment_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN V02.spr_id = 22
     THEN V02.gp_teilsortiment_bez
     ELSE NULL
     END), 'N/A')) AS gp_teilsortiment_bez_bg,
 V01.zek_id,
 V01.zahlungsziel_id
FROM kfl_production_dbp_view.v_l_gp_teilsortiment_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_gp_teilsortiment_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.gp_id =
    V02.gp_id AND V01.gp_teilsortiment_id = V02.gp_teilsortiment_id
 INNER JOIN kfl_production_dbp_view.v_gp_2 AS V03 ON V01.mandant_id = V03.mandant_id
WHERE V01.gp_id = - 1
GROUP BY V01.mandant_id,
 V03.gp_id,
 gp_name,
 gp_name_de,
 gp_name_cz,
 gp_name_pl,
 gp_name_md,
 gp_name_sk,
 gp_name_hr,
 gp_name_ro,
 gp_name_bg,
 V01.gp_teilsortiment_id,
 V01.zek_id,
 V01.zahlungsziel_id;