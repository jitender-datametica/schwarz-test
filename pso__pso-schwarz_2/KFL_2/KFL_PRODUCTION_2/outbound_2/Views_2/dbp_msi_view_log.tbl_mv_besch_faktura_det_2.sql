CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.tbl_mv_besch_faktura_det_2 (aktion_id, art_id, dat_leist_erstellung
, faktura_beleg_id, faktura_beleg_pos_id, lagerort_id, mandant_id, mandant_id_auftraggeber, menge_faktura_bme,
menge_faktura_kolli, menge_faktura_palette, nb_id, verk_menge_einh_id, vorlage_beleg_id_fak, vorlage_beleg_pos_id_fak,
wup_id, zwsum_2_betrag, dat_faktura, fakturaart_id, auftrag_grund_id, zwsum_8_betrag, bestellart_id, menge_faktura_kg,
dat_preisfindung, mwst, vk_netto_betrag, vk_netto_rekl_tkl_betrag, kj, verrechnung_betrag, zwsum_1_betrag,
zwsum_3_betrag, zwsum_4_betrag, zwsum_5_betrag, zwsum_6_betrag, zwsum_9_betrag) AS SELECT V01.aktion_id,
 V01.art_id,
 V01.dat_leist_erstellung,
 V01.faktura_beleg_id,
 V01.faktura_beleg_pos_id,
 V01.lagerort_id,
 V01.mandant_id,
 V02.mandant_id_auftraggeber,
  CASE
  WHEN V02.fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS'
    , 'ZLUS')
  THEN V01.menge_faktura_bme * - 1
  ELSE V01.menge_faktura_bme
  END AS menge_faktura_bme,
  CASE
  WHEN V02.fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS'
    , 'ZLUS')
  THEN V01.menge_faktura_kolli * - 1
  ELSE V01.menge_faktura_kolli
  END AS menge_faktura_kolli,
  CASE
  WHEN V02.fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS'
    , 'ZLUS')
  THEN V01.menge_faktura_palette * - 1
  ELSE V01.menge_faktura_palette
  END AS menge_faktura_palette,
 V01.nb_id,
 V01.verk_menge_einh_id,
 V01.vorlage_beleg_id AS vorlage_beleg_id_fak,
 V01.vorlage_beleg_pos_id AS vorlage_beleg_pos_id_fak,
 V01.wup_id,
  CASE
  WHEN V02.fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS'
    , 'ZLUS')
  THEN V01.zwsum_2_betrag * - 1
  ELSE V01.zwsum_2_betrag
  END AS zwsum_2_betrag,
 V01.dat_faktura,
 V02.fakturaart_id,
 COALESCE(V01.auftrag_grund_id, '') AS auftrag_grund_id,
  CASE
  WHEN V02.fakturaart_id IN ('S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS', 'ZLUS'
    )
  THEN V01.zwsum_8_betrag * - 1
  ELSE V01.zwsum_8_betrag
  END AS zwsum_8_betrag,
 COALESCE(V01.bestellart_id, '-2') AS bestellart_id,
 V01.menge_faktura_kg,
 V01.dat_preisfindung,
 V01.mwst,
  CASE
  WHEN V02.fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS'
    , 'ZLUS')
  THEN V01.zwsum_2_betrag / CAST((V01.mwst / 100) + 1 AS FLOAT64) * - 1
  ELSE V01.zwsum_2_betrag / CAST((V01.mwst / 100) + 1 AS FLOAT64)
  END AS vk_netto_betrag,
  CASE
  WHEN V02.fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS'
    , 'ZLUS')
  THEN (V01.zwsum_2_betrag + V01.zwsum_5_betrag + V01.zwsum_8_betrag) / CAST((V01.mwst / 100) + 1 AS FLOAT64) * - 1
  ELSE (V01.zwsum_2_betrag + V01.zwsum_5_betrag + V01.zwsum_8_betrag) / CAST((V01.mwst / 100) + 1 AS FLOAT64)
  END AS vk_netto_rekl_tkl_betrag,
 V04.kj,
 V01.verrechnung_betrag,
 V01.zwsum_1_betrag,
 V01.zwsum_3_betrag,
 V01.zwsum_4_betrag,
 V01.zwsum_5_betrag,
 V01.zwsum_6_betrag,
 V01.zwsum_9_betrag
FROM kfl_production_dbp_view.v_besch_faktura_det_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_besch_faktura_2 AS V02 ON V01.faktura_beleg_id = V02.faktura_beleg_id AND V01.mandant_id
     = V02.mandant_id AND V01.dat_faktura = V02.dat_faktura
 LEFT JOIN kfl_production_dbp_view.v_besch_lief_2 AS V04 ON V01.vorlage_beleg_id = V04.lief_beleg_id AND V01.mandant_id =
    V04.mandant_id AND EXTRACT(YEAR FROM V01.dat_faktura) BETWEEN V04.kj - 1 AND (V04.kj + 1);