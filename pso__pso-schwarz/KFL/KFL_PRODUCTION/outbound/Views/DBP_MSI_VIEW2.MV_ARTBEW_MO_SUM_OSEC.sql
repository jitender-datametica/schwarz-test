CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_artbew_mo_sum_osec (kjmo, art_id, bewart_id, mandant_id, wup_id,
nb_id, gp_id, herst_id, umsatz_mwst_betrag, umsatz_netto, vk_menge, posten_id) AS SELECT kjmo,
 art_id,
 bewart_id,
 mandant_id,
 wup_id,
 nb_id,
 gp_id,
 herst_id,
 CAST(umsatz_mwst_betrag AS BIGNUMERIC) AS umsatz_mwst_betrag,
 CAST(umsatz_netto AS BIGNUMERIC) AS umsatz_netto,
 CAST(menge AS BIGNUMERIC) AS vk_menge,
 SUBSTR(CASE
   WHEN bewart_id = 1001 AND posten_id <> 'PN'
   THEN ''
   ELSE 'PN'
   END, 1, 2) AS posten_id_
FROM kfl_production_dbp_view.v_artbew_mo_sum
WHERE mandant_id = 1;