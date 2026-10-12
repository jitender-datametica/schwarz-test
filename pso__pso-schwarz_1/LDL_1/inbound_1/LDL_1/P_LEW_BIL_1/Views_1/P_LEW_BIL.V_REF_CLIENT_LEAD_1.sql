create or replace view LDL_PRODUCTION.P_LEW_BIL.V_REF_CLIENT_LEAD_1(
	INT_ID,
	CLIENT_ID,
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
	COUNTRY_DESC_RS,
	COUNTRY_OPENING_DATE
) as
   SELECT   int_id
          , country_id AS client_id   
          , country_iso_cd            
          , country_group_id          
          , lisy_sort                 
          , dashboard_relevant_fg     
          , country_desc_AT
          , country_desc_BE
          , country_desc_BE_fr
          , country_desc_BG
          , country_desc_CH
          , country_desc_CY
          , country_desc_CZ
          , country_desc
          , country_desc_DK
		  , country_desc_EE
          , country_desc_ES
          , country_desc_FI
          , country_desc_FR
          , country_desc_GB
          , country_desc_GR
          , country_desc_HR
          , country_desc_HU
          , country_desc_IE
          , country_desc_IT
          , country_desc_LT
          , country_desc_NI
          , country_desc_NL
          , country_desc_LV
          , country_desc_DE
          , country_desc_PL
          , country_desc_PT
          , country_desc_RO
          , country_desc_SE
          , country_desc_SI
          , country_desc_SK
          , country_desc_CS
          , country_desc_MT
          , country_desc_US
          , country_desc_RS
          , CASE client_id WHEN 23 THEN '1973'
                           WHEN 12 THEN '04/1989'
                           WHEN 18 THEN '03/1992'
                           WHEN 10 THEN '04/1994'
                           WHEN 13 THEN '11/1994'
                           WHEN  2 THEN '04/1995'
                           WHEN 25 THEN '07/1995'
                           WHEN 22 THEN '10/1997'
                           WHEN  1 THEN '11/1998'
                           WHEN 21 THEN '05/1999'
                           WHEN 14 THEN '06/1999'
                           WHEN 17 THEN '07/2000'
                           WHEN 24 THEN '04/2002'
                           WHEN 11 THEN '08/2002'
                           WHEN  6 THEN '06/2003'
                           WHEN 27 THEN '09/2003'
                           WHEN 29 THEN '09/2004'
                           WHEN 16 THEN '11/2004'
                           WHEN  8 THEN '09/2005'
                           WHEN 15 THEN '11/2006'
                           WHEN 28 THEN '03/2007'
                           WHEN 32 THEN '04/2008'
                           WHEN  4 THEN '03/2009'
                           WHEN 31 THEN '02/2010'
                           WHEN 26 THEN '01/2010'
                           WHEN  3 THEN '01/2010'
                           WHEN  5 THEN '11/2010'
                           WHEN 19 THEN '03/2016'
				           WHEN 20 THEN '04/2020'
                           WHEN 33 THEN '01/2017'
                           WHEN 34 THEN '03/2018'
						   WHEN  9 THEN '03/2022'
                           ELSE '01/1900'
             END                                   AS country_opening_date
   FROM P_LEW_BIL.v_ref_country_lead_1;
