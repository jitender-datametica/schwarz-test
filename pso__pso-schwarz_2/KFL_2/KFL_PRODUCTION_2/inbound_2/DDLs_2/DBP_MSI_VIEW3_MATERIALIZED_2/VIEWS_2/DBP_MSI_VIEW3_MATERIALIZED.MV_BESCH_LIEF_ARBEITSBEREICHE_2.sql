create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESCH_LIEF_ARBEITSBEREICHE_2(
	MANDANT_ID,
	LAGERORT_ID,
	WUP_ID,
	NB_ID,
	KUNDE_ID,
	WTAG_ID,
	DAT_LIEF_SOLL,
	WG_ID,
	ARTHIERTYP_ID,
	DISPONENT_ID,
	WG_VERKETT_ID,
	DISPOSITION_RHYTHMUS_LTF_ID,
	TERMINIERUNGSGRUPPE_1_ID,
	TERMINIERUNGSGRUPPE_2_ID,
	TERMINIERUNGSGRUPPE_3_ID,
	AUSLIEFERUNGSGRUPPE_ID,
	KUNDE_BEZ,
	DISPOSITION_RHYTHMUS_ID,
	DISPONENT_NAME,
	WUP_STANDORT,
	BESTELLART_ID,
	LIEF_PAL_TYP_ID,
	DIFF_ID,
	MENGE_LIEF_IST_KOLLI,
	MENGE_LIEF_SOLL_KOLLI,
	BETRAG_LIEF_IST,
	BETRAG_LIEF_SOLL,
	MENGE_LIEF_PALETTE,
	MANDANT_ID_KUNDE
) as
   SELECT
  v01.mandant_id
, v01.lagerort_id
, v01.wup_id
, v01.nb_id
, v01.kunde_id
, v01.wtag_id
, v01.dat_lief_soll
, v01.wg_id
, v01.arthiertyp_id
, v01.disponent_id
, v01.wg_verkett_id
, v01.disposition_rhythmus_ltf_id
, v01.terminierungsgruppe_1_id
, v01.terminierungsgruppe_2_id
, v01.terminierungsgruppe_3_id
, v01.auslieferungsgruppe_id
, v01.kunde_bez
, v01.disposition_rhythmus_id
, v01.disponent_name
, v01.wup_standort
, v01.bestellart_id
, Cast(v01.lief_pal_typ_id AS VARCHAR(2)) lief_pal_typ_id
, v01.diff_id
, (CASE WHEN v01.dat_lief_soll < '2005-04-12' THEN 0 ELSE v01.menge_lief_ist_kolli END) AS menge_lief_ist_kolli
, (CASE WHEN v01.dat_lief_soll < '2005-04-12' THEN 0 ELSE v01.menge_lief_soll_kolli END) AS menge_lief_soll_kolli
, (CASE WHEN v01.dat_lief_soll < '2005-04-12' THEN 0 ELSE v01.betrag_lief_ist END) AS betrag_lief_ist
, (CASE WHEN v01.dat_lief_soll < '2005-04-12' THEN 0 ELSE v01.betrag_lief_soll END) AS betrag_lief_soll
, (CASE WHEN v01.dat_lief_soll < '2005-04-12' THEN 0 ELSE v01.menge_lief_palette END) AS menge_lief_palette
, v01.mandant_id_kunde
   FROM dbp_view.v_besch_lief_arbeitsbereiche_2 v01
   WHERE extract(year from v01.dat_lief_soll) >= year(current_timestamp) - 2;