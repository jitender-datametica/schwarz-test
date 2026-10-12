CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_bis.mv_l_in_art_wup_status_2 AS SELECT V01.mandant_id,
 V02.werk_id,
 V01.in_art_id,
 COALESCE(V03.einkaeufer_grp_id, '-1') AS einkaeufer_grp_id
FROM kfl_production_dbp_view.v_in_art_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_in_werk_2 AS V02 ON V01.mandant_id = V02.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_in_art_wup_status_2 AS V03 ON V01.in_art_id = V03.in_art_id AND V01.mandant_id = V03
    .mandant_id AND V02.werk_id = V03.werk_id;