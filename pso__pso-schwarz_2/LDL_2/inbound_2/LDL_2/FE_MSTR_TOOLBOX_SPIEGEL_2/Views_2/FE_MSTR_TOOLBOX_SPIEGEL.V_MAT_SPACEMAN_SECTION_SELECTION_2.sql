/*
#----------------------------------------------------------------------------
# Description:
# This table provides the lookup for section selection. "Section selection" is a technical information for special requirement in dossier (selection yes and no in "übersicht EK" visualization)
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_MAT_SPACEMAN_SECTION_SELECTION_2(
	INT_ORG_SID
	,SPACEMAN_SECTION_SID
	,SRC_SECTION_NR
  ,SECTION_SELECTION_ID
	,SECTION_SID_SELECTION
	,SELECTION_FLAG
	,SECTION_SELECTION_NAME_BE
	,SECTION_SELECTION_NAME_BE_FR
	,SECTION_SELECTION_NAME_BG
	,SECTION_SELECTION_NAME_CY
	,SECTION_SELECTION_NAME_CZ
	,SECTION_SELECTION_NAME
	,SECTION_SELECTION_NAME_DK
	,SECTION_SELECTION_NAME_EE
	,SECTION_SELECTION_NAME_ES
	,SECTION_SELECTION_NAME_FI
	,SECTION_SELECTION_NAME_FR
	,SECTION_SELECTION_NAME_GB
	,SECTION_SELECTION_NAME_GR
	,SECTION_SELECTION_NAME_HR
	,SECTION_SELECTION_NAME_HU
	,SECTION_SELECTION_NAME_IE
	,SECTION_SELECTION_NAME_IT
	,SECTION_SELECTIONN_NAME_LT
	,SECTION_SELECTION_NAME_LV
	,SECTION_SELECTION_NAME_NL
	,SECTION_SELECTION_NAME_PL
	,SECTION_SELECTION_NAME_PT
	,SECTION_SELECTION_NAME_RO
	,SECTION_SELECTION_NAME_RS
	,SECTION_SELECTION_NAME_SE
	,SECTION_SELECTION_NAME_SI
	,SECTION_SELECTION_NAME_SK
	,SECTION_SELECTION_NAME_US
	,SECTION_SELECTION_NAME_NI
	,SECTION_SELECTION_NAME_MT
	,SECTION_SELECTION_NAME_CS
) AS
SELECT sec.int_org_sid
     , sec.spaceman_section_sid
     , CAST(TO_NUMBER(sec.src_section_nr) AS INTEGER) AS src_section_nr
     , sec.spaceman_section_sid*1000+selection_nr AS section_selection_id
     , CONCAT(sec.spaceman_section_sid, ' - ', selection.selection) AS section_sid_selection
     , selection.selection AS selection_flag
     , CASE WHEN intorg.int_org_nr = 'BE' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_be
	 , CASE WHEN intorg.int_org_nr = 'BE' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_be_fr
     , CASE WHEN intorg.int_org_nr = 'BG' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_bg
     , CASE WHEN intorg.int_org_nr = 'CY' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_cy
     , CASE WHEN intorg.int_org_nr = 'CZ' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_cz    
     , CASE WHEN (intorg.int_org_nr = 'DE' OR intorg.int_org_nr = 'AT' OR intorg.int_org_nr = 'CH') THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE CASE WHEN sechist.section_name_de = 'NULL' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE CONCAT(sec.src_section_nr, ' ', sechist.section_name_de) END END AS section_selection_name
     , CASE WHEN intorg.int_org_nr = 'DK' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_dk
     , CASE WHEN intorg.int_org_nr = 'EE' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_ee
     , CASE WHEN intorg.int_org_nr = 'ES' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_es
     , CASE WHEN intorg.int_org_nr = 'FI' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_fi
     , CASE WHEN intorg.int_org_nr = 'FR' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_fr
     , CASE WHEN intorg.int_org_nr = 'GB' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_gb
     , CASE WHEN intorg.int_org_nr = 'GR' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_gr
     , CASE WHEN intorg.int_org_nr = 'HR' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_hr
     , CASE WHEN intorg.int_org_nr = 'HU' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_hu
     , CASE WHEN intorg.int_org_nr = 'IE' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_ie
     , CASE WHEN intorg.int_org_nr = 'IT' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_it
     , CASE WHEN intorg.int_org_nr = 'LT' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_lt
     , CASE WHEN intorg.int_org_nr = 'LV' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_lv
     , CASE WHEN intorg.int_org_nr = 'NL' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_nl
     , CASE WHEN intorg.int_org_nr = 'PL' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_pl
     , CASE WHEN intorg.int_org_nr = 'PT' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_pt
     , CASE WHEN intorg.int_org_nr = 'RO' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_ro
     , CASE WHEN intorg.int_org_nr = 'RS_2' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_rs
     , CASE WHEN intorg.int_org_nr = 'SE' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_se
     , CASE WHEN intorg.int_org_nr = 'SI' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_si
     , CASE WHEN intorg.int_org_nr = 'SK' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_sk
     , CASE WHEN intorg.int_org_nr = 'US' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_us
     , CASE WHEN intorg.int_org_nr = 'IE' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_ni
     , CASE WHEN intorg.int_org_nr = 'IT' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_mt
     , CASE WHEN intorg.int_org_nr = 'ES' THEN CONCAT(sec.src_section_nr, ' ', sechist.section_name) ELSE '' END AS section_selection_name_cs
FROM  P_LEW_CORE_AC.v_spaceman_section_2 sec 
INNER JOIN P_LEW_CORE_AC.V_SPACEMAN_SECTION_HIST_2 sechist 
   ON sec.spaceman_section_sid = sechist.spaceman_section_sid 
INNER JOIN P_LEW_CORE_AC.v_internal_organisation_2 intorg
 	ON sec.int_org_sid = intorg.int_org_sid
INNER JOIN 
            (SELECT 1 AS selection_nr, 'YES' AS selection
             UNION ALL
             SELECT 2 AS selection_nr, 'NO' AS selection) selection
WHERE sechist.dwh_valid_to = '9999-12-30' 
  AND sechist.deleted_fg = 0;