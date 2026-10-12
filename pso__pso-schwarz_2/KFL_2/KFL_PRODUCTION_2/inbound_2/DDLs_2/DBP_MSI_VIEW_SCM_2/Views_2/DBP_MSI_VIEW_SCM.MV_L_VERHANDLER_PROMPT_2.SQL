CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_VERHANDLER_PROMPT_2(
	VERHANDLER_ID,
	VERHANDLER_BEZ
) AS
--2023-02-13,dknop, AP0162072, initial
   SELECT DISTINCT
   v01.verhandler_id, CASE WHEN v01.verhandler_id = '' THEN 'leer/empty' ELSE v01.verhandler_id END AS verhandler_bez
   FROM dbp_view.v_art_2 v01
   WHERE v01.dat_bis='9999-12-31';