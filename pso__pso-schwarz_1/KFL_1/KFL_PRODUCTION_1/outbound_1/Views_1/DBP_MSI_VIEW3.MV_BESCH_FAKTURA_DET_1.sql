-- G2 ZGLT,ZGWP,ZEWP
 -- S1 ZSLT,ZSMP
 -- S2 Z5LT,Z5MP,ZSWP,ZGEP
 -- 2020-05-15  coalesce() auftrag_grund_id (nw)

-- 15.11.2021, INC3728478, dknop, remove ZIVS from the list for zwsum8+9

-- 12.09.2016, srom0404, AP0002697, SPEC0014073 Fakturaarten erweitern
 -- L2 ZVLT,ZMWP
 -- alt neu

-- 21.01.2010, baranowska, SPEC0066698, adding CROSS JOIN with v04

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_besch_faktura_det_1 (aktion_id, art_id, dat_leist_erstellung,
faktura_beleg_id, faktura_beleg_pos_id, lagerort_id, mandant_id, mandant_id_auftraggeber, menge_faktura_bme,
menge_faktura_kolli, menge_faktura_palette, nb_id, verk_menge_einh_id, verrechnung_betrag, vorlage_beleg_id_fak,
vorlage_beleg_pos_id_fak, wup_id, zwsum_1_betrag, zwsum_2_betrag, zwsum_3_betrag, zwsum_4_betrag, zwsum_5_betrag,
zwsum_6_betrag, dat_faktura, fakturaart_id, auftrag_grund_id, zwsum_8_betrag, zwsum_9_betrag, bestellart_id,
menge_faktura_kg, dat_preisfindung, mwst, vk_netto_betrag, vk_netto_rekl_tkl_betrag, kj) AS SELECT V01.aktion_id,
 V01.art_id,
 V01.dat_leist_erstellung,
 V01.faktura_beleg_id,
 V01.faktura_beleg_pos_id,
 V01.lagerort_id,
 V01.mandant_id,
 V01.mandant_id_auftraggeber,
 V01.menge_faktura_bme,
 V01.menge_faktura_kolli,
 V01.menge_faktura_palette,
 V01.nb_id,
 V01.verk_menge_einh_id,
  CASE
  WHEN V01.fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS'
    , 'ZLUS')
  THEN V01.verrechnung_betrag * - 1 * V03.ek_anzeige_fg
  ELSE V01.verrechnung_betrag * V03.ek_anzeige_fg
  END AS verrechnung_betrag,
 V01.vorlage_beleg_id AS vorlage_beleg_id_fak,
 V01.vorlage_beleg_pos_id AS vorlage_beleg_pos_id_fak,
 V01.wup_id,
  CASE
  WHEN V01.fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS'
    , 'ZLUS')
  THEN V01.zwsum_1_betrag * - 1 * V03.ek_anzeige_fg
  ELSE V01.zwsum_1_betrag * V03.ek_anzeige_fg
  END AS zwsum_1_betrag,
 V01.zwsum_2_betrag,
  CASE
  WHEN V01.fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS'
    , 'ZLUS')
  THEN V01.zwsum_3_betrag * - 1 * V03.ek_anzeige_fg
  ELSE V01.zwsum_3_betrag * V03.ek_anzeige_fg
  END AS zwsum_3_betrag,
  CASE
  WHEN V01.fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS'
    , 'ZLUS')
  THEN V01.zwsum_4_betrag * - 1 * V03.ek_anzeige_fg
  ELSE V01.zwsum_4_betrag * V03.ek_anzeige_fg
  END AS zwsum_4_betrag,
 V01.zwsum_5_betrag,
  CASE
  WHEN V01.fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS'
    , 'ZLUS')
  THEN V01.zwsum_6_betrag * - 1 * V03.ek_anzeige_fg
  ELSE V01.zwsum_6_betrag * V03.ek_anzeige_fg
  END AS zwsum_6_betrag,
 V01.dat_faktura,
 V01.fakturaart_id,
 V01.auftrag_grund_id,
 V01.zwsum_8_betrag,
  CASE
  WHEN V01.fakturaart_id IN ('S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS', 'ZLUS'
    )
  THEN V01.zwsum_9_betrag * - 1 * V03.ek_anzeige_fg
  ELSE V01.zwsum_9_betrag * V03.ek_anzeige_fg
  END AS zwsum_9_betrag,
 V01.bestellart_id,
 V01.menge_faktura_kg,
 V01.dat_preisfindung,
 V01.mwst,
 V01.vk_netto_betrag,
 V01.vk_netto_rekl_tkl_betrag,
 V01.kj
FROM kfl_production_dbp_msi_view3.tbl_mv_besch_faktura_det_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_ek_anzeige_zu_1 AS V03 ON TRUE;