CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_artbew_wg_tag_sum_osec_2 (dat, wg_id, arthiertyp_id, bewart_id,
mandant_id, wup_id, nb_id, umsatz_mwst_betrag, umsatz_netto, vk_menge, posten_id) AS SELECT dat,
 wg_id,
 arthiertyp_id,
 bewart_id,
 mandant_id,
 wup_id,
 nb_id,
 CAST(umsatz_mwst_betrag AS BIGNUMERIC) AS umsatz_mwst_betrag,
 CAST(umsatz_netto AS BIGNUMERIC) AS umsatz_netto,
 CAST(menge AS BIGNUMERIC) AS vk_menge,
  CASE
  WHEN bewart_id = 1001 AND posten_id <> 'PN'
  THEN ''
  ELSE 'PN'
  END AS posten_id_
FROM kfl_production_dbp_view.v_artbew_wg_tp2_sum_2
WHERE mandant_id = 1
 AND arthiertyp_id = 2;