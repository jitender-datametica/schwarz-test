create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_LAGERORT_PROMPT(
	LAGERORT_ID
) as

   SELECT
  lagerort_id
  FROM dbp_view.v_l_lagerort
  WHERE lagerort_id NOT IN ('-1', '-2', '-3')
  GROUP BY
   lagerort_id;