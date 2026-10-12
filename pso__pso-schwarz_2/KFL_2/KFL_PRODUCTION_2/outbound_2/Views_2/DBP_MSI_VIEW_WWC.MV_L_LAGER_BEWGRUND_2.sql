CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_lager_bewgrund_2 (mandant_id, mandant_kbez, grund, bwart,
zzprtart) AS SELECT V01.mandant_id,
 V02.mandant_kbez,
 V01.grund_id AS grund,
 V01.lager_bewart_id AS bwart,
 V01.retourenart_id AS zzprtart
FROM kfl_production_dbp_view.v_l_lager_bewgrund_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V02 ON V01.mandant_id = V02.mandant_id
WHERE V01.hist_fg = 0;