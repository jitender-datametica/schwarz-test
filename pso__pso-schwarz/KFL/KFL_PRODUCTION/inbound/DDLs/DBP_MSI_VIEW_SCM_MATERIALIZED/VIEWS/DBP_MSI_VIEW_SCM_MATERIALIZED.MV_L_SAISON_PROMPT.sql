create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_SAISON_PROMPT(
	SAISON_ID
) as
--2023-02-13,dknop, AP0162072, initial
   SELECT
   saison_id
   FROM dbp_view.v_l_saison
   GROUP BY saison_id;