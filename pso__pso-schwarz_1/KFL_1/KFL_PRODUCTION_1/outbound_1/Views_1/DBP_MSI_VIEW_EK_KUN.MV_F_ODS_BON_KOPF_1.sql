
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_f_ods_bon_kopf_1 (bon_id, bon_dat, wup_id, nb_id, mandant_id
, turnover_fg, wrg_id, kundenkarte_id, kundenkarte_typ_id) AS SELECT K.bon_id,
 K.bon_dat,
 K.wup_id,
 W.nb_id,
 K.mandant_id,
 K.turnover_fg,
 K.wrg_id,
  CASE
  WHEN K.mandant_id = 3 AND K.kundenkarte_typ_id = 2 OR K.mandant_id <> 3
  THEN K.kundenkarte_id
  ELSE NULL
  END AS kundenkarte_id,
  CASE
  WHEN K.mandant_id = 3 AND K.kundenkarte_typ_id = 2 OR K.mandant_id <> 3
  THEN K.kundenkarte_typ_id
  ELSE NULL
  END AS kundenkarte_typ_id
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_1 AS K
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS W ON K.mandant_id = W.mandant_id AND K.wup_id = W.wup_id
WHERE K.turnover_fg = 1
 AND (K.bon_id, K.wup_id, K.mandant_id) NOT IN (SELECT (bon_id , cast(wup_id as INT64), cast(mandant_id as INT64))
   FROM kfl_production_dbp_v_ods.v_ods_bon_storno_1 AS STO);