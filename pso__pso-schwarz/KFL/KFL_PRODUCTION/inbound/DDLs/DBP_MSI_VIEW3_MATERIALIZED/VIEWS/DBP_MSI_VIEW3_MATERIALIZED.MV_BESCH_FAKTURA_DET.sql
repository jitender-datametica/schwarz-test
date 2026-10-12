create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESCH_FAKTURA_DET(
	AKTION_ID,
	ART_ID,
	DAT_LEIST_ERSTELLUNG,
	FAKTURA_BELEG_ID,
	FAKTURA_BELEG_POS_ID,
	LAGERORT_ID,
	MANDANT_ID,
	MANDANT_ID_AUFTRAGGEBER,
	MENGE_FAKTURA_BME,
	MENGE_FAKTURA_KOLLI,
	MENGE_FAKTURA_PALETTE,
	NB_ID,
	VERK_MENGE_EINH_ID,
	VERRECHNUNG_BETRAG,
	VORLAGE_BELEG_ID_FAK,
	VORLAGE_BELEG_POS_ID_FAK,
	WUP_ID,
	ZWSUM_1_BETRAG,
	ZWSUM_2_BETRAG,
	ZWSUM_3_BETRAG,
	ZWSUM_4_BETRAG,
	ZWSUM_5_BETRAG,
	ZWSUM_6_BETRAG,
	DAT_FAKTURA,
	FAKTURAART_ID,
	AUFTRAG_GRUND_ID,
	ZWSUM_8_BETRAG,
	ZWSUM_9_BETRAG,
	BESTELLART_ID,
	MENGE_FAKTURA_KG,
	DAT_PREISFINDUNG,
	MWST,
	VK_NETTO_BETRAG,
	VK_NETTO_REKL_TKL_BETRAG,
	KJ
) as
SELECT
  v01.aktion_id
, v01.art_id
, v01.dat_leist_erstellung
, v01.faktura_beleg_id
, v01.faktura_beleg_pos_id
, v01.lagerort_id
, v01.mandant_id
, v01.mandant_id_auftraggeber
, menge_faktura_bme
, menge_faktura_kolli
, menge_faktura_palette
, v01.nb_id
, v01.verk_menge_einh_id
, CASE
  WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.verrechnung_betrag * -1 * v03.ek_anzeige_fg)
  ELSE v01.verrechnung_betrag * v03.ek_anzeige_fg
  END AS verrechnung_betrag
, v01.vorlage_beleg_id AS vorlage_beleg_id_fak
, v01.vorlage_beleg_pos_id AS vorlage_beleg_pos_id_fak
, v01.wup_id
, CASE
  WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.zwsum_1_betrag * -1 * v03.ek_anzeige_fg)
  ELSE (v01.zwsum_1_betrag * v03.ek_anzeige_fg)
  END AS zwsum_1_betrag
, zwsum_2_betrag
, CASE
  WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.zwsum_3_betrag * -1 * v03.ek_anzeige_fg)
  ELSE (v01.zwsum_3_betrag * v03.ek_anzeige_fg)
  END AS zwsum_3_betrag
, CASE
  WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.zwsum_4_betrag * -1 * v03.ek_anzeige_fg)
  ELSE (v01.zwsum_4_betrag * v03.ek_anzeige_fg)
  END AS zwsum_4_betrag
, zwsum_5_betrag
, CASE
  WHEN v01.fakturaart_id IN ('ZIVS','S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.zwsum_6_betrag * -1 * v03.ek_anzeige_fg)
  ELSE (v01.zwsum_6_betrag * v03.ek_anzeige_fg)
  END AS zwsum_6_betrag
, v01.dat_faktura
, v01.fakturaart_id
, auftrag_grund_id
, zwsum_8_betrag
, CASE
  WHEN v01.fakturaart_id IN ('S1','ZSLT','ZSMP','ZLG2','G2','ZGLT','ZGWP','ZEWP','ZLRE','ZLIG','ZLLS','ZLUS')
  THEN (v01.zwsum_9_betrag * -1 * v03.ek_anzeige_fg)
  ELSE (v01.zwsum_9_betrag * v03.ek_anzeige_fg)
  END AS zwsum_9_betrag
, v01.bestellart_id
, v01.menge_faktura_kg
, dat_preisfindung
, v01.mwst
, vk_netto_betrag
, vk_netto_rekl_tkl_betrag
, v01.kj

FROM DBP_MSI_VIEW3_MATERIALIZED.TBL_mv_besch_faktura_det v01
CROSS JOIN dbp_msi.akt_msi_user_ek_anzeige_zu v03;