CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_ARTKZ_EIGENMARKE_2
-- INC3266427 lsvi0303: 12.07.2021
-- 26.06.2023: INC6777436

(
  mandant_id
, eigenmarke_id
, eigenmarke_bez
, eigenmarke_bez_de
, eigenmarke_bez_cz
, eigenmarke_bez_sk
, eigenmarke_bez_hr
, eigenmarke_bez_pl
, eigenmarke_bez_ro
, eigenmarke_bez_bg
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT
v01.mandant_id,
v01.eigenmarke_id AS eigenmarke_id,
CASE WHEN v01.eigenmarke_id NOT IN ('S') 
THEN TRIM(COALESCE(MAX(CASE
WHEN v01.spr_id =  22  THEN v01.eigenmarke_bez END),'N/A'))
ELSE 'SPIRITUOSEN;BIER' END AS eigenmarke_bez -- Standard = DE
,
CASE WHEN v01.eigenmarke_id NOT IN ('S') 
THEN TRIM(COALESCE(MAX(CASE
WHEN v01.spr_id =  22  THEN v01.eigenmarke_bez END),'N/A')) 
ELSE 'SPIRITUOSEN;BIER' END AS eigenmarke_bez_de -- DE                      
,
CASE WHEN v01.eigenmarke_id NOT IN ('S')
THEN TRIM(COALESCE(MAX(CASE
WHEN v01.spr_id = 124  THEN v01.eigenmarke_bez END), eigenmarke_bez_de)) 
ELSE 'SPIRITUOSEN;BIER' END AS eigenmarke_bez_cz  -- CZ
,
CASE WHEN v01.eigenmarke_id NOT IN ('S')
THEN TRIM(COALESCE(MAX(CASE
WHEN v01.spr_id = 108  THEN v01.eigenmarke_bez END), eigenmarke_bez_de)) 
ELSE 'SPIRITUOSEN;BIER' END AS eigenmarke_bez_sk -- SK
,
CASE WHEN v01.eigenmarke_id NOT IN ('S')
THEN TRIM(COALESCE(MAX(CASE
WHEN v01.spr_id =  65  THEN v01.eigenmarke_bez END), eigenmarke_bez_de)) 
ELSE 'SPIRITUOSEN;BIER' END AS eigenmarke_bez_hr  -- HR
,
CASE WHEN v01.eigenmarke_id NOT IN ('S')
THEN TRIM(COALESCE(MAX(CASE
WHEN v01.spr_id =  90  THEN v01.eigenmarke_bez END), eigenmarke_bez_de)) 
ELSE 'SPIRITUOSEN;BIER' END AS eigenmarke_bez_pl  -- PL
,
CASE WHEN v01.eigenmarke_id NOT IN ('S')
THEN TRIM(COALESCE(MAX(CASE
WHEN v01.spr_id =  95  THEN v01.eigenmarke_bez END), eigenmarke_bez_de)) 
ELSE 'SPIRITUOSEN;BIER' END AS eigenmarke_bez_ro  -- RO
,
CASE WHEN v01.eigenmarke_id NOT IN ('S')
THEN TRIM(COALESCE(MAX(CASE
WHEN v01.spr_id =  18  THEN v01.eigenmarke_bez END), eigenmarke_bez_de)) 
ELSE 'SPIRITUOSEN;BIER' END AS eigenmarke_bez_bg -- BG

FROM dbp_view.v_artkz_eigenmarke_2 v01

GROUP BY
  v01.mandant_id
, v01.eigenmarke_id
, v01.eigenmarke_bez;