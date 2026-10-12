create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESCH_BEST_2(
	BEST_BELEG_ID,
	BESTELLART_ID,
	DAT_AENDERUNG,
	DAT_BEST_BELEG,
	EINKAUFSORGANISATION_ID,
	GP_ID,
	LOESCH_FG,
	MANDANT_ID,
	NACHBEST_FG,
	KUNDE_ID,
	WUP_ID,
	NB_ID,
	ANZ_POS_AKTIV,
	EMPFAENGER_WUP_ID
) as
   SELECT
   best_beleg_id,
   bestellart_id,
   dat_aenderung,
   dat_best_beleg,
   einkaufsorganisation_id,
   gp_id,
   loesch_fg,
   mandant_id,
   nachbest_fg,
   CASE WHEN CAST(SUBSTR(kunde_id,7,4) AS INTEGER) IS NULL THEN 0 ELSE CAST(SUBSTR(kunde_id,7,4) AS INTEGER) END AS kunde_id,
   wup_id,
   nb_id,
   anz_pos_aktiv,
   empfaenger_wup_id
   FROM dbp_view.v_besch_best_2
   where einkaufsorganisation_id <> 5000 AND loesch_fg = 0;