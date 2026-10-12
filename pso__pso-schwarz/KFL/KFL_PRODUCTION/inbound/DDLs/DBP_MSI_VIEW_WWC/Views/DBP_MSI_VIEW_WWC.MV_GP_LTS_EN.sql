CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_GP_LTS_EN(
	MANDANT_ID,
	GP_ID,
	GP_NAME,
	GP_TEILSORTIMENT_ID,
	GP_TEILSORTIMENT_BEZ,
	ZEK_ID,
	ZAHLUNGSZIEL_ID
) AS
SELECT
v01.mandant_id,
v01.gp_id,
v03.gp_name_lat AS gp_name,
v01.gp_teilsortiment_id,
COALESCE(MAX(CASE
WHEN v02.spr_id  IN (22,24)  THEN v02.gp_teilsortiment_bez END), 'N/A') AS gp_teilsortiment_bez,                                             
v01.zek_id,
v01.zahlungsziel_id

FROM dbp_view.v_l_gp_teilsortiment v01

JOIN dbp_view.v_gp_teilsortiment_spr_zu v02
ON v01.mandant_id = v02.mandant_id
AND v01.gp_id = v02.gp_id
AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id

JOIN dbp_view.v_gp v03
ON v01.mandant_id = v03.mandant_id
AND v01.gp_id = v03.gp_id

WHERE v01.gp_id <> -1
GROUP BY
  v01.mandant_id
, v01.gp_id
, v03.gp_name_lat
, v01.gp_teilsortiment_id
, v01.zek_id
, v01.zahlungsziel_id

UNION ALL
SELECT
v01.mandant_id,
v03.gp_id,
v03.gp_name_lat AS gp_name,
v01.gp_teilsortiment_id,
COALESCE(MAX(CASE
WHEN v02.spr_id  IN (22,24)  THEN v02.gp_teilsortiment_bez END), 'N/A') AS gp_teilsortiment_bez,                                      v01.zek_id,
v01.zahlungsziel_id
FROM dbp_view.v_l_gp_teilsortiment v01

JOIN dbp_view.v_gp_teilsortiment_spr_zu v02
ON v01.mandant_id = v02.mandant_id
AND v01.gp_id = v02.gp_id
AND v01.gp_teilsortiment_id = v02.gp_teilsortiment_id

JOIN dbp_view.v_gp v03
ON v01.mandant_id = v03.mandant_id

WHERE v01.gp_id = -1
GROUP BY
  v01.mandant_id
, v03.gp_id
, v03.gp_name_lat
, v01.gp_teilsortiment_id
, v01.zek_id
, v01.zahlungsziel_id;