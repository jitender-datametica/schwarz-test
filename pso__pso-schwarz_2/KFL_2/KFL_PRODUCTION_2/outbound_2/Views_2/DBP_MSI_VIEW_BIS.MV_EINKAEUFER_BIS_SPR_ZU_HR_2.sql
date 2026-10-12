CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_einkaeufer_bis_spr_zu_hr_2 (mandant_id, einkaeufer_bis_id,
einkaeufer_bis_bez) AS SELECT 99 AS mandant_id,
 einkaeufer_bis_int_id AS einkaeufer_bis_id,
 einkaeufer_bis_int_name AS einkaeufer_bis_bez
FROM kfl_production_dbp_view.v_in_l_einkaeufer_bis_int_2
UNION DISTINCT
SELECT V01.mandant_id,
 V01.einkaeufer_grp_id AS einkaeufer_bis_id,
 CAST(V02.einkaeufer_grp_bez AS STRING) AS einkaeufer_bis_bez
FROM kfl_production_dbp_view.v_in_l_einkaeufer_grp_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_in_einkaeufer_grp_spr_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.einkaeufer_grp_id
    = V02.einkaeufer_grp_id
WHERE V02.spr_id = 65
 AND V01.aktiv_fg = 1
 AND (V01.mandant_id <> 1 OR V01.mandant_id = 1 AND (SUBSTR(V01.einkaeufer_grp_id, 1, 1) = 'S' OR V01.einkaeufer_grp_id
       = '-1'));