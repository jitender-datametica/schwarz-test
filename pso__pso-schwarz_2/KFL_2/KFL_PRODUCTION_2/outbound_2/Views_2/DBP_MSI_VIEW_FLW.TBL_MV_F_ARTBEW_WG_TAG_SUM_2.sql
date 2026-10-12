CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_artbew_wg_tag_sum_2 (dat, mandant_id, wg_id, arthiertyp_id
, in_kunde_id, ek_mep_umsatz_temp, bewart_id, default_wrg, umsatz_netto) AS SELECT V01.dat,
 V01.mandant_id,
 V01.wg_id,
 V01.arthiertyp_id,
 V02.flw_kunde_id AS in_kunde_id,
  CASE
  WHEN V01.wg_id IN (122, 128, 146, 147, 184, 186)
  THEN V01.ek_mep
  ELSE NULL
  END AS ek_mep_umsatz_temp,
 V01.bewart_id,
 V100.default_wrg,
 V01.umsatz_netto
FROM kfl_production_dbp_view.v_artbew_wg_tp2_sum_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_kunde_2 AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS V100 ON V01.mandant_id = V100.mandant_id
WHERE V01.mandant_id IN (1, 2)
 AND V01.arthiertyp_id = 2;