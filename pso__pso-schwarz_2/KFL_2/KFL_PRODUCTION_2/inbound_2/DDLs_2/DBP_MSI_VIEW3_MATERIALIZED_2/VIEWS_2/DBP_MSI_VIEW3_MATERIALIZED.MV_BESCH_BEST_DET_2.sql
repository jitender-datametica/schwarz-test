create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESCH_BEST_DET_2(
	ART_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	BEST_PREIS_MENGE_EINH_ID,
	BEST_BASISMENGE_EINH_ID,
	DAT_AENDERUNG,
	DAT_BEST_BELEG,
	ENDLIEF_FG,
	LAGERORT_ID,
	LOESCH_FG,
	MANDANT_ID,
	MENGE_BEST_BME,
	MENGE_BEST_KOLLI,
	MENGE_BEST_PALETTE,
	NB_ID,
	SELBSTABHOL_FG,
	WUP_ID,
	FILIALE_ID,
	KUNDE_ID,
	BESTELLART_ID,
	GP_ID,
	LIEFERNDESWERK,
	LIEFERNDESWERK_NB_ID,
	BETRAG_BEST,
	WRG_ID,
	WRG_TYP_ID,
	MENGE_BLOCK_BESTAND,
	GP_TEILSORTIMENT_ID
) as
SELECT
v01.art_id
, v01.best_beleg_id
, v01.best_beleg_pos_id
, v01.best_preis_menge_einh_id
, v01.best_menge_einh_id
, v01.dat_aenderung
, v01.dat_best_beleg
, v01.endlief_fg
, v01.lagerort_id
, v01.loesch_fg
, v01.mandant_id
, v01.menge_best_bme
, v01.menge_best_kolli
, v01.menge_best_palette
, v01.nb_id
, v01.selbstabhol_fg
, wup_id
, filiale_id
, kunde_id
, v01.bestellart_id
, v01.gp_id
, v01.lieferndeswerk
, v01.lieferndeswerk_nb_id
, CASE
WHEN v01.wrg_typ_id = 0
THEN (v01.betrag_best * v01.umrechnungskurs * v05.ek_anzeige_fg)
ELSE (v01.betrag_best * v05.ek_anzeige_fg)
END AS betrag_best
, v01.wrg_id
, v01.wrg_typ_id
, v01.menge_block_bestand
, v01.gp_teilsortiment_id

FROM DBP_MSI_VIEW3_MATERIALIZED.tbl_mv_besch_best_det_2 v01

JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 v06
ON v01.wrg_typ_id = v06.wrg_typ_id

CROSS JOIN dbp_msi.akt_msi_user_ek_anzeige_zu_2 v05;