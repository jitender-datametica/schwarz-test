CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_besch_faktura_lgort_wg_wup_1 (mandant_id, system_id, wup_id,
nb_id, lagerort_id, wg_id, fakturaart_id, dat_faktura, dat_erstellung, dat_leist_erstellung, arthiertyp_id,
verrechnung_betrag, zwsum_1_betrag, zwsum_2_betrag, zwsum_3_betrag, zwsum_4_betrag, zwsum_5_betrag, zwsum_6_betrag,
menge_faktura_bme, menge_faktura_kolli, menge_faktura_palette, auftrag_grund_id, zwsum_8_betrag, zwsum_9_betrag,
bestellart_id, dat_preisfindung, auftraggeber_id, vk_netto_betrag, vk_netto_rekl_tkl_betrag) AS SELECT mandant_id,
 7 AS system_id,
 wup_id,
 nb_id,
 lagerort_id,
 wg_id,
 fakturaart_id,
  CASE
  WHEN fakturaart_id IN ('ZVLT', 'ZMWP', 'ZGLT', 'ZGWP', 'ZSLT', 'ZSMP', 'Z5LT', 'Z5MP', 'ZEWP', 'ZSWP')
  THEN dat_leist_erstellung
  ELSE dat_faktura
  END AS dat_faktura,
 dat_erstellung,
 dat_leist_erstellung,
 arthiertyp_id,
  CASE
  WHEN fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN verrechnung_betrag * - 1
  ELSE verrechnung_betrag
  END AS verrechnung_betrag,
  CASE
  WHEN fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN zwsum_1_betrag * - 1
  ELSE zwsum_1_betrag
  END AS zwsum_1_betrag,
  CASE
  WHEN fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN zwsum_2_betrag * - 1
  ELSE zwsum_2_betrag
  END AS zwsum_2_betrag,
  CASE
  WHEN fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN zwsum_3_betrag * - 1
  ELSE zwsum_3_betrag
  END AS zwsum_3_betrag,
  CASE
  WHEN fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN zwsum_4_betrag * - 1
  ELSE zwsum_4_betrag
  END AS zwsum_4_betrag,
  CASE
  WHEN fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN zwsum_5_betrag * - 1
  ELSE zwsum_5_betrag
  END AS zwsum_5_betrag,
  CASE
  WHEN fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN zwsum_6_betrag * - 1
  ELSE zwsum_6_betrag
  END AS zwsum_6_betrag,
  CASE
  WHEN fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN menge_faktura_bme * - 1
  ELSE menge_faktura_bme
  END AS menge_faktura_bme,
  CASE
  WHEN fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN menge_faktura_kolli * - 1
  ELSE menge_faktura_kolli
  END AS menge_faktura_kolli,
  CASE
  WHEN fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN menge_faktura_palette * - 1
  ELSE menge_faktura_palette
  END AS menge_faktura_palette,
 auftrag_grund_id,
  CASE
  WHEN fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN zwsum_8_betrag * - 1
  ELSE zwsum_8_betrag
  END AS zwsum_8_betrag,
  CASE
  WHEN fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN zwsum_9_betrag * - 1
  ELSE zwsum_9_betrag
  END AS zwsum_9_betrag,
 bestellart_id,
 dat_preisfindung,
 ROUND(CAST(IF(auftraggeber_id = '', SUBSTR(SAFE_CAST(0 as STRING), 1, 10), auftraggeber_id) AS BIGNUMERIC), 0) AS
 auftraggeber_id,
  CASE
  WHEN fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN vk_netto_betrag * - 1
  ELSE vk_netto_betrag
  END AS vk_netto_betrag,
  CASE
  WHEN fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN vk_netto_rekl_tkl_betrag * - 1
  ELSE vk_netto_rekl_tkl_betrag
  END AS vk_netto_rekl_tkl_betrag
FROM kfl_production_dbp_view.v_besch_faktura_lgort_wg_wup_1 AS V_BESCH_FAKTURA_LGORT_WG_WUP_1
WHERE mandant_id = 1
 AND fakturaart_id IN (SELECT DISTINCT fakturaart_id
   FROM kfl_production_dbp_view.v_rpw_fakturaarten_1
   WHERE mandant_id = 1);