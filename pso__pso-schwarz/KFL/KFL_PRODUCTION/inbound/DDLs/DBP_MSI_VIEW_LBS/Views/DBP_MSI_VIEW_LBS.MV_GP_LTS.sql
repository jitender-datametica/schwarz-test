CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_GP_LTS(
	MANDANT_ID,
	GP_ID,
	GP_NAME,
	GP_NAME_DE,
	GP_NAME_CZ,
	GP_NAME_PL,
	GP_NAME_MD,
	GP_NAME_SK,
	GP_NAME_HR,
	GP_NAME_RO,
	GP_NAME_BG,
	GP_TEILSORTIMENT_ID,
	GP_TEILSORTIMENT_BEZ,
	GP_TEILSORTIMENT_BEZ_DE,
	GP_TEILSORTIMENT_BEZ_CZ,
	GP_TEILSORTIMENT_BEZ_SK,
	GP_TEILSORTIMENT_BEZ_HR,
	GP_TEILSORTIMENT_BEZ_PL,
	GP_TEILSORTIMENT_BEZ_RO,
	GP_TEILSORTIMENT_BEZ_BG,
	ZEK_ID,
	ZAHLUNGSZIEL_ID
) AS
SELECT
v01.mandant_id,
v01.gp_id,
v03.gp_name_lat AS gp_name,
v03.gp_name_lat AS gp_name_de -- DE
,
v03.gp_name_lat AS gp_name_cz  -- CZ
,
v03.gp_name_lat AS gp_name_pl -- PL
,
v03.gp_name_lat AS gp_name_md    -- MD
,
v03.gp_name_lat AS gp_name_sk    -- SK
,
v03.gp_name_lat AS gp_name_hr    -- HR
,
v03.gp_name_lat AS gp_name_ro   -- RO
,
v03.gp_name AS gp_name_bg  -- BG
,
v01.gp_teilsortiment_id,
Coalesce(Max(CASE
WHEN v02.spr_id =  22 THEN v02.gp_teilsortiment_bez END),'N/A') AS gp_teilsortiment_bez                                                             -- Standard == DE
,
Coalesce(Max(CASE
WHEN v02.spr_id =  22 THEN v02.gp_teilsortiment_bez END),'N/A') AS gp_teilsortiment_bez_de                                                     -- DE
,
Coalesce(Max(CASE
WHEN v02.spr_id = 124 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_cz  -- CZ
,
Coalesce(Max(CASE
WHEN v02.spr_id = 108 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_sk -- SK
,
Coalesce(Max(CASE
WHEN v02.spr_id =  65 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v02.spr_id =  90 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v02.spr_id =  95 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_ro   -- RO
,
Coalesce(Max(CASE
WHEN v02.spr_id =  18 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_bg  -- BG
,
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
, gp_name
, gp_name_de
, gp_name_cz
, gp_name_pl
, gp_name_md
, gp_name_sk
, gp_name_hr
, gp_name_ro
, gp_name_bg
, v01.gp_teilsortiment_id
, v01.zek_id
, v01.zahlungsziel_id

UNION ALL
SELECT
v01.mandant_id,
v03.gp_id,
v03.gp_name_lat AS gp_name,
v03.gp_name_lat AS gp_name_de -- DE
,
v03.gp_name_lat AS gp_name_cz  -- CZ
,
v03.gp_name_lat AS gp_name_pl -- PL
,
v03.gp_name_lat AS gp_name_md    -- MD
,
v03.gp_name_lat AS gp_name_sk    -- SK
,
v03.gp_name_lat AS gp_name_hr    -- HR
,
v03.gp_name_lat AS gp_name_ro   -- RO
,
v03.gp_name AS gp_name_bg  -- BG
,
v01.gp_teilsortiment_id,
Coalesce(Max(CASE
WHEN v02.spr_id =  22 THEN v02.gp_teilsortiment_bez END),'N/A') AS gp_teilsortiment_bez                                                             -- Standard == DE
,
Coalesce(Max(CASE
WHEN v02.spr_id =  22 THEN v02.gp_teilsortiment_bez END),'N/A') AS gp_teilsortiment_bez_de                                                     -- DE
,
Coalesce(Max(CASE
WHEN v02.spr_id = 124 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_cz  -- CZ
,
Coalesce(Max(CASE
WHEN v02.spr_id = 108 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_sk -- SK
,
Coalesce(Max(CASE
WHEN v02.spr_id =  65 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_hr    -- HR
,
Coalesce(Max(CASE
WHEN v02.spr_id =  90 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_pl    -- PL
,
Coalesce(Max(CASE
WHEN v02.spr_id =  95 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_ro   -- RO
,
Coalesce(Max(CASE
WHEN v02.spr_id =  18 THEN v02.gp_teilsortiment_bez END), gp_teilsortiment_bez_de) AS gp_teilsortiment_bez_bg  -- BG
,
v01.zek_id,
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
, gp_name
, gp_name_de
, gp_name_cz
, gp_name_pl
, gp_name_md
, gp_name_sk
, gp_name_hr
, gp_name_ro
, gp_name_bg
, v01.gp_teilsortiment_id
, v01.zek_id
, v01.zahlungsziel_id;