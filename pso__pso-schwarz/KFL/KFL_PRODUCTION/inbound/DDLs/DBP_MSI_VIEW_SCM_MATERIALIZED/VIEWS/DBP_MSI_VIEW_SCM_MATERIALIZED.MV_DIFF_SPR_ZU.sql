create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_DIFF_SPR_ZU(
	MANDANT_ID,
	DIFF_ID,
	SPR_ID,
	DIFF_BEZ
) as
--2024-03-28, dknop, AP0179753, initial
   SELECT
   v01.mandant_id, v01.diff_id, v01.spr_id, v01.diff_bez

   FROM dbp_view.v_diff_spr_zu v01
   WHERE v01.mandant_id =1;