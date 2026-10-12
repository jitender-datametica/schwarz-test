CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_REF_SPACEMAN_ITEM_MERCHANDISING_TYPE_2(
 ITEM_MERCHANDISING_TYPE_CD	
,ITEM_MERCHANDISING_TYPE_CD_DE
,ITEM_MERCHANDISING_TYPE_DESCR
,ITEM_MERCHANDISING_TYPE_CD_DESC
,ITEM_MERCHANDISING_TYPE_CD_DESC_DE
,ITEM_MERCHANDISING_TYPE_CD_DESC_CH
,ITEM_MERCHANDISING_TYPE_CD_DESC_AT
,ITEM_MERCHANDISING_TYPE_CD_DESC_BE
,ITEM_MERCHANDISING_TYPE_CD_DESC_BE_FR	
,ITEM_MERCHANDISING_TYPE_CD_DESC_BG
,ITEM_MERCHANDISING_TYPE_CD_DESC_CY
,ITEM_MERCHANDISING_TYPE_CD_DESC_CZ
,ITEM_MERCHANDISING_TYPE_CD_DESC_DK
,ITEM_MERCHANDISING_TYPE_CD_DESC_ES
,ITEM_MERCHANDISING_TYPE_CD_DESC_FI
,ITEM_MERCHANDISING_TYPE_CD_DESC_FR
,ITEM_MERCHANDISING_TYPE_CD_DESC_GB
,ITEM_MERCHANDISING_TYPE_CD_DESC_GR
,ITEM_MERCHANDISING_TYPE_CD_DESC_HR
,ITEM_MERCHANDISING_TYPE_CD_DESC_HU
,ITEM_MERCHANDISING_TYPE_CD_DESC_IE
,ITEM_MERCHANDISING_TYPE_CD_DESC_IT
,ITEM_MERCHANDISING_TYPE_CD_DESC_LT
,ITEM_MERCHANDISING_TYPE_CD_DESC_NI
,ITEM_MERCHANDISING_TYPE_CD_DESC_NL
,ITEM_MERCHANDISING_TYPE_CD_DESC_PL
,ITEM_MERCHANDISING_TYPE_CD_DESC_PT
,ITEM_MERCHANDISING_TYPE_CD_DESC_RO
,ITEM_MERCHANDISING_TYPE_CD_DESC_SE
,ITEM_MERCHANDISING_TYPE_CD_DESC_SI
,ITEM_MERCHANDISING_TYPE_CD_DESC_SK
,ITEM_MERCHANDISING_TYPE_CD_DESC_CS
,ITEM_MERCHANDISING_TYPE_CD_DESC_MT
,ITEM_MERCHANDISING_TYPE_CD_DESC_US
,ITEM_MERCHANDISING_TYPE_CD_DESC_RS
) AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides the lookup of item_2 merchandising type.
#
#-----------------------------------------------------------------------------
# History:
#  1.0     30.01.2023      Patrick Mueller          Initial Version
#  2.0     03.06.2024      Simeon Nikolaev          DE trans for type_cd
#
#-----------------------------------------------------------------------------
*/
SELECT 
  item_merchandising_type_cd
, item_merchandising_type_cd_de
, item_merchandising_type_descr
, item_merchandising_type_cd_de AS item_merchandising_type_cd_desc
, item_merchandising_type_cd_de AS item_merchandising_type_cd_desc_DE
, item_merchandising_type_cd_de AS item_merchandising_type_cd_desc_CH
, item_merchandising_type_cd_de AS item_merchandising_type_cd_desc_AT
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_BE
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_BE_FR
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_BG
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_CY
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_CZ
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_DK
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_ES
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_FI
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_FR
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_GB
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_GR
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_HR
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_HU
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_IE
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_IT
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_LT
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_NI
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_NL
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_PL
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_PT
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_RO
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_SE
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_SI
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_SK
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_CS
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_MT
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_US
, item_merchandising_type_cd 	AS item_merchandising_type_cd_desc_RS
FROM
	(
	SELECT 
	  item_merchandising_type_cd
	, CASE 
	  WHEN item_merchandising_type_cd = 'Case' THEN 'VSE'
	  WHEN item_merchandising_type_cd = 'Hand' THEN 'Einzeln'
	  WHEN item_merchandising_type_cd = 'DD' THEN 'DD'
	  WHEN item_merchandising_type_cd = 'EP' THEN 'EP'
	  ELSE ' '
	  END AS item_merchandising_type_cd_de
	, item_merchandising_type_descr
	FROM   P_LEW_CORE_AC.V_REF_SPACEMAN_ITEM_MERCHANDISING_TYPE_2
	)
;
