CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_artbew_zek_mo_sum_osec_1 (bewart_id, kjmo, mandant_id, vk_menge,
nb_id, umsatz_mwst_betrag, umsatz_netto, wup_id, zek_id, posten_id) AS SELECT bewart_id,
 kjmo,
 mandant_id,
 CAST(menge AS BIGNUMERIC) AS vk_menge,
 nb_id,
 CAST(umsatz_mwst_betrag AS BIGNUMERIC) AS umsatz_mwst_betrag,
 CAST(umsatz_netto AS BIGNUMERIC) AS umsatz_netto,
 wup_id,
 zek_id,
 SUBSTR(CASE
   WHEN bewart_id = 1001 AND posten_id <> 'PN'
   THEN ''
   ELSE 'PN'
   END, 1, 2) AS posten_id_
FROM kfl_production_dbp_view.v_artbew_zek_mo_sum_1
WHERE mandant_id = 1;