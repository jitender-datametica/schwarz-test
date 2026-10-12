CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_spanne_wb_bfd_1 (dat, beleg_wb_id, beleg_wb_pos_id, mandant_id,
system_id, abs_id, rcv_id, art_id, bew_art_wb_id, vk_brutto, ek_netto, mwst, mwst_id, spanne_wb_herkunft_id, menge,
belastungsart_id, belastungsart_vd_id) AS SELECT CASE
  WHEN LK.fakturaart_id IN ('ZVLT', 'ZMWP', 'ZGLT', 'ZGWP', 'ZSLT', 'ZSMP', 'Z5LT', 'Z5MP', 'ZEWP', 'ZSWP')
  THEN LB.dat_leist_erstellung
  ELSE LB.dat_faktura
  END AS dat,
 LB.faktura_beleg_id AS beleg_wb_id,
 LB.faktura_beleg_pos_id AS beleg_wb_pos_id,
 LB.mandant_id,
 7 AS system_id,
 LB.wup_id AS abs_id,
 ROUND(CAST(CASE
    WHEN LK.auftraggeber_id = ''
    THEN '0'
    ELSE LK.auftraggeber_id
    END AS BIGNUMERIC), 0) AS rcv_id,
 LB.art_id,
 LK.fakturaart_id AS bew_art_wb_id,
  CASE
  WHEN LK.fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN LB.zwsum_2_betrag + LB.zwsum_5_betrag + LB.zwsum_8_betrag
  ELSE (LB.zwsum_2_betrag + LB.zwsum_5_betrag + LB.zwsum_8_betrag) * - 1
  END AS vk_brutto,
  CASE
  WHEN LK.fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN LB.zwsum_3_betrag
  ELSE LB.zwsum_3_betrag * - 1
  END AS ek_netto,
 MP.mwst,
 MP.mwst_id,
 3 AS spanne_wb_herkunft_id,
  CASE
  WHEN LK.fakturaart_id IN ('L2', 'ZVLT', 'ZMWP', 'S2', 'Z5LT', 'Z5MP', 'ZSWP', 'ZGEP', 'ZF1', 'ZIV', 'ZLF2', 'ZLL2',
    'ZLRS', 'ZLS2', 'ZLUL')
  THEN LB.menge_faktura_bme
  ELSE LB.menge_faktura_bme * - 1
  END AS menge,
 LK.fakturaart_id AS belastungsart_id,
 1 AS belastungsart_vd_id
FROM kfl_production_dbp_view.v_besch_faktura_det_1 AS LB
 INNER JOIN kfl_production_dbp_view.v_besch_faktura_1 AS LK ON LB.mandant_id = LK.mandant_id AND LB.faktura_beleg_id = LK
   .faktura_beleg_id
 INNER JOIN kfl_production_dbp_view.v_art_1 AS A ON LB.art_id = A.art_id AND LB.mandant_id = A.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mwst_per_1 AS MP ON A.mwst_id = MP.mwst_id AND A.mandant_id = MP.mandant_id AND LK.dat_faktura
   BETWEEN MP.dat_von AND MP.dat_bis
 INNER JOIN (SELECT DISTINCT mandant_id,
   fakturaart_id
  FROM kfl_production_dbp_view.v_rpw_fakturaarten_1) AS lkf ON LK.mandant_id = lkf.mandant_id AND LK.fakturaart_id = lkf.fakturaart_id
   
WHERE LB.mandant_id = 1;