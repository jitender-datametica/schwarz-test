CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_ods_bondaten (mandant_id, wup_id, bon_dat, arthiertyp_id,
wg_id, anzahl_scanned, anzahl_keyed, anzahl_bons) AS SELECT K.mandant_id,
 K.wup_id,
 K.bon_dat,
 V02.arthiertyp_id,
 V02.wg_id,
 SUM(CASE
   WHEN V.erfassung_id = 'SC'
   THEN 1
   ELSE 0
   END) AS anzahl_scanned,
 SUM(CASE
   WHEN V.erfassung_id = 'KE'
   THEN 1
   ELSE 0
   END) AS anzahl_keyed,
 COUNT(DISTINCT K.bon_id) AS anzahl_bons
FROM kfl_production_dbp_v_ods.v_ods_bon_verkauf AS V
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_kopf AS K ON V.mandant_id = K.mandant_id AND V.wup_id = K.wup_id AND V.bon_id
     = K.bon_id AND V.bon_dat = K.bon_dat
 INNER JOIN kfl_production_dbp_view.v_art AS V01 ON V.kl_art_id = V01.kl_art_id AND V.mandant_id = V01.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS V02 ON V01.art_id = V02.art_id AND V01.mandant_id = V02.mandant_id
   
WHERE K.mandant_id IN (1, 2)
 AND (K.bon_id, K.bon_dat) NOT IN (SELECT (bon_id, bon_dat)
   FROM kfl_production_dbp_v_ods.v_ods_bon_storno)
GROUP BY K.mandant_id,
 K.wup_id,
 K.bon_dat,
 V02.arthiertyp_id,
 V02.wg_id;