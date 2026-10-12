CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_LAGERORT_PROMPT_2(
	LAGERORT_ID
) AS

   SELECT
  lagerort_id
  FROM dbp_view.v_l_lagerort_2
  WHERE lagerort_id NOT IN ('-1', '-2', '-3')
  GROUP BY
   lagerort_id
  ;