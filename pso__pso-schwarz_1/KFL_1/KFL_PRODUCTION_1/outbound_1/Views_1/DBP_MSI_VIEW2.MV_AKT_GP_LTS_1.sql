CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_akt_gp_lts_1 (mandant_id, akt_gp_id, akt_gp_name,
gp_teilsortiment_id, gp_teilsortiment_bez) AS SELECT V01.mandant_id,
 V01.gp_id AS akt_gp_id,
 V03.gp_name_lat AS akt_gp_name,
 V01.gp_teilsortiment_id,
 V02.gp_teilsortiment_bez
FROM kfl_production_dbp_view.v_l_gp_teilsortiment_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_gp_teilsortiment_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.gp_id =
    V02.gp_id AND V01.gp_teilsortiment_id = V02.gp_teilsortiment_id
 INNER JOIN kfl_production_dbp_view.v_gp_1 AS V03 ON V01.mandant_id = V03.mandant_id AND V01.gp_id = V03.gp_id
WHERE V01.gp_id <> - 1
 AND V01.mandant_id = 1
 AND V02.spr_id = 22
UNION ALL
SELECT V01.mandant_id,
 V03.gp_id,
 V03.gp_name_lat AS akt_gp_name,
 V01.gp_teilsortiment_id,
 V02.gp_teilsortiment_bez
FROM kfl_production_dbp_view.v_l_gp_teilsortiment_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_gp_teilsortiment_spr_zu_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.gp_id =
    V02.gp_id AND V01.gp_teilsortiment_id = V02.gp_teilsortiment_id
 INNER JOIN kfl_production_dbp_view.v_gp_1 AS V03 ON V01.mandant_id = V03.mandant_id
WHERE V01.gp_id = - 1
 AND V01.mandant_id = 1
 AND V02.spr_id = 22;