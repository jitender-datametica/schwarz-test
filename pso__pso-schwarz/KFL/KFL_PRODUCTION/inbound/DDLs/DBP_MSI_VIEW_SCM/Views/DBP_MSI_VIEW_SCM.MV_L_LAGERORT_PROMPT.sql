CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_LAGERORT_PROMPT(
	LAGERORT_ID
) AS

   SELECT
  lagerort_id
  FROM dbp_view.v_l_lagerort
  WHERE lagerort_id NOT IN ('-1', '-2', '-3')
  GROUP BY
   lagerort_id
  ;