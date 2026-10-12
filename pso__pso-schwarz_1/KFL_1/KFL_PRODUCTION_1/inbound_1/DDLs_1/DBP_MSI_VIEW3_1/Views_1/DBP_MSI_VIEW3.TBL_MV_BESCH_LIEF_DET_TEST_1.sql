create or replace view DBP_MSI_VIEW3.TBL_MV_BESCH_LIEF_DET_TEST_1(
	AKTIONS_POS_KZ,
	ANNAHMEVERWEIGERUNG_ID,
	ART_ID,
	BESCH_PALETTE_FG,
	BRUTTOGEW,
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
	LIEF_PAL_TYP_ID,
	BETRAG_LIEF_IST,
	BETRAG_LIEF_SOLL,
	UMRECHNUNGSKURS
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
, CASE
WHEN v01.dat_lief_soll < '2005-04-12'
THEN 0
ELSE v01.menge_lief_soll_kolli
END AS menge_lief_soll_kolli
, v01.menge_lief_palette
, v01.nb_id
, v01.system_id
, v01.verk_menge_einh_id
, CASE WHEN v01.best_beleg_id <> 0 THEN v01.best_beleg_id ELSE v01.vorlage_beleg_id END AS best_beleg_id
, v01.vorlage_beleg_pos_id AS best_beleg_pos_id
, v01.wup_id
, v01.dat_lief_soll
, CASE
WHEN v01.dat_lief_soll < '2005-04-12'
THEN 0
ELSE v01.menge_lief_soll_bme
END AS menge_lief_soll_bme
, v01.menge_lief_ist_kolli
, v01.menge_lief_ist_lme
, CASE
WHEN v01.dat_lief_soll < '2005-04-12'
THEN 0
ELSE (v01.menge_lief_soll_bme - v01.menge_lief_ist_bme)

END AS menge_lief_fehl_bme
, CASE
WHEN v01.dat_lief_soll < '2005-04-12'
THEN 0
ELSE (v01.menge_lief_soll_kolli - v01.menge_lief_ist_kolli)
END AS menge_lief_fehl_kolli
, v03.wrg_id
, v01.menge_kolli
, v03.wrg_typ_id
, CASE
WHEN v03.wrg_typ_id = 0
THEN (v01.vk_netto_lief_soll * v02.umrechnungskurs)
ELSE v01.vk_netto_lief_soll
END AS vk_netto_lief_soll
, CASE
WHEN v03.wrg_typ_id = 0
THEN (v01.vk_netto_lief_ist * v02.umrechnungskurs)
ELSE v01.vk_netto_lief_ist
END AS vk_netto_lief_ist
, CASE
WHEN v03.wrg_typ_id = 0
THEN ((v01.vk_netto_lief_soll - v01.vk_netto_lief_ist) * v02.umrechnungskurs)
ELSE (v01.vk_netto_lief_soll - v01.vk_netto_lief_ist)
END AS vk_netto_lief_fehl
, v01.dat_haltbarkeit - ((v05.mhd_zeitraum * v05.lager_prozent / 100 )+0.5) AS letzter_we_markt_lief
, v01.bestellart_id
, v01.kj
, v011.mandant_id_kunde
, CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END kunde_id
, 0 AS nb_id_kunde

,CASE WHEN try_to_number(v011.lief_pal_typ_id) <> 6 THEN v011.lief_pal_typ_id
--WHEN try_to_number(v011.lief_pal_typ_id) = 6 and v01.mandant_id = 1 and v01.lief_beleg_pos_id = 10 or v01.mandant_id <> 1 and v01.lief_beleg_pos_id = 1 THEN 61
--WHEN try_to_number(v011.lief_pal_typ_id) = 6 and v01.mandant_id = 1 and v01.lief_beleg_pos_id <> 10 or v01.mandant_id <> 1 and v01.lief_beleg_pos_id <> 1 THEN 64
END as lief_pal_typ_id,
v01.betrag_lief_ist,
v01.betrag_lief_soll,
v02.umrechnungskurs
FROM dbp_view.v_besch_lief_det_1 v01

JOIN dbp_view.v_besch_lief_1 v011
ON v01.mandant_id = v011.mandant_id
AND v01.lief_beleg_id = v011.lief_beleg_id
AND v01.kj = v011.kj
AND v01.dat_lief_soll = v011.dat_lief_soll

JOIN dbp_msi_view3.mv_kurs_1 v02
ON v01.wrg_id = v02.von_wrg_id

JOIN dbp_view.v_mandant_wrg_typ_zu_1 v03
ON v01.mandant_id = v03.mandant_id

JOIN dbp_view.v_art_1 v05
ON v01.art_id = v05.art_id
AND v01.mandant_id = v05.mandant_id
WHERE extract(year from v01.dat_lief_soll) >= year(current_timestamp) - 2;