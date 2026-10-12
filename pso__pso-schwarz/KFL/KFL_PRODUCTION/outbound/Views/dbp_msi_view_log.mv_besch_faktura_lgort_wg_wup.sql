CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_besch_faktura_lgort_wg_wup (mandant_id, wup_id, nb_id,
lagerort_id, wg_id, fakturaart_id, dat_faktura, dat_erstellung, dat_leist_erstellung, arthiertyp_id, verrechnung_betrag
, zwsum_1_betrag, zwsum_2_betrag, zwsum_3_betrag, zwsum_4_betrag, zwsum_5_betrag, zwsum_6_betrag, menge_faktura_bme,
menge_faktura_kolli, menge_faktura_palette, auftrag_grund_id, zwsum_8_betrag, zwsum_9_betrag, bestellart_id,
dat_preisfindung, auftraggeber_id, mandant_id_auftraggeber, vk_netto_betrag, vk_netto_rekl_tkl_betrag) AS SELECT
 mandant_id,
 wup_id,
 nb_id,
 lagerort_id,
 wg_id,
 fakturaart_id,
 dat_faktura,
 dat_erstellung,
 dat_leist_erstellung,
 arthiertyp_id,
  CASE
  WHEN fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS',
    'ZLUS')
  THEN verrechnung_betrag * - 1
  ELSE verrechnung_betrag
  END AS verrechnung_betrag,
  CASE
  WHEN fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS',
    'ZLUS')
  THEN zwsum_1_betrag * - 1
  ELSE zwsum_1_betrag
  END AS zwsum_1_betrag,
  CASE
  WHEN fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS',
    'ZLUS')
  THEN zwsum_2_betrag * - 1
  ELSE zwsum_2_betrag
  END AS zwsum_2_betrag,
  CASE
  WHEN fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS',
    'ZLUS')
  THEN zwsum_3_betrag * - 1
  ELSE zwsum_3_betrag
  END AS zwsum_3_betrag,
  CASE
  WHEN fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS',
    'ZLUS')
  THEN zwsum_4_betrag * - 1
  ELSE zwsum_4_betrag
  END AS zwsum_4_betrag,
  CASE
  WHEN fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS',
    'ZLUS')
  THEN zwsum_5_betrag * - 1
  ELSE zwsum_5_betrag
  END AS zwsum_5_betrag,
  CASE
  WHEN fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS',
    'ZLUS')
  THEN zwsum_6_betrag * - 1
  ELSE zwsum_6_betrag
  END AS zwsum_6_betrag,
  CASE
  WHEN fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS',
    'ZLUS')
  THEN menge_faktura_bme * - 1
  ELSE menge_faktura_bme
  END AS menge_faktura_bme,
  CASE
  WHEN fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS',
    'ZLUS')
  THEN menge_faktura_kolli * - 1
  ELSE menge_faktura_kolli
  END AS menge_faktura_kolli,
  CASE
  WHEN fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS',
    'ZLUS')
  THEN menge_faktura_palette * - 1
  ELSE menge_faktura_palette
  END AS menge_faktura_palette,
 COALESCE(auftrag_grund_id, '   ') AS auftrag_grund_id,
  CASE
  WHEN fakturaart_id IN ('S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS', 'ZLUS')
  THEN zwsum_8_betrag * - 1
  ELSE zwsum_8_betrag
  END AS zwsum_8_betrag,
  CASE
  WHEN fakturaart_id IN ('S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS', 'ZLUS')
  THEN zwsum_9_betrag * - 1
  ELSE zwsum_9_betrag
  END AS zwsum_9_betrag,
 COALESCE(bestellart_id, '-2') AS bestellart_id,
 dat_preisfindung,
 LTRIM(auftraggeber_id, '0') AS auftraggeber_id,
 CAST(CASE
   WHEN auftraggeber_id = '940001313'
   THEN 2
   WHEN auftraggeber_id = '940001305'
   THEN 3
   WHEN auftraggeber_id = '940001355'
   THEN 5
   WHEN auftraggeber_id = '940001321'
   THEN 6
   WHEN auftraggeber_id = '940001347'
   THEN 7
   WHEN auftraggeber_id = '940001339'
   THEN 8
   ELSE 1
   END AS BIGNUMERIC) AS mandant_id_auftraggeber,
  CASE
  WHEN fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS',
    'ZLUS')
  THEN vk_netto_betrag * - 1
  ELSE vk_netto_betrag
  END AS vk_netto_betrag,
  CASE
  WHEN fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS',
    'ZLUS')
  THEN vk_netto_rekl_tkl_betrag * - 1
  ELSE vk_netto_rekl_tkl_betrag
  END AS vk_netto_rekl_tkl_betrag
FROM kfl_production_dbp_view.v_besch_faktura_lgort_wg_wup AS V01;