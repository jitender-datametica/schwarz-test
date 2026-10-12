CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_einkaeufer_grp_2 (mandant_id, einkaeufer_grp_id) AS SELECT 99
 AS mandant_id,
 einkaeufer_int_id AS einkaeufer_grp_id
FROM kfl_production_dbp_view.v_in_l_einkaeufer_int_2
UNION DISTINCT
SELECT mandant_id,
 einkaeufer_grp_id
FROM kfl_production_dbp_view.v_in_l_einkaeufer_grp_2 AS V01
WHERE aktiv_fg = 1
 AND einkaeufer_grp_id <> '-1'
 AND (mandant_id <> 1 OR mandant_id = 1 AND SUBSTR(einkaeufer_grp_id, 1, 1) = 'S');