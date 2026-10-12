CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_SORT.MV_SUPERUSER
(
 mandant_id
,user_id
,superuser_fg
,teilsortiment_fg
)

AS
SELECT
 v01.mandant_id
,COALESCE (v02.user_id, v01.user_id)
,CASE WHEN wg_id = -999 THEN 1 ELSE 0 END AS superuser_fg
,CASE WHEN v02.user_id IS NOT NULL THEN 1 ELSE 0 END AS teilsortiment_fg

FROM DBP_SECURITY.SORTIMENT_USER_WG_ZU v01

LEFT JOIN
(SELECT
 DISTINCT user_id
,mandant_id
FROM dbp_security.user_zek_zu) v02
    
ON v01.user_Id = v02.user_id
AND v01.mandant_id = v02.mandant_id;