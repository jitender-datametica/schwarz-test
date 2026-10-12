CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_gp_lts_sk_2 (mandant_id, gp_id, gp_name, gp_teilsortiment_id,
gp_teilsortiment_bez, zek_id, zahlungsziel_id) AS SELECT V01.mandant_id,
 V01.gp_id,
 V03.gp_name_lat AS gp_name,
 V01.gp_teilsortiment_id,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), 'N/A') AS gp_teilsortiment_bez,
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
 V01.gp_teilsortiment_id,
 V01.zek_id,
 V01.zahlungsziel_id
UNION ALL
SELECT V01.mandant_id,
 V03.gp_id,
 V03.gp_name_lat AS gp_name,
 V01.gp_teilsortiment_id,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.gp_teilsortiment_bez
    ELSE NULL
    END), 'N/A') AS gp_teilsortiment_bez,
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
 V01.gp_teilsortiment_id,
 V01.zek_id,
 V01.zahlungsziel_id;