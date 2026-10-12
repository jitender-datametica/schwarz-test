CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_LIEF_PAL_TYP_2
-- #613296 Splitt Palettentyp 6 in 61 und 64 - sschuecke 10.06.2015
-- 09.02.2021, AP0078007, SPEC0101516, srom0404, lief_pal_typ_id auf CHAR(2)
-- 10.05.2021, AP0088365, SPEC0112133, dknop, adding lief_pal_typ_grp_id
-- 19.10.2021, AP0105952, SPEC0130938, dknop, adding WHEN lief_pal_typ_id='G' THEN 'MP', formatting updates
--2023-02-07, dknop, WHEN lief_pal_typ_id='8' THEN 'AKA_MP'
--2023-101-26, dknop, adding LIEF_PAL_TYP_GRP_DWH_ID
(
	LIEF_PAL_TYP_ID,
	MANDANT_ID,
	LIEF_PAL_TYP_GRP_ID,
	LIEF_PAL_TYP_GRP_DWH_ID
)
AS

SELECT
 CAST(lief_pal_typ_id AS VARCHAR(2)) AS lief_pal_typ_id
--trycast(lief_pal_typ_id AS BYTEINT)  AS lief_pal_typ_id
,mandant_id
,CAST( CASE WHEN lief_pal_typ_id='1' THEN 'OP'
WHEN lief_pal_typ_id='2' THEN 'OP'
WHEN lief_pal_typ_id='3' THEN 'DP'
WHEN lief_pal_typ_id='4' THEN 'MP'
WHEN lief_pal_typ_id='5' THEN 'MP'
WHEN lief_pal_typ_id='6' THEN 'MOGP'
WHEN lief_pal_typ_id='61' THEN 'MOGP'
WHEN lief_pal_typ_id='64' THEN 'MOGP'
WHEN lief_pal_typ_id='7' THEN 'BB'
--WHEN lief_pal_typ_id='8' THEN 'BB'
WHEN lief_pal_typ_id='8' THEN 'AKA_MP'
WHEN lief_pal_typ_id='9' THEN 'KKP'
WHEN lief_pal_typ_id='G' THEN 'MP'
WHEN lief_pal_typ_id='F' THEN 'other'
ELSE 'not assigned' END
AS VARCHAR(100) ) AS lief_pal_typ_grp_id,
CAST( CASE WHEN lief_pal_typ_id='1' THEN 'OP'
WHEN lief_pal_typ_id='2' THEN 'OP'
WHEN lief_pal_typ_id='3' THEN 'DP'
WHEN lief_pal_typ_id='4' THEN 'MP'
WHEN lief_pal_typ_id='5' THEN 'MP'
WHEN lief_pal_typ_id='6' THEN 'MOGP'
WHEN lief_pal_typ_id='61' THEN 'MO_OP'
WHEN lief_pal_typ_id='64' THEN 'MO_MP'
WHEN lief_pal_typ_id='7' THEN 'BB'
WHEN lief_pal_typ_id='8' THEN 'AKA_MP'
WHEN lief_pal_typ_id='9' THEN 'KKP'
WHEN lief_pal_typ_id='G' THEN 'MP'
WHEN lief_pal_typ_id='F' THEN 'other'
ELSE 'not assigned' END
AS VARCHAR(100) ) AS lief_pal_typ_grp_DWH_id
FROM DBP_VIEW.v_l_lief_pal_typ_2
--WHERE trycast(lief_pal_typ_id AS BYTEINT) IS NOT NULL
UNION
SELECT
--61 AS lief_pal_typ_id
 CAST('61' AS VARCHAR(2)) AS lief_pal_typ_id
,mandant_id
,CAST('MOGP' AS VARCHAR(100) ) AS lief_pal_typ_grp_id
,CAST('MO_OP' AS VARCHAR(100) ) AS lief_pal_typ_grp_DWH_id
FROM DBP_VIEW.v_l_lief_pal_typ_2
UNION
SELECT
--64 AS lief_pal_typ_id
 CAST('64' AS VARCHAR(2)) AS lief_pal_typ_id
,mandant_id
,CAST('MOGP'AS VARCHAR(100) ) AS lief_pal_typ_grp_id
,CAST('MO_MP' AS VARCHAR(100) ) AS lief_pal_typ_grp_DWH_id
FROM DBP_VIEW.v_l_lief_pal_typ_2;