/*
#----------------------------------------------------------------------------
# Description:
# # This view provides the lookup for section selection. "Section selection" is a technical information for special requirement in dossier (selection yes and no in "übersicht EK" visualization)
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#  1.1     09.04.2025      Simeon Nikolaev          Fix for DE/AT/CH
#
#-----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_SPACEMAN_SECTION_SELECTION_2(
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
	,SECTION_SELECTION_NAME_DE
	,SECTION_SELECTION_NAME_AT 
	,SECTION_SELECTION_NAME_CH 
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
SELECT  int_org_sid
    ,spaceman_section_sid
    ,src_section_nr
    ,section_selection_id
    ,section_sid_selection
    ,selection_flag
    ,section_selection_name_be
	,section_selection_name_be_fr
    ,section_selection_name_bg
    ,section_selection_name_cy
    ,section_selection_name_cz
    ,section_selection_name
    ,SECTION_SELECTION_NAME AS SECTION_SELECTION_NAME_DE
    ,SECTION_SELECTION_NAME AS SECTION_SELECTION_NAME_CH
    ,SECTION_SELECTION_NAME AS SECTION_SELECTION_NAME_AT
    ,section_selection_name_dk
    ,section_selection_name_ee
    ,section_selection_name_es
    ,section_selection_name_fi
    ,section_selection_name_fr
    ,section_selection_name_gb
    ,section_selection_name_gr
    ,section_selection_name_hr
    ,section_selection_name_hu
    ,section_selection_name_ie
    ,section_selection_name_it
    ,section_selectionn_name_lt
    ,section_selection_name_lv
    ,section_selection_name_nl
    ,section_selection_name_pl
    ,section_selection_name_pt
    ,section_selection_name_ro
    ,section_selection_name_rs
    ,section_selection_name_se
    ,section_selection_name_si
    ,section_selection_name_sk
    ,section_selection_name_us
    ,section_selection_name_ni
    ,section_selection_name_mt
    ,section_selection_name_cs
FROM FE_MSTR_TOOLBOX_SPIEGEL.t_spaceman_section_selection_2;
