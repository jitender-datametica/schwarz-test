create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_HANDLING_UNIT_DET(
	MANDANT_ID,
	SYSTEM_ID,
	NB_ID,
	HANDLING_UNIT_POS_ID,
	WUP_ID,
	HANDLING_UNIT_ID,
	HU_TYP_ID,
	ANZ_PACK_HILFSMITTEL,
	DE_EGALISIERT_FG,
	VERP_MENGE_EINH_ID,
	ART_ID,
	LAGERORT_ID,
	LIEF_BELEG_ID,
	LIEF_BELEG_POS_ID,
	MENGE_HANDLING_KOLLI,
	KJ_LIEF_BELEG
) as
   SELECT
  mandant_id, system_id, nb_id, handling_unit_pos_id, wup_id, handling_unit_id, hu_typ_id, anz_pack_hilfsmittel, de_egalisiert_fg, verp_menge_einh_id, art_id, lagerort_id, lief_beleg_id, lief_beleg_pos_id, menge_handling_kolli, kj_lief_beleg

   FROM dbp_view.v_handling_unit_det
   WHERE kj_lief_beleg = -1 OR kj_lief_beleg >= year(current_timestamp) - 2;