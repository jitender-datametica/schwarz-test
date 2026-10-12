CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_hwg_wg_zu_per (hwg_id, owg_id, wg_id, mandant_id, dat_von
, dat_bis, arthiertyp_id) AS SELECT V01.hwg_id,
 V02.owg_id,
 V03.wg_id,
 V01.mandant_id,
 V01.dat_von,
 V01.dat_bis,
 V01.arthiertyp_id
FROM kfl_production_dbp_view.v_hwg_per AS V01
 INNER JOIN kfl_production_dbp_view.v_owg_per AS V02 ON V01.mandant_id = V02.mandant_id AND V01.hwg_id = V02.hwg_id
 INNER JOIN kfl_production_dbp_view.v_wg_per AS V03 ON V02.mandant_id = V03.mandant_id AND V02.owg_id = V03.owg_id
WHERE V01.mandant_id <> 1
 AND V01.arthiertyp_id = 2
 AND V01.dat_bis = DATE '9999-12-31';