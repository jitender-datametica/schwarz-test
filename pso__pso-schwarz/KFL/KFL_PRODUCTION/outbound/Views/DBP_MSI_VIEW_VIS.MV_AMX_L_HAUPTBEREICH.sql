CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_l_hauptbereich AS SELECT V01.hauptbereich_id,
 V02.platzhalter_sort AS hauptbereich_sort,
 V01.hauptbereich_bez,
 V01.hauptbereich_bez AS hauptbereich_kbez
FROM kfl_production_dbp_view.v_amx_l_hauptbereich AS V01
 INNER JOIN kfl_production_dbp_view.v_amx_filter_benutzeroberflaeche AS V02 ON V01.hauptbereich_id = V02.platzhalter_id
WHERE V02.amx_filter_typ_id = 1
 AND V01.amx_system_id = 1
 AND V02.amx_system_id = 1;