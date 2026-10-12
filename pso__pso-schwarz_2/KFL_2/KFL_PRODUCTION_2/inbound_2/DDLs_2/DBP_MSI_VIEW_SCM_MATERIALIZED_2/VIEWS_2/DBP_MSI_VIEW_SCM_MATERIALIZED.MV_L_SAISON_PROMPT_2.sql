create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_SAISON_PROMPT_2(
	SAISON_ID
) as
--2023-02-13,dknop, AP0162072, initial
   SELECT
   saison_id
   FROM dbp_view.v_l_saison_2
   GROUP BY saison_id;