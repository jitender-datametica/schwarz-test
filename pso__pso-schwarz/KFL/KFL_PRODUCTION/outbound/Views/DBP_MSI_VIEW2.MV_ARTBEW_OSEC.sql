CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_artbew_osec (art_id, bewart_id, dat, gp_id, herst_id, mandant_id
, mwst_id, nb_id, umsatz_mwst_betrag, umsatz_netto, vk_menge, wrg, wup_id, bezugsweg_id, aktion_id, posten_id) AS SELECT
 art_id,
 bewart_id,
 dat,
 gp_id,
 herst_id,
 mandant_id,
 mwst_id,
 nb_id,
 CAST(umsatz_mwst_betrag AS BIGNUMERIC) AS umsatz_mwst_betrag,
 CAST(umsatz_netto AS BIGNUMERIC) AS umsatz_netto,
 CAST(menge AS BIGNUMERIC) AS vk_menge,
 wrg,
 wup_id,
 bezugsweg_id,
 aktion_id,
  CASE
  WHEN bewart_id = 1001 AND posten_id <> 'PN'
  THEN ''
  ELSE 'PN'
  END AS posten_id_
FROM kfl_production_dbp_view.v_artbew
WHERE mandant_id = 1
 AND bewart_id = 1001;