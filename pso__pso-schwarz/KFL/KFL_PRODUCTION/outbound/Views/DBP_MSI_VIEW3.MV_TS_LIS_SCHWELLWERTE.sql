CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_ts_lis_schwellwerte (mandant_id, wup_id, nb_id,
schwellwert_typ_bez, schwellwert, mandant_kbez) AS SELECT V01.mandant_id,
 V01.wup_id,
 V01.nb_id,
 V01.schwellwert_typ_bez,
 V01.schwellwert,
 V02.mandant_kbez
FROM kfl_production_dbp_msi_view3.ts_lis_schwellwerte AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant AS V02 ON V01.mandant_id = V02.mandant_id;