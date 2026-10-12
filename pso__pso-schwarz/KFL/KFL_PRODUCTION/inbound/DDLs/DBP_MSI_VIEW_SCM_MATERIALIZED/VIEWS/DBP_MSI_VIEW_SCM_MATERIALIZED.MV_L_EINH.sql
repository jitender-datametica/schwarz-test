create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_EINH(
	EINH_ID,
	MANDANT_ID
) as 
--2024-04-22, AP0179753, dknop, initial
SELECT
einh_id
,mandant_id
FROM dbp_view.v_l_einh

UNION ALL

SELECT DISTINCT
' ' AS einh_id
,mandant_id
FROM dbp_view.v_l_einh;