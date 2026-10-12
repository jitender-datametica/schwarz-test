CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_DIFF_SPR_ZU_2(
	MANDANT_ID,
	DIFF_ID,
	SPR_ID,
	DIFF_BEZ
) AS
--2024-03-28, dknop, AP0179753, initial
   SELECT
   v01.mandant_id, v01.diff_id, v01.spr_id, v01.diff_bez

   FROM dbp_view.v_diff_spr_zu_2 v01
   WHERE v01.mandant_id =1;