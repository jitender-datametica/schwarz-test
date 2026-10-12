CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ARTKZ_EIGENMARKE_PROMPT_2(
	EIGENMARKE_ID
) AS
--2023-02-13,dknop, AP0162072, initial
   SELECT
   v01.eigenmarke_id
   FROM dbp_view.v_artkz_eigenmarke_2 v01
   GROUP BY v01.eigenmarke_id ;