create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESCH_LIEF_WUP_SUM_PALSPLIT_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	LAGERORT_ID,
	DAT_LIEF_SOLL,
	LIEF_TYP_ID,
	KUNDE_ID,
	LIEF_PAL_TYP_ID,
	MENGE_LIEF_IST_KOLLI,
	ANZAHL_POSITION,
	ANZAHL_PACKSTUECK
) as
   SELECT
  v01.mandant_id, v01.wup_id, v01.nb_id, v01.lagerort_id, v01.dat_lief_soll, v01.lief_typ_id, CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END kunde_id, v01.lief_pal_typ_id, v01.menge_lief_ist_kolli, v01.anzahl_position, v01.anzahl_packstueck
   

   FROM
   dbp_view.v_besch_lief_wup_sum_2 v01;