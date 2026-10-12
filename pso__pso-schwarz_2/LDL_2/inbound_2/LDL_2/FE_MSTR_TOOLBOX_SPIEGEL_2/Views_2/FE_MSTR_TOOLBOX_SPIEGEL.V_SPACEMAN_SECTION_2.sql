/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup table for sections.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#  1.1     08.04.2024      Simeon NIkolaev          Updated transaltion for GB,US,NI,IE
#  1.1     23.04.2024      Simeon NIkolaev          Updated _BE_FR
#  2.0     12.06.2024      Simeon NIkolaev          added section_update_dt
#
#-----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_SPACEMAN_SECTION_2
(
  SRC_SECTION_NR
, INT_ORG_SID
, SPACEMAN_SECTION_SID
, SECTION_GROUP_LEVEL_5_NR
, SECTION_STATUS_CD
, SECTION_UPDATE_DT
, SECTION_NAME_BE
, SECTION_NAME_BE_FR
, SECTION_NAME_BG
, SECTION_NAME_CY
, SECTION_NAME_CZ
, SECTION_NAME
, SECTION_NAME_DK
, SECTION_NAME_EE
, SECTION_NAME_ES
, SECTION_NAME_FI
, SECTION_NAME_FR
, SECTION_NAME_GB
, SECTION_NAME_GR
, SECTION_NAME_HR
, SECTION_NAME_HU
, SECTION_NAME_IE
, SECTION_NAME_IT
, SECTION_NAME_LT
, SECTION_NAME_LV
, SECTION_NAME_NL
, SECTION_NAME_PL
, SECTION_NAME_PT
, SECTION_NAME_RO
, SECTION_NAME_RS
, SECTION_NAME_SE
, SECTION_NAME_SI
, SECTION_NAME_SK
, SECTION_NAME_US
, SECTION_NAME_NI
, SECTION_NAME_MT
, SECTION_NAME_CS
, SECTION_WIDTH_MEAS
) AS
   SELECT CAST(TO_NUMBER(sec.src_section_nr) AS INTEGER) AS src_section_nr
     , sec.int_org_sid
     , sechist.spaceman_section_sid
     , sechist.section_group_level_5_nr
     , sechist.section_status_cd
	  , sechist.section_update_dt
     , CASE WHEN intorg.int_org_nr = 'BE' THEN sechist.section_name ELSE '' END AS section_name_be
	  , CASE WHEN intorg.int_org_nr = 'BE' THEN sechist.section_name ELSE '' END AS section_name_be_fr
     , CASE WHEN intorg.int_org_nr = 'BG' THEN sechist.section_name ELSE '' END AS section_name_bg
     , CASE WHEN intorg.int_org_nr = 'CY' THEN sechist.section_name ELSE '' END AS section_name_cy
     , CASE WHEN intorg.int_org_nr = 'CZ' THEN sechist.section_name ELSE '' END AS section_name_cz
     , CASE WHEN (intorg.int_org_nr = 'DE' OR intorg.int_org_nr = 'AT' OR intorg.int_org_nr = 'CH') THEN sechist.section_name ELSE CASE WHEN sechist.section_name_de = 'NULL' THEN section_name ELSE section_name_de END END AS section_name
     , CASE WHEN intorg.int_org_nr = 'DK' THEN sechist.section_name ELSE '' END AS section_name_dk
     , CASE WHEN intorg.int_org_nr = 'EE' THEN sechist.section_name ELSE '' END AS section_name_ee
     , CASE WHEN intorg.int_org_nr = 'ES' THEN sechist.section_name ELSE '' END AS section_name_es
     , CASE WHEN intorg.int_org_nr = 'FI' THEN sechist.section_name ELSE '' END AS section_name_fi
     , CASE WHEN intorg.int_org_nr = 'FR' THEN sechist.section_name ELSE '' END AS section_name_fr
     , CASE WHEN intorg.int_org_nr = 'GB' THEN sechist.section_name ELSE section_name END AS section_name_gb
     , CASE WHEN intorg.int_org_nr = 'GR' THEN sechist.section_name ELSE '' END AS section_name_gr
     , CASE WHEN intorg.int_org_nr = 'HR' THEN sechist.section_name ELSE '' END AS section_name_hr
     , CASE WHEN intorg.int_org_nr = 'HU' THEN sechist.section_name ELSE '' END AS section_name_hu
     , CASE WHEN intorg.int_org_nr = 'IE' THEN sechist.section_name ELSE section_name END AS section_name_ie
     , CASE WHEN intorg.int_org_nr = 'IT' THEN sechist.section_name ELSE '' END AS section_name_it
     , CASE WHEN intorg.int_org_nr = 'LT' THEN sechist.section_name ELSE '' END AS section_name_lt
     , CASE WHEN intorg.int_org_nr = 'LV' THEN sechist.section_name ELSE '' END AS section_name_lv
     , CASE WHEN intorg.int_org_nr = 'NL' THEN sechist.section_name ELSE '' END AS section_name_nl
     , CASE WHEN intorg.int_org_nr = 'PL' THEN sechist.section_name ELSE '' END AS section_name_pl
     , CASE WHEN intorg.int_org_nr = 'PT' THEN sechist.section_name ELSE '' END AS section_name_pt
     , CASE WHEN intorg.int_org_nr = 'RO' THEN sechist.section_name ELSE '' END AS section_name_ro
     , CASE WHEN intorg.int_org_nr = 'RS_2' THEN sechist.section_name ELSE '' END AS section_name_rs
     , CASE WHEN intorg.int_org_nr = 'SE' THEN sechist.section_name ELSE '' END AS section_name_se
     , CASE WHEN intorg.int_org_nr = 'SI' THEN sechist.section_name ELSE '' END AS section_name_si
     , CASE WHEN intorg.int_org_nr = 'SK' THEN sechist.section_name ELSE '' END AS section_name_sk
     , CASE WHEN intorg.int_org_nr = 'US' THEN sechist.section_name ELSE section_name END AS section_name_us
     , CASE WHEN intorg.int_org_nr = 'IE' THEN sechist.section_name ELSE section_name END AS section_name_ni
     , CASE WHEN intorg.int_org_nr = 'IT' THEN sechist.section_name ELSE '' END AS section_name_mt
     , CASE WHEN intorg.int_org_nr = 'ES' THEN sechist.section_name ELSE '' END AS section_name_cs
     , sechist.section_width_meas
FROM   P_LEW_CORE_AC.v_spaceman_section_2 sec 
 INNER JOIN P_LEW_CORE_AC.v_spaceman_section_hist_2 sechist 
    ON sec.spaceman_section_sid = sechist.spaceman_section_sid
 INNER JOIN P_LEW_CORE_AC.v_internal_organisation_2 intorg
 	ON sec.int_org_sid = intorg.int_org_sid
WHERE  sechist.dwh_valid_to = '9999-12-30' 
   AND sechist.deleted_fg = 0 
   AND sechist.section_status_cd = 'RELEASED';