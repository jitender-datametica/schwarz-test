CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_einkaeufer_grp_spr_zu_cz (mandant_id, einkaeufer_grp_id,
einkaeufer_grp_bez) AS SELECT 99 AS mandant_id,
 einkaeufer_int_id AS einkaeufer_grp_id,
 einkaeufer_int_name AS einkaeufer_grp_bez
FROM kfl_production_dbp_view.v_in_l_einkaeufer_int
UNION DISTINCT
SELECT V01.mandant_id,
 V01.einkaeufer_grp_id,
 CAST(V02.einkaeufer_grp_bez AS STRING) AS einkaeufer_grp_bez
FROM kfl_production_dbp_view.v_in_l_einkaeufer_grp AS V01
 INNER JOIN kfl_production_dbp_view.v_in_einkaeufer_grp_spr_zu AS V02 ON V01.mandant_id = V02.mandant_id AND V01.einkaeufer_grp_id
    = V02.einkaeufer_grp_id
WHERE V02.spr_id = 124
 AND V01.aktiv_fg = 1
 AND V01.einkaeufer_grp_id <> '-1'
 AND (V01.mandant_id <> 1 OR V01.mandant_id = 1 AND SUBSTR(V01.einkaeufer_grp_id, 1, 1) = 'S');