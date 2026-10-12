-- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
 -- 01.12.2025, nwag, LEER -> -2

-- 04.04.2022, AP0111566, SPEC0134176, dknop, changing to akt_msi_user_ek_anzeige_zu_log_1

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_besch_faktura_det_1(USERID STRING) AS SELECT V01.aktion_id,
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
 V01.vorlage_beleg_id_fak,
 V01.vorlage_beleg_pos_id_fak,
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
  CASE
  WHEN V01.fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS'
    , 'ZLUS')
  THEN V01.zwsum_5_betrag * - 1
  ELSE V01.zwsum_5_betrag
  END AS zwsum_5_betrag,
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
  WHEN V01.fakturaart_id IN ('ZIVS', 'S1', 'ZSLT', 'ZSMP', 'ZLG2', 'G2', 'ZGLT', 'ZGWP', 'ZEWP', 'ZLRE', 'ZLIG', 'ZLLS'
    , 'ZLUS')
  THEN V01.zwsum_9_betrag * - 1 * V03.ek_anzeige_fg
  ELSE V01.zwsum_9_betrag * V03.ek_anzeige_fg
  END AS zwsum_9_betrag,
  CASE
  WHEN V01.bestellart_id = ''
  THEN '-2'
  WHEN V01.bestellart_id IS NULL
  THEN '-1'
  ELSE V01.bestellart_id
  END AS bestellart_id,
 V01.menge_faktura_kg,
 V01.dat_preisfindung,
 V01.mwst,
 V01.vk_netto_betrag,
 V01.vk_netto_rekl_tkl_betrag,
 V01.kj
FROM kfl_production_dbp_msi_view_log.tbl_mv_besch_faktura_det_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_ek_anzeige_zu_log_1(USERID) AS V03 ON TRUE;