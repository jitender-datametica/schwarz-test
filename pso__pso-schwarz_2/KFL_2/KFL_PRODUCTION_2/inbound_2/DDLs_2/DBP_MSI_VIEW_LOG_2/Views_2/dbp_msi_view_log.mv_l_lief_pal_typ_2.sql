CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_LIEF_PAL_TYP_2
--27.01.2021, SPEC0097379, AP0069430, dknop, initiale Anlage_2
--10.05.2021, SPEC0112133, AP0088365, dknop, adding lief_pal_typ_grp_id
--06.08.2021, SPEC0112147, AP0070892, dknop, adding null value
--19.10.2021, SPEC0130938, AP0105952, dknop, adding WHEN lief_pal_typ_id='G' THEN 'MP', formatting updates
--22.10.2021, SPEC0112133, AP0088365, dknop, removing mandant_id
--2023-02-10, dknop, updating WHEN lief_pal_typ_id='8' THEN AKA_MP
--13.10.2023, nwag2310, J4+J9 added
--2023-10-24, AP0178083, dknop, updating for J4 and J9, adding LIEF_PAL_TYP_GRP_DWH_ID
AS
SELECT
 lief_pal_typ_id AS lief_pal_typ_id
--,mandant_id
,CAST( CASE WHEN lief_pal_typ_id='1' THEN 'OP'
WHEN lief_pal_typ_id='2' THEN 'OP'
WHEN lief_pal_typ_id='3' THEN 'DP'
WHEN lief_pal_typ_id='4' THEN 'MP'
WHEN lief_pal_typ_id='5' THEN 'MP'
WHEN lief_pal_typ_id='6' THEN 'MOGP'
WHEN lief_pal_typ_id='61' THEN 'MOGP'
WHEN lief_pal_typ_id='64' THEN 'MOGP'
WHEN lief_pal_typ_id='J' THEN 'AKAF'
WHEN lief_pal_typ_id='J4' THEN 'AKAF_MP'
WHEN lief_pal_typ_id='J9' THEN 'AKAF_KKP'
WHEN lief_pal_typ_id='7' THEN 'BB'
--WHEN lief_pal_typ_id='8' THEN 'BB'
WHEN lief_pal_typ_id='8' THEN 'AKA_MP'
WHEN lief_pal_typ_id='9' THEN 'KKP'
WHEN lief_pal_typ_id='F' THEN 'other'
WHEN lief_pal_typ_id='G' THEN 'MP'   
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
WHEN lief_pal_typ_id='J' THEN 'AKAF'
WHEN lief_pal_typ_id='J4' THEN 'AKAF_MP'
WHEN lief_pal_typ_id='J9' THEN 'AKAF_KKP'
WHEN lief_pal_typ_id='7' THEN 'BB'
--WHEN lief_pal_typ_id='8' THEN 'BB'
WHEN lief_pal_typ_id='8' THEN 'AKA_MP'
WHEN lief_pal_typ_id='9' THEN 'KKP'
WHEN lief_pal_typ_id='F' THEN 'other'
WHEN lief_pal_typ_id='G' THEN 'MP'   
ELSE 'not assigned' END
AS VARCHAR(100) ) AS lief_pal_typ_grp_dwh_id
FROM dbp_view.v_l_lief_pal_typ_2
UNION
SELECT
'J4' AS lief_pal_typ_id
--,mandant_id
,CAST('AKAF_MP' AS VARCHAR(100) ) AS lief_pal_typ_grp_id
,CAST('AKAF_MP' AS VARCHAR(100) ) AS lief_pal_typ_grp_dwh_id
FROM dbp_view.v_l_lief_pal_typ_2
UNION
SELECT
'J9' AS lief_pal_typ_id
--,mandant_id
,CAST('AKAF_KKP' AS VARCHAR(100) ) AS lief_pal_typ_grp_id
,CAST('AKAF_KKP' AS VARCHAR(100) ) AS lief_pal_typ_grp_dwh_id
FROM dbp_view.v_l_lief_pal_typ_2
UNION
SELECT
'61' AS lief_pal_typ_id
--,mandant_id
,CAST('MOGP' AS VARCHAR(100) ) AS lief_pal_typ_grp_id
,CAST('MO_OP' AS VARCHAR(100) ) AS lief_pal_typ_grp_dwh_id
FROM dbp_view.v_l_lief_pal_typ_2
UNION
SELECT
'64' AS lief_pal_typ_id
--,mandant_id
,CAST('MOGP' AS VARCHAR(100) ) AS lief_pal_typ_grp_id
,CAST('MO_MP' AS VARCHAR(100) ) AS lief_pal_typ_grp_dwh_id
FROM dbp_view.v_l_lief_pal_typ_2
UNION
SELECT
'' AS lief_pal_typ_id
--,mandant_id
,'' AS lief_pal_typ_grp_id
,'' AS lief_pal_typ_grp_dwh_id
FROM dbp_view.v_l_lief_pal_typ_2;
