create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_IWT(
	MANDANT_ID,
	IWT_ID
) as
SELECT
 v01.mandant_id
,v01.iwt_id
FROM DBP_VIEW.v_l_iwt v01;