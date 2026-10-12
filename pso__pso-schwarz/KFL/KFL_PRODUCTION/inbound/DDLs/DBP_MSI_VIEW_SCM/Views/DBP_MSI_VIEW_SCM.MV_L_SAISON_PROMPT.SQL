CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_SAISON_PROMPT(
	SAISON_ID
) AS
--2023-02-13,dknop, AP0162072, initial
   SELECT
   saison_id
   FROM dbp_view.v_l_saison
   GROUP BY saison_id;