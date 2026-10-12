create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_DISPONENT_WUP_ZU_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DISPONENT_ID,
	DISPONENT_NAME
) as
   SELECT
  mandant_id, wup_id, nb_id, disponent_id, disponent_name

   FROM dbp_view.v_disponent_wup_zu_1;