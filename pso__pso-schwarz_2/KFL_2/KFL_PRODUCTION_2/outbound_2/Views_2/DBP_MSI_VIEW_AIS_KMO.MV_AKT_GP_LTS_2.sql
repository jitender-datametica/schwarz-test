CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_akt_gp_lts_2 (mandant_id, akt_gp_id, akt_gp_name,
gp_teilsortiment_id, gp_teilsortiment_bez) AS SELECT V01.mandant_id,
 V01.gp_id AS akt_gp_id,
 V03.gp_name AS akt_gp_name,
 V01.gp_teilsortiment_id,
 V02.gp_teilsortiment_bez
FROM kfl_production_dbp_view.v_l_gp_teilsortiment_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_gp_teilsortiment_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.gp_id =
    V02.gp_id AND V01.gp_teilsortiment_id = V02.gp_teilsortiment_id
 INNER JOIN kfl_production_dbp_view.v_gp_2 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.gp_id = V03.gp_id
WHERE V01.mandant_id <> 1
 AND V01.gp_id <> - 1
UNION ALL
SELECT V01.mandant_id,
 V03.gp_id,
 V03.gp_name AS akt_gp_name,
 V01.gp_teilsortiment_id,
 V02.gp_teilsortiment_bez
FROM kfl_production_dbp_view.v_l_gp_teilsortiment_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_gp_teilsortiment_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.gp_id =
    V02.gp_id AND V01.gp_teilsortiment_id = V02.gp_teilsortiment_id
 INNER JOIN kfl_production_dbp_view.v_gp_2 AS V03 ON V01.mandant_id = V03.mandant_id
WHERE V01.mandant_id <> 1
 AND V01.gp_id = - 1;