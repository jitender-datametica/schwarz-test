create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_IN_AUFTRAG_PPS_1(
	AUFTRAG_ID,
	MANDANT_ID,
	DAT_START,
	AUFTRAG_RM_ID,
	AUFTRAG_RM_POS_ID,
	DAT_PLANAUFLOESUNG
) as
   SELECT
   v01.auftrag_id, v01.mandant_id, v01.dat_start, v01.auftrag_rm_id, v01.auftrag_rm_pos_id, v01.dat_planaufloesung
   FROM dbp_view.v_in_auftrag_pps_1 v01;