CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_INFO_GP_LTS_2(
	mandant_id,
	gp_id,
	gp_name,
	gp_teilsortiment_id,
	gp_teilsortiment_bez,
	zek_id
) 
AS
SELECT
v01.mandant_id,
v01.gp_id,
v03.gp_name_lat AS gp_name,
v01.gp_teilsortiment_id,
v02.gp_teilsortiment_bez,
v01.zek_id

FROM dbp_view.v_l_gp_teilsortiment_2 v01

JOIN dbp_view.v_gp_teilsortiment_spr_zu_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.gp_id = v02.gp_id
AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id

JOIN dbp_view.v_gp_2 v03
ON v01.mandant_id = v03.mandant_id
AND v01.gp_id = v03.gp_id

WHERE v01.gp_id <> -1
AND v01.mandant_id = 1
AND v02.spr_id = 22

UNION ALL

SELECT
v01.mandant_id,
v03.gp_id,
v03.gp_name_lat AS gp_name,
v01.gp_teilsortiment_id,
v02.gp_teilsortiment_bez,
v01.zek_id
FROM dbp_view.v_l_gp_teilsortiment_2 v01

JOIN dbp_view.v_gp_teilsortiment_spr_zu_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.gp_id = v02.gp_id
AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id

JOIN dbp_view.v_gp_2 v03
ON v01.mandant_id = v03.mandant_id

WHERE v01.gp_id = -1
AND v01.mandant_id = 1
AND v02.spr_id = 22;