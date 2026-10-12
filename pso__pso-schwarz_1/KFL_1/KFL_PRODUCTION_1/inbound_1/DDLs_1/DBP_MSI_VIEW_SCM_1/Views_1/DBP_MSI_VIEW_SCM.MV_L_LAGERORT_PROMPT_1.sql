CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_LAGERORT_PROMPT_1(
	LAGERORT_ID
) AS

   SELECT
  lagerort_id
  FROM dbp_view.v_l_lagerort_1
  WHERE lagerort_id NOT IN ('-1', '-2', '-3')
  GROUP BY
   lagerort_id
  ;