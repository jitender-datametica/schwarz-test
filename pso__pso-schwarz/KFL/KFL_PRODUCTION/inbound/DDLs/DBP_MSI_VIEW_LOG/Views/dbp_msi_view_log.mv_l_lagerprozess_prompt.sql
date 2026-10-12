CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_LAGERPROZESS_PROMPT(
	LAGERPROZESS_ID
) AS
--2023-05-08, AP0161535, dknop, initial
SELECT

v01.lagerprozess_id

FROM dbp_view.v_l_lagerprozess v01
GROUP BY v01.lagerprozess_id;