create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_AOF_PROGNOSE_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	ZEITREIHENART,
	DAT_PROGNOSELAUF,
	DAT,
	MENGE_PROGNOSE
) as
   SELECT
   v01.mandant_id, v01.wup_id, v01.nb_id, v01.art_id, v01.zeitreihenart, v01.dat_prognoselauf, v01.dat, v01.menge as menge_prognose
   FROM dbp_view.v_aof_prognose_2 v01;