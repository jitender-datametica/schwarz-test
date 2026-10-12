CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_l_dispomerkmal (mandant_id, dismm, mandant_kbez) AS SELECT V01
 .mandant_id,
 V01.dispomerkmal AS dismm,
 V02.mandant_kbez
FROM kfl_production_dbp_view.v_l_dispomerkmal AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant AS V02 ON V01.mandant_id = V02.mandant_id
WHERE V01.mandant_id <> 1;