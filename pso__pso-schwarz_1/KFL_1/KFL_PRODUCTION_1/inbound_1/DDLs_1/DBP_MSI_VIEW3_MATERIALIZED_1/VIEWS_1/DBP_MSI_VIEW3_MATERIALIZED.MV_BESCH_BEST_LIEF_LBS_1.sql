
create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESCH_BEST_LIEF_LBS_1(
	MANDANT_ID,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	DAT_BUCH,
	ENDLIEF_FG,
	BEST_MENGE_ORIG_FG,
	ANNAHMEVERWEIGERUNG_ID,
	NB_ID,
	ART_ID,
	GP_ID,
	WUP_ID,
	LAGERORT_ID,
	BESTELLART_ID,
	DAT_BEST_BELEG,
	DAT_LIEF_WUNSCH,
	DAT_LIEF_BEWERTUNG,
	MENGE_LIEF,
	BETRAG_LAGERBEW_EK_N,
	BETRAG_BEST_EK_N,
	MENGE_BEST_BME,
	FEHLLIEFERUNG_KZ,
	MENGE_LAGERBEW_KOLLI,
	MENGE_BEST_KOLLI,
	BETRAG_FEHLMENGE_VK_BRUTTO,
	WRG_ID,
	WRG_TYP_ID,
	SPAET_LIEF_TAGE,
	PROZENT_AKZEPTANZ_UNTERLIEF
) as
-- 20220804; richternic, AP0132142, SPEC0154921, akt_msi_user_wrg_typ_zu_1 ersetzen durch neue View (Projektspezifische Waehrungsauswahl)

SELECT
v01.mandant_id
, v01.best_beleg_id
, v01.best_beleg_pos_id
, v01.dat_buch
, v01.endlief_fg
, v01.best_menge_orig_fg
, v01.annahmeverweigerung_id
, v01.nb_id
, v01.art_id
, v01.gp_id
, v01.wup_id
, v01.lagerort_id
, v01.bestellart_id
, v01.dat_best_beleg
, v01.dat_lief_wunsch
, v01.dat_lief_bewertung
, v01.menge_lief
, v01.betrag_lagerbew_ek_n
, v01.betrag_best_ek_n
, v01.menge_best_bme
, v01.fehllieferung_kz
, v01.menge_lief_ist_kolli AS menge_lagerbew_kolli
, v01.menge_lief_soll_kolli AS menge_best_kolli
, v01.betrag_fehlmenge_vk_brutto
, v04.wrg_id
, v04.wrg_typ_id
, v02.spaet_lief_tage
, v06.prozent_akzeptanz_unterlief

FROM dbp_view.v_besch_best_lief_lbs_1 v01
JOIN DBP_MSI_VIEW3_MATERIALIZED.mv_mandant_1 v02
ON v01.mandant_id = v02.mandant_id

JOIN DBP_MSI_VIEW3_MATERIALIZED.mv_kurs_1 v03
ON v01.wrg_id=v03.von_wrg_id

JOIN dbp_view.v_mandant_wrg_typ_zu_1 v04
ON v01.mandant_id=v04.mandant_id

JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1 v07
ON v04.wrg_typ_id = v07.wrg_typ_id

CROSS JOIN dbp_msi.akt_msi_user_ek_anzeige_zu_1 v05

JOIN dbp_view.v_ek_infosatz_wup_zu_1 v06
ON v01.mandant_id = v06.mandant_id
AND v01.wup_id = v06.wup_id;