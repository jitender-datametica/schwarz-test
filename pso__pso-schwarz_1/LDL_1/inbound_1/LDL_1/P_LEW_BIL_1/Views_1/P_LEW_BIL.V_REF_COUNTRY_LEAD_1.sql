create or replace view LDL_PRODUCTION.P_LEW_BIL.V_REF_COUNTRY_LEAD_1(
	INT_ID,
	COUNTRY_ID,
	COUNTRY_ISO_CD,
	COUNTRY_GROUP_ID,
	LISY_SORT,
	DASHBOARD_RELEVANT_FG,
	COUNTRY_DESC_AT,
	COUNTRY_DESC_BE,
	COUNTRY_DESC_BE_FR,
	COUNTRY_DESC_BG,
	COUNTRY_DESC_CH,
	COUNTRY_DESC_CY,
	COUNTRY_DESC_CZ,
	COUNTRY_DESC,
	COUNTRY_DESC_DK,
	COUNTRY_DESC_EE,
	COUNTRY_DESC_ES,
	COUNTRY_DESC_FI,
	COUNTRY_DESC_FR,
	COUNTRY_DESC_GB,
	COUNTRY_DESC_GR,
	COUNTRY_DESC_HR,
	COUNTRY_DESC_HU,
	COUNTRY_DESC_IE,
	COUNTRY_DESC_IT,
	COUNTRY_DESC_LT,
	COUNTRY_DESC_NI,
	COUNTRY_DESC_NL,
	COUNTRY_DESC_DE,
	COUNTRY_DESC_LV,
	COUNTRY_DESC_PL,
	COUNTRY_DESC_PT,
	COUNTRY_DESC_RO,
	COUNTRY_DESC_SE,
	COUNTRY_DESC_SI,
	COUNTRY_DESC_SK,
	COUNTRY_DESC_CS,
	COUNTRY_DESC_MT,
	COUNTRY_DESC_US,
	COUNTRY_DESC_RS
) as
   SELECT   cn.int_id
          , cn.country_id                                           
          , cn.country_iso_cd                                       
          , COALESCE(skey.country_group_id, 99) AS country_group_id 
          , CASE WHEN cn.country_id = 23 THEN  1   WHEN cn.country_id = 12 THEN  2   WHEN cn.country_id = 18 THEN  3
                 WHEN cn.country_id = 32 THEN  4   WHEN cn.country_id =  1 THEN  5   WHEN cn.country_id = 14 THEN  6
                 WHEN cn.country_id =  5 THEN  7   WHEN cn.country_id = 10 THEN  8   WHEN cn.country_id = 31 THEN  9
                 WHEN cn.country_id =  2 THEN 10   WHEN cn.country_id = 25 THEN 12   WHEN cn.country_id = 22 THEN 13
                 WHEN cn.country_id =  4 THEN 14   WHEN cn.country_id = 19 THEN 15   WHEN cn.country_id = 13 THEN 16
                 WHEN cn.country_id = 17 THEN 17   WHEN cn.country_id = 21 THEN 18   WHEN cn.country_id = 11 THEN 19
                 WHEN cn.country_id = 27 THEN 20   WHEN cn.country_id =  8 THEN 21   WHEN cn.country_id = 33 THEN 22
                 WHEN cn.country_id = 24 THEN 23   WHEN cn.country_id =  6 THEN 24   WHEN cn.country_id = 29 THEN 25
                 WHEN cn.country_id = 16 THEN 26   WHEN cn.country_id = 15 THEN 27   WHEN cn.country_id = 28 THEN 28
                 WHEN cn.country_id = 26 THEN 29   WHEN cn.country_id =  3 THEN 30   WHEN cn.country_id = 34 THEN 31
		         WHEN cn.country_id = 20 THEN 32   WHEN cn.country_id =  9 THEN 33
                 ELSE 99
             END                  AS lisy_sort 
          , cn.dashboard_relevant_fg           
          , MAX(CASE WHEN cn.language_id =  1 THEN cn.country_desc ELSE NULL END) AS country_desc_AT
		  , MAX(CASE WHEN cn.language_id =  2 THEN cn.country_desc ELSE NULL END) AS country_desc_BE
		  , MAX(CASE WHEN cn.language_id = 12 THEN cn.country_desc ELSE NULL END) AS country_desc_BE_fr
		  , MAX(CASE WHEN cn.language_id =  3 THEN cn.country_desc ELSE NULL END) AS country_desc_BG
		  , MAX(CASE WHEN cn.language_id =  4 THEN cn.country_desc ELSE NULL END) AS country_desc_CH
		  , MAX(CASE WHEN cn.language_id =  5 THEN cn.country_desc ELSE NULL END) AS country_desc_CY
		  , MAX(CASE WHEN cn.language_id =  6 THEN cn.country_desc ELSE NULL END) AS country_desc_CZ
		  , MAX(CASE WHEN cn.language_id =  7 THEN cn.country_desc ELSE NULL END) AS country_desc
		  , MAX(CASE WHEN cn.language_id =  8 THEN cn.country_desc ELSE NULL END) AS country_desc_DK
		  , MAX(CASE WHEN cn.language_id =  9 THEN cn.country_desc ELSE NULL END) AS country_desc_EE
		  , MAX(CASE WHEN cn.language_id = 10 THEN cn.country_desc ELSE NULL END) AS country_desc_ES
		  , MAX(CASE WHEN cn.language_id = 11 THEN cn.country_desc ELSE NULL END) AS country_desc_FI
		  , MAX(CASE WHEN cn.language_id = 12 THEN cn.country_desc ELSE NULL END) AS country_desc_FR
		  , MAX(CASE WHEN cn.language_id = 13 THEN cn.country_desc ELSE NULL END) AS country_desc_GB
		  , MAX(CASE WHEN cn.language_id = 14 THEN cn.country_desc ELSE NULL END) AS country_desc_GR
		  , MAX(CASE WHEN cn.language_id = 15 THEN cn.country_desc ELSE NULL END) AS country_desc_HR
		  , MAX(CASE WHEN cn.language_id = 16 THEN cn.country_desc ELSE NULL END) AS country_desc_HU
		  , MAX(CASE WHEN cn.language_id = 17 THEN cn.country_desc ELSE NULL END) AS country_desc_IE
		  , MAX(CASE WHEN cn.language_id = 18 THEN cn.country_desc ELSE NULL END) AS country_desc_IT
		  , MAX(CASE WHEN cn.language_id = 19 THEN cn.country_desc ELSE NULL END) AS country_desc_LT
		  , MAX(CASE WHEN cn.language_id = 21 THEN cn.country_desc ELSE NULL END) AS country_desc_NI
		  , MAX(CASE WHEN cn.language_id = 22 THEN cn.country_desc ELSE NULL END) AS country_desc_NL
		  , MAX(CASE WHEN cn.language_id = 20 THEN cn.country_desc ELSE NULL END) AS country_desc_LV
		  , MAX(CASE WHEN cn.language_id = 23 THEN cn.country_desc ELSE NULL END) AS country_desc_DE
		  , MAX(CASE WHEN cn.language_id = 24 THEN cn.country_desc ELSE NULL END) AS country_desc_PL
		  , MAX(CASE WHEN cn.language_id = 25 THEN cn.country_desc ELSE NULL END) AS country_desc_PT
		  , MAX(CASE WHEN cn.language_id = 26 THEN cn.country_desc ELSE NULL END) AS country_desc_RO
		  , MAX(CASE WHEN cn.language_id = 27 THEN cn.country_desc ELSE NULL END) AS country_desc_SE
		  , MAX(CASE WHEN cn.language_id = 28 THEN cn.country_desc ELSE NULL END) AS country_desc_SI
		  , MAX(CASE WHEN cn.language_id = 29 THEN cn.country_desc ELSE NULL END) AS country_desc_SK
		  , MAX(CASE WHEN cn.language_id = 31 THEN cn.country_desc ELSE NULL END) AS country_desc_CS
		  , MAX(CASE WHEN cn.language_id = 32 THEN cn.country_desc ELSE NULL END) AS country_desc_MT
		  , MAX(CASE WHEN cn.language_id = 33 THEN cn.country_desc ELSE NULL END) AS country_desc_US
		  , MAX(CASE WHEN cn.language_id = 34 THEN cn.country_desc ELSE NULL END) AS country_desc_RS
     FROM P_LEW_CORE_AC.v_wawi_ref_country_act_1 AS cn
     LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_org_client_skey_1 AS skey
       ON   cn.country_id = skey.client_id

    GROUP BY   cn.int_id
             , cn.country_id
             , cn.country_iso_cd
             , skey.country_group_id
             , lisy_sort
             , cn.dashboard_relevant_fg
;
