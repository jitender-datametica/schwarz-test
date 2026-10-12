CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_vw_ret_kunde_zu (vw_id, vw_ret_bez, mandant_id, vwvt_bez,
in_kunde_id, kunde_nr, kunde_name) AS SELECT V01.vw_id,
 V01.vw_bez AS vw_ret_bez,
 V01.mandant_id,
 V01.vwvt_bez,
 V03.flw_kunde_id AS in_kunde_id,
 COLLATE(LTRIM(COLLATE(V03.kunde_nr, ''), '0'), 'und:ci') AS kunde_nr,
 V03.kunde_name
FROM kfl_production_dbp_view.v_l_vw AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V02 ON V01.vw_id = V02.vw_id AND V01.mandant_id = V02.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_flw_kunde AS V03 ON V02.wup_id = V03.wup_id AND V02.mandant_id = V03.mandant_id
WHERE V01.mandant_id IN (1, 2)
 AND V01.vwart_id = 1
 AND V01.vw_id IN (6, 10);