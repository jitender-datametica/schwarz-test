create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_L_DISPOSITION_RHYTHMUS_1(
	DISPOSITION_RHYTHMUS_ID,
	MANDANT_ID,
	NB_ID,
	SYSTEM_ID,
	WUP_ID
) as
   SELECT
   disposition_rhythmus_id, mandant_id, nb_id, system_id, wup_id
   FROM dbp_view.v_l_disposition_rhythmus_1;