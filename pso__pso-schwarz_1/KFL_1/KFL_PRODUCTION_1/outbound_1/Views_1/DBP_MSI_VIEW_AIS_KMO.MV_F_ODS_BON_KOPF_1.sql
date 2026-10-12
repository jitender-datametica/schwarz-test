CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_f_ods_bon_kopf_1 (bon_id, bon_dat, wup_id, nb_id, mandant_id
, bon_booking, dat_booking, wrg_id) AS SELECT V01.bon_id,
 V01.bon_dat,
 V01.wup_id,
 0 AS nb_id,
 V01.mandant_id,
 V01.bon_booking,
 V01.dat_booking,
  CASE
  WHEN V01.wrg_id <> 'EUR' AND V02.default_wrg = 'EUR'
  THEN V02.default_wrg
  ELSE V01.wrg_id
  END AS wrg_id
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V02 ON V01.mandant_id = V02.mandant_id
WHERE V01.mandant_id > 1
 AND V01.bon_dat = CURRENT_DATE
 AND (V01.bon_id, V01.wup_id, V01.mandant_id) NOT IN (SELECT (bon_id, cast(wup_id as INT64), cast(mandant_id as INT64))
   FROM kfl_production_dbp_v_ods.v_ods_bon_storno_1);