CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_ARTKZ_EIGENMARKE
-- NSR0077663 Bezeichnungen sollen nun wieder angezeigt werden - sschuecke 12.02.2018
-- INC2429581 lsvi0303: 11.11.2020
-- INC3266427 lsvi0303: 12.07.2021
-- INC4343362 Wegfall Join auf akt_msi_user_spr_zu, keine Mehrsprachigkeit - sschuecke 03.03.2022
-- Mehrsprachigkeit added
(
	MANDANT_ID,
	EIGENMARKE_ID,
	EIGENMARKE_BEZ,
  	EIGENMARKE_BEZ_DE,
	EIGENMARKE_BEZ_CZ,
	EIGENMARKE_BEZ_SK,
	EIGENMARKE_BEZ_HR,
	EIGENMARKE_BEZ_PL,
	EIGENMARKE_BEZ_RO,
	EIGENMARKE_BEZ_BG
) AS
                              
SELECT
v01.mandant_id,
v01.eigenmarke_id AS eigenmarke_id,
CASE WHEN v01.eigenmarke_id NOT IN ('S') 
THEN TRIM(COALESCE(MAX(CASE WHEN v01.spr_id =  22  THEN v01.eigenmarke_bez END),'N/A')) 
ELSE 'SPIRITUOSEN;BIER' END AS eigenmarke_bez                               -- Standard == DE
,
CASE WHEN v01.eigenmarke_id NOT IN ('S') 
THEN TRIM(COALESCE(MAX(CASE
WHEN v01.spr_id =  22  THEN v01.eigenmarke_bez END),'N/A')) 
ELSE 'SPIRITUOSEN;BIER' END AS eigenmarke_bez_de                          -- DE
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

FROM dbp_view.v_artkz_eigenmarke v01
WHERE v01.mandant_id <> 1
GROUP BY
  v01.mandant_id
, v01.eigenmarke_id
, v01.eigenmarke_bez;
