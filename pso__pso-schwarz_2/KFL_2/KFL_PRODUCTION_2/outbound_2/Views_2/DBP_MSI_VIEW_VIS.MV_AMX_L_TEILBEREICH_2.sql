CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_l_teilbereich_2 AS SELECT V01.teilbereich_id,
 V02.platzhalter_sort AS teilbereich_sort,
 V01.teilbereich_bez,
 V01.teilbereich_bez AS teilbereich_kbez
FROM kfl_production_dbp_view.v_amx_l_teilbereich_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_amx_filter_benutzeroberflaeche_2 AS V02 ON V01.teilbereich_id = V02.platzhalter_id
WHERE V02.amx_filter_typ_id = 2
 AND V01.amx_system_id = 1
 AND V02.amx_system_id = 1;