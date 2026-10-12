create or replace view DBP_MSI_VIEW3.MV_BESCH_LIEF_DET_TEST(
	AKTIONS_POS_KZ,
	ANNAHMEVERWEIGERUNG_ID,
	ART_ID,
	BESCH_PALETTE_FG,
	BRUTTO_GEW,
	DAT_AENDERUNG,
	DAT_HALTBARKEIT,
	DIFF_ID,
	LAGERORT_ID,
	LIEF_BELEG_ID,
	LIEF_BELEG_POS_ID,
	MANDANT_ID,
	MENGE_LIEF_IST_BME,
	MENGE_LIEF_SOLL_KOLLI,
	MENGE_LIEF_PALETTE,
	NB_ID,
	SYSTEM_ID,
	VERK_MENGE_EINH_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	WUP_ID,
	DAT_LIEF_SOLL,
	MENGE_LIEF_SOLL_BME,
	MENGE_LIEF_IST_KOLLI,
	MENGE_LIEF_IST_LME,
	BETRAG_LIEF_IST,
	BETRAG_LIEF_SOLL,
	BETRAG_LIEF_FEHL,
	MENGE_LIEF_FEHL_BME,
	MENGE_LIEF_FEHL_KOLLI,
	WRG_ID,
	MENGE_KOLLI,
	WRG_TYP_ID,
	VK_NETTO_LIEF_SOLL,
	VK_NETTO_LIEF_IST,
	VK_NETTO_LIEF_FEHL,
	LETZTER_WE_MARKT_LIEF,
	BESTELLART_ID,
	KJ,
	MANDANT_ID_KUNDE,
	KUNDE_ID,
	NB_ID_KUNDE,
	LIEF_PAL_TYP_ID
) as
SELECT
v01.aktions_pos_kz
, v01.annahmeverweigerung_id
, v01.art_id
, v01.besch_palette_fg
, v01.bruttogew
, v01.dat_aenderung
, v01.dat_haltbarkeit
, v01.diff_id
, v01.lagerort_id
, v01.lief_beleg_id
, v01.lief_beleg_pos_id
, v01.mandant_id
, v01.menge_lief_ist_bme
, menge_lief_soll_kolli
, v01.menge_lief_palette
, v01.nb_id
, v01.system_id
, v01.verk_menge_einh_id
, best_beleg_id
, best_beleg_pos_id
, v01.wup_id
, v01.dat_lief_soll
, menge_lief_soll_bme
, v01.menge_lief_ist_kolli
, v01.menge_lief_ist_lme
, CASE
WHEN v01.wrg_typ_id = 0
THEN (v01.betrag_lief_ist * v01.umrechnungskurs * v04.ek_anzeige_fg)
ELSE (v01.betrag_lief_ist * v04.ek_anzeige_fg)
END AS betrag_lief_ist
, CASE
WHEN v01.dat_lief_soll < '2005-04-12'
THEN 0
ELSE
CASE
WHEN v01.wrg_typ_id = 0
THEN (v01.betrag_lief_soll * v01.umrechnungskurs * v04.ek_anzeige_fg)
ELSE (v01.betrag_lief_soll * v04.ek_anzeige_fg)
END
END AS betrag_lief_soll
, CASE
WHEN v01.dat_lief_soll < '2005-04-12'
THEN 0
ELSE
CASE
WHEN v01.wrg_typ_id = 0
THEN ((v01.betrag_lief_soll - v01.betrag_lief_ist) * v01.umrechnungskurs * v04.ek_anzeige_fg)
ELSE ((v01.betrag_lief_soll - v01.betrag_lief_ist) * v04.ek_anzeige_fg)
END
END AS betrag_lief_fehl
, menge_lief_fehl_bme
, menge_lief_fehl_kolli
, wrg_id
, v01.menge_kolli
, v01.wrg_typ_id
, vk_netto_lief_soll
, vk_netto_lief_ist
, vk_netto_lief_fehl
, letzter_we_markt_lief
, v01.bestellart_id
, v01.kj
, v01.mandant_id_kunde
, kunde_id
, nb_id_kunde

,lief_pal_typ_id

FROM DBP_MSI_VIEW3.TBL_MV_BESCH_LIEF_DET_TEST v01

JOIN dbp_msi.akt_msi_user_wrg_typ_zu v06
ON v01.wrg_typ_id = v06.wrg_typ_id

CROSS JOIN dbp_msi.akt_msi_user_ek_anzeige_zu v04;