CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_EINH_2(
	EINH_ID,
	MANDANT_ID
) AS 
--2024-04-22, AP0179753, dknop, initial
SELECT
einh_id
,mandant_id
FROM dbp_view.v_l_einh_2

UNION ALL

SELECT DISTINCT
' ' AS einh_id
,mandant_id
FROM dbp_view.v_l_einh_2
;