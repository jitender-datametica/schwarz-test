create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_DIFF(
	MANDANT_ID,
	DIFF_ID
) as
   SELECT
   mandant_id, diff_id
   FROM dbp_view.v_l_kz_differenz
   WHERE mandant_id = 1;