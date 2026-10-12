create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_BESCH_BESTAETIGUNG_1(
	BEST_BELEG_ID,
	EXT_BELEG_ID,
	BEST_BELEG_POS_ID,
	BESTAETIGUNG_LFD_NR,
	BESTAETIGUNG_TYP_ID,
	DAT_BESTAETIGUNG,
	DAT_LIEF_PLAN,
	LIEF_BELEG_ID,
	LIEF_BELEG_POS_ID,
	MANDANT_ID,
	MENGE_BESTAETIGUNG,
	MENGE_DISPO,
	ZEIT_BESTAETIGUNG,
	ZEIT_LIEF_PLAN,
	KJ_LIEF_BELEG
) as
   SELECT
   best_beleg_id, ext_beleg_id, best_beleg_pos_id, bestaetigung_lfd_nr, bestaetigung_typ_id, dat_bestaetigung, dat_lief_plan, lief_beleg_id, lief_beleg_pos_id, mandant_id, menge_bestaetigung, menge_dispo, zeit_bestaetigung, zeit_lief_plan, kj_lief_beleg
   FROM dbp_view.v_besch_bestaetigung_1
   WHERE extract(year from dat_bestaetigung) >= year(current_timestamp) - 2;