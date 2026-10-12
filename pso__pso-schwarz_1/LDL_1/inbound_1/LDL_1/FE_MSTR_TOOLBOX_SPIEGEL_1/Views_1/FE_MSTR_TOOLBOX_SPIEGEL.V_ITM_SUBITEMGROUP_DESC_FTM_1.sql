
/*
#----------------------------------------------------------------------------
# Description:
# Static table for Reporting.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     
#  2.0	   23.04.2024	    Simeon Nikolaev Update with _BE_FR
#-----------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_ITM_SUBITEMGROUP_DESC_FTM_1(
  SUBITEMGROUP_ID
 ,SUBITEMGROUP_DESC_AT
 ,SUBITEMGROUP_DESC_BE
 ,SUBITEMGROUP_DESC_BE_FR
 ,SUBITEMGROUP_DESC_BG
 ,SUBITEMGROUP_DESC_CH
 ,SUBITEMGROUP_DESC_CY
 ,SUBITEMGROUP_DESC_CZ
 ,SUBITEMGROUP_DESC
 ,SUBITEMGROUP_DESC_DK
 ,SUBITEMGROUP_DESC_ES
 ,SUBITEMGROUP_DESC_FI
 ,SUBITEMGROUP_DESC_FR
 ,SUBITEMGROUP_DESC_GB
 ,SUBITEMGROUP_DESC_GR
 ,SUBITEMGROUP_DESC_HR
 ,SUBITEMGROUP_DESC_HU
 ,SUBITEMGROUP_DESC_IE
 ,SUBITEMGROUP_DESC_IT
 ,SUBITEMGROUP_DESC_LT
 ,SUBITEMGROUP_DESC_LV
 ,SUBITEMGROUP_DESC_NI
 ,SUBITEMGROUP_DESC_NL
 ,SUBITEMGROUP_DESC_DE
 ,SUBITEMGROUP_DESC_PL
 ,SUBITEMGROUP_DESC_PT
 ,SUBITEMGROUP_DESC_RO
 ,SUBITEMGROUP_DESC_SE
 ,SUBITEMGROUP_DESC_SI
 ,SUBITEMGROUP_DESC_SK
 ,SUBITEMGROUP_DESC_CS
 ,SUBITEMGROUP_DESC_MT
 ,SUBITEMGROUP_DESC_US
 ,SUBITEMGROUP_DESC_RS
 ,SUBITEMGROUP_SHORT_DESC_AT
 ,SUBITEMGROUP_SHORT_DESC_BE
 ,SUBITEMGROUP_SHORT_DESC_BE_FR
 ,SUBITEMGROUP_SHORT_DESC_BG
 ,SUBITEMGROUP_SHORT_DESC_CH
 ,SUBITEMGROUP_SHORT_DESC_CY
 ,SUBITEMGROUP_SHORT_DESC_CZ
 ,SUBITEMGROUP_SHORT_DESC
 ,SUBITEMGROUP_SHORT_DESC_DK
 ,SUBITEMGROUP_SHORT_DESC_ES
 ,SUBITEMGROUP_SHORT_DESC_FI
 ,SUBITEMGROUP_SHORT_DESC_FR
 ,SUBITEMGROUP_SHORT_DESC_GB
 ,SUBITEMGROUP_SHORT_DESC_GR
 ,SUBITEMGROUP_SHORT_DESC_HR
 ,SUBITEMGROUP_SHORT_DESC_HU
 ,SUBITEMGROUP_SHORT_DESC_IE
 ,SUBITEMGROUP_SHORT_DESC_IT
 ,SUBITEMGROUP_SHORT_DESC_LT
 ,SUBITEMGROUP_SHORT_DESC_LV
 ,SUBITEMGROUP_SHORT_DESC_NI
 ,SUBITEMGROUP_SHORT_DESC_NL
 ,SUBITEMGROUP_SHORT_DESC_DE
 ,SUBITEMGROUP_SHORT_DESC_PL
 ,SUBITEMGROUP_SHORT_DESC_PT
 ,SUBITEMGROUP_SHORT_DESC_RO
 ,SUBITEMGROUP_SHORT_DESC_SE
 ,SUBITEMGROUP_SHORT_DESC_SI
 ,SUBITEMGROUP_SHORT_DESC_SK
 ,SUBITEMGROUP_SHORT_DESC_CS
 ,SUBITEMGROUP_SHORT_DESC_MT
 ,SUBITEMGROUP_SHORT_DESC_US
 ,SUBITEMGROUP_SHORT_DESC_RS
 ,SUBITEMGROUP_LONG_DESC_AT
 ,SUBITEMGROUP_LONG_DESC_BE
 ,SUBITEMGROUP_LONG_DESC_BE_FR
 ,SUBITEMGROUP_LONG_DESC_BG
 ,SUBITEMGROUP_LONG_DESC_CH
 ,SUBITEMGROUP_LONG_DESC_CY
 ,SUBITEMGROUP_LONG_DESC_CZ
 ,SUBITEMGROUP_LONG_DESC
 ,SUBITEMGROUP_LONG_DESC_DK
 ,SUBITEMGROUP_LONG_DESC_ES
 ,SUBITEMGROUP_LONG_DESC_FI
 ,SUBITEMGROUP_LONG_DESC_FR
 ,SUBITEMGROUP_LONG_DESC_GB
 ,SUBITEMGROUP_LONG_DESC_GR
 ,SUBITEMGROUP_LONG_DESC_HR
 ,SUBITEMGROUP_LONG_DESC_HU
 ,SUBITEMGROUP_LONG_DESC_IE
 ,SUBITEMGROUP_LONG_DESC_IT
 ,SUBITEMGROUP_LONG_DESC_LT
 ,SUBITEMGROUP_LONG_DESC_LV
 ,SUBITEMGROUP_LONG_DESC_NI
 ,SUBITEMGROUP_LONG_DESC_NL
 ,SUBITEMGROUP_LONG_DESC_DE
 ,SUBITEMGROUP_LONG_DESC_PL
 ,SUBITEMGROUP_LONG_DESC_PT
 ,SUBITEMGROUP_LONG_DESC_RO
 ,SUBITEMGROUP_LONG_DESC_SE
 ,SUBITEMGROUP_LONG_DESC_SI
 ,SUBITEMGROUP_LONG_DESC_SK
 ,SUBITEMGROUP_LONG_DESC_CS
 ,SUBITEMGROUP_LONG_DESC_MT
 ,SUBITEMGROUP_LONG_DESC_US
 ,SUBITEMGROUP_LONG_DESC_RS
) AS
	SELECT
	 subitemgroup_id
	,subitemgroup_desc_AT
	,subitemgroup_desc_BE
	,subitemgroup_desc_BE_FR
	,subitemgroup_desc_BG
	,subitemgroup_desc_CH
	,subitemgroup_desc_CY
	,subitemgroup_desc_CZ
	,subitemgroup_desc
	,subitemgroup_desc_DK
	,subitemgroup_desc_ES
	,subitemgroup_desc_FI
	,subitemgroup_desc_FR
	,subitemgroup_desc_GB
	,subitemgroup_desc_GR
	,subitemgroup_desc_HR
	,subitemgroup_desc_HU
	,subitemgroup_desc_IE
	,subitemgroup_desc_IT
	,subitemgroup_desc_LT
	,subitemgroup_desc_LV
	,subitemgroup_desc_NI
	,subitemgroup_desc_NL
	,subitemgroup_desc_DE
	,subitemgroup_desc_PL
	,subitemgroup_desc_PT
	,subitemgroup_desc_RO
	,subitemgroup_desc_SE
	,subitemgroup_desc_SI
	,subitemgroup_desc_SK
	,subitemgroup_desc_CS
	,subitemgroup_desc_MT
	,subitemgroup_desc_US
	,subitemgroup_desc_RS
	,subitemgroup_short_desc_AT
	,subitemgroup_short_desc_BE
	,subitemgroup_short_desc_BE_FR
	,subitemgroup_short_desc_BG
	,subitemgroup_short_desc_CH
	,subitemgroup_short_desc_CY
	,subitemgroup_short_desc_CZ
	,subitemgroup_short_desc
	,subitemgroup_short_desc_DK
	,subitemgroup_short_desc_ES
	,subitemgroup_short_desc_FI
	,subitemgroup_short_desc_FR
	,subitemgroup_short_desc_GB
	,subitemgroup_short_desc_GR
	,subitemgroup_short_desc_HR
	,subitemgroup_short_desc_HU
	,subitemgroup_short_desc_IE
	,subitemgroup_short_desc_IT
	,subitemgroup_short_desc_LT
	,subitemgroup_short_desc_LV
	,subitemgroup_short_desc_NI
	,subitemgroup_short_desc_NL
	,subitemgroup_short_desc_DE
	,subitemgroup_short_desc_PL
	,subitemgroup_short_desc_PT
	,subitemgroup_short_desc_RO
	,subitemgroup_short_desc_SE
	,subitemgroup_short_desc_SI
	,subitemgroup_short_desc_SK
	,subitemgroup_short_desc_CS
	,subitemgroup_short_desc_MT
	,subitemgroup_short_desc_US
	,subitemgroup_short_desc_RS
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_AT) AS subitemgroup_long_desc_AT
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_BE) AS subitemgroup_long_desc_BE
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_BE_FR) AS subitemgroup_long_desc_BE_FR
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_BG) AS subitemgroup_long_desc_BG
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_CH) AS subitemgroup_long_desc_CH
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_CY) AS subitemgroup_long_desc_CY
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_CZ) AS subitemgroup_long_desc_CZ
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc   ) AS subitemgroup_long_desc
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_DK) AS subitemgroup_long_desc_DK
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_ES) AS subitemgroup_long_desc_ES
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_FI) AS subitemgroup_long_desc_FI
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_FR) AS subitemgroup_long_desc_FR
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_GB) AS subitemgroup_long_desc_GB
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_GR) AS subitemgroup_long_desc_GR
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_HR) AS subitemgroup_long_desc_HR
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_HU) AS subitemgroup_long_desc_HU
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_IE) AS subitemgroup_long_desc_IE
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_IT) AS subitemgroup_long_desc_IT
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_LT) AS subitemgroup_long_desc_LT
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_LV) AS subitemgroup_long_desc_LV
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_NI) AS subitemgroup_long_desc_NI
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_NL) AS subitemgroup_long_desc_NL
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_DE) AS subitemgroup_long_desc_DE
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_PL) AS subitemgroup_long_desc_PL
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_PT) AS subitemgroup_long_desc_PT
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_RO) AS subitemgroup_long_desc_RO
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_SE) AS subitemgroup_long_desc_SE
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_SI) AS subitemgroup_long_desc_SI
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_SK) AS subitemgroup_long_desc_SK
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_CS) AS subitemgroup_long_desc_CS
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_MT) AS subitemgroup_long_desc_MT
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_US) AS subitemgroup_long_desc_US
	,CONCAT(subitemgroup_id,' : ',subitemgroup_desc_RS) AS subitemgroup_long_desc_RS
	FROM p_lew_mart_msi_ac.v_itm_subitemgroup_desc_1;