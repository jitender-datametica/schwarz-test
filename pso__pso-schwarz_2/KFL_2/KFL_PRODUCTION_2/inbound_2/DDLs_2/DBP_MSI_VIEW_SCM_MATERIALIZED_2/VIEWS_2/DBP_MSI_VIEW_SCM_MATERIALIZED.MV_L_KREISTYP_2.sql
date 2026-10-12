create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_KREISTYP_2(
	MANDANT_ID,
	KREISTYP_ID,
	VZ_PRIO_ID
) as
SELECT
 v01.mandant_id
,v01.kreistyp_id
,v01.vz_prio_id
FROM DBP_VIEW.v_l_kreistyp_2 v01

UNION ALL

SELECT 
 v02.mandant_id
,v02.kreistyp_id
,v02.vz_prio_id
FROM (SELECT 1 AS mandant_id
            ,'' AS kreistyp_id
            ,0 AS vz_prio_id
     ) v02;