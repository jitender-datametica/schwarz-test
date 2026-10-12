create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_LIEF_EINTEILUNG(
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	DAT_LIEF_BEWERTUNG,
	DAT_LIEF_WUNSCH,
	EINTEIL_ID,
	MAHNUNG_ANZ,
	MANDANT_ID,
	MENGE_EINTEIL
) as
   SELECT best_beleg_id, best_beleg_pos_id, dat_lief_bewertung, dat_lief_wunsch, einteil_id, mahnung_anz, mandant_id, menge_einteil FROM dbp_view.v_lief_einteilung;