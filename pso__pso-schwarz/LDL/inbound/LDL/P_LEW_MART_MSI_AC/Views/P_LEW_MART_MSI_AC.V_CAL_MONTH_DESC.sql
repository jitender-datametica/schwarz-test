create or replace view LDL_PRODUCTION.P_LEW_MART_MSI_AC.V_CAL_MONTH_DESC(
	MONTH_ID COMMENT 'Month number in calendar year: i.e. in range 1-12.',
	CY_MONTH COMMENT 'Calendar month in form YYYYMM.',
	CY COMMENT 'Calendar year in form YYYY.',
	BYR COMMENT 'Business year in form YYYY.',
	CY_MONTH_NAME_AT COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code AT.',
	CY_MONTH_NAME_BE COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code BE.',
	CY_MONTH_NAME_BE_FR COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code BE_FR.',
	CY_MONTH_NAME_BG COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code BG.',
	CY_MONTH_NAME_CH COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code CH.',
	CY_MONTH_NAME_CY COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code CY.',
	CY_MONTH_NAME_CZ COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code CZ.',
	CY_MONTH_NAME COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the organization (German).',
	CY_MONTH_NAME_DK COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code DK.',
	CY_MONTH_NAME_EE COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code EE.',
	CY_MONTH_NAME_ES COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code ES.',
	CY_MONTH_NAME_FI COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code FI.',
	CY_MONTH_NAME_FR COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code FR.',
	CY_MONTH_NAME_GB COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code GB.',
	CY_MONTH_NAME_GR COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code GR.',
	CY_MONTH_NAME_HR COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code HR.',
	CY_MONTH_NAME_HU COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code HU.',
	CY_MONTH_NAME_IE COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code IE.',
	CY_MONTH_NAME_IT COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code IT.',
	CY_MONTH_NAME_LT COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code LT.',
	CY_MONTH_NAME_LV COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code LV.',
	CY_MONTH_NAME_NI COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code NI.',
	CY_MONTH_NAME_NL COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code NL.',
	CY_MONTH_NAME_DE COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code DE.',
	CY_MONTH_NAME_PL COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code PL.',
	CY_MONTH_NAME_PT COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code PT.',
	CY_MONTH_NAME_RO COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code RO.',
	CY_MONTH_NAME_SE COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code SE.',
	CY_MONTH_NAME_SI COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code SI.',
	CY_MONTH_NAME_SK COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code SK.',
	CY_MONTH_NAME_CS COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code CS.',
	CY_MONTH_NAME_MT COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code MT.',
	CY_MONTH_NAME_US COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code US.',
	CY_MONTH_NAME_RS COMMENT 'Month name + Calendar year in the form \""Name YYYY\"" where \""Name\"" is the name of the month in the language associated with the country of code RS.',
	CY_MONTH_NAME_SHORT_AT COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code AT.',
	CY_MONTH_NAME_SHORT_BE COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code BE.',
	CY_MONTH_NAME_SHORT_BE_FR COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code BE_fr.',
	CY_MONTH_NAME_SHORT_BG COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code BG.',
	CY_MONTH_NAME_SHORT_CH COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code CH.',
	CY_MONTH_NAME_SHORT_CY COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code CY.',
	CY_MONTH_NAME_SHORT_CZ COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code CZ.',
	CY_MONTH_NAME_SHORT COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the  organization (German).',
	CY_MONTH_NAME_SHORT_DK COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code DK.',
	CY_MONTH_NAME_SHORT_EE COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code EE.',
	CY_MONTH_NAME_SHORT_ES COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code ES.',
	CY_MONTH_NAME_SHORT_FI COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code FI.',
	CY_MONTH_NAME_SHORT_FR COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code FR.',
	CY_MONTH_NAME_SHORT_GB COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code GB.',
	CY_MONTH_NAME_SHORT_GR COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code GR.',
	CY_MONTH_NAME_SHORT_HR COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code HR.',
	CY_MONTH_NAME_SHORT_HU COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code HU.',
	CY_MONTH_NAME_SHORT_IE COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code IE.',
	CY_MONTH_NAME_SHORT_IT COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code IT.',
	CY_MONTH_NAME_SHORT_LT COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code LT.',
	CY_MONTH_NAME_SHORT_LV COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code LV.',
	CY_MONTH_NAME_SHORT_NI COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code NI.',
	CY_MONTH_NAME_SHORT_NL COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code NL.',
	CY_MONTH_NAME_SHORT_DE COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code DE.',
	CY_MONTH_NAME_SHORT_PL COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code PL.',
	CY_MONTH_NAME_SHORT_PT COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code PT.',
	CY_MONTH_NAME_SHORT_RO COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code RO.',
	CY_MONTH_NAME_SHORT_SE COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code SE.',
	CY_MONTH_NAME_SHORT_SI COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code SI.',
	CY_MONTH_NAME_SHORT_SK COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code SK.',
	CY_MONTH_NAME_SHORT_CS COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code CS.',
	CY_MONTH_NAME_SHORT_MT COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code MT.',
	CY_MONTH_NAME_SHORT_US COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code US.',
	CY_MONTH_NAME_SHORT_RS COMMENT 'Short month name in the form \""MMM\"" where \""MMM\"" are the first 3 characters of the name of the month in the language associated with the country of code RS.',
	MONTH_NAME_AT COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code AT.',
	MONTH_NAME_BE COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code BE.',
	MONTH_NAME_BE_FR COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code BE_fr.',
	MONTH_NAME_BG COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code BG.',
	MONTH_NAME_CH COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code CH.',
	MONTH_NAME_CY COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code CY.',
	MONTH_NAME_CZ COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code CZ.',
	MONTH_NAME COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the organization (German).',
	MONTH_NAME_DK COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code DK.',
	MONTH_NAME_EE COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code EE.',
	MONTH_NAME_ES COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code ES.',
	MONTH_NAME_FI COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code FI.',
	MONTH_NAME_FR COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code FR.',
	MONTH_NAME_GB COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code GB.',
	MONTH_NAME_GR COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code GR.',
	MONTH_NAME_HR COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code HR.',
	MONTH_NAME_HU COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code HU.',
	MONTH_NAME_IE COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code IE.',
	MONTH_NAME_IT COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code IT.',
	MONTH_NAME_LT COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code LT.',
	MONTH_NAME_LV COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code LV.',
	MONTH_NAME_NI COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code NI.',
	MONTH_NAME_NL COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code NL.',
	MONTH_NAME_DE COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code DE.',
	MONTH_NAME_PL COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code PL.',
	MONTH_NAME_PT COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code PT.',
	MONTH_NAME_RO COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code RO.',
	MONTH_NAME_SE COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code SE.',
	MONTH_NAME_SI COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code SI.',
	MONTH_NAME_SK COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code SK.',
	MONTH_NAME_CS COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code CS.',
	MONTH_NAME_MT COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code MT.',
	MONTH_NAME_US COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code US.',
	MONTH_NAME_RS COMMENT 'Month name only in the form \""Name\"" where \""Name\"" is the name of the month in the language associated with the country of code RS.'
) COMMENT='Multi language month name reference'
 as
SELECT   month_id
       , cy_month
       , cy
       , byr
       , cy_month_name_AT
       , cy_month_name_BE
       , cy_month_name_BE_FR
       , cy_month_name_BG
       , cy_month_name_CH
       , cy_month_name_CY
       , cy_month_name_CZ
       , cy_month_name
       , cy_month_name_DK
       , cy_month_name_EE
       , cy_month_name_ES
       , cy_month_name_FI
       , cy_month_name_FR
       , cy_month_name_GB
       , cy_month_name_GR
       , cy_month_name_HR
       , cy_month_name_HU
       , cy_month_name_IE
       , cy_month_name_IT
       , cy_month_name_LT
       , cy_month_name_LV
       , cy_month_name_NI
       , cy_month_name_NL
       , cy_month_name_DE
       , cy_month_name_PL
       , cy_month_name_PT
       , cy_month_name_RO
       , cy_month_name_SE
       , cy_month_name_SI
       , cy_month_name_SK
       , cy_month_name_CS
       , cy_month_name_MT
       , cy_month_name_US
       , cy_month_name_RS
       , cy_month_name_short_AT
       , cy_month_name_short_BE
       , cy_month_name_short_BE_FR
       , cy_month_name_short_BG
       , cy_month_name_short_CH
       , cy_month_name_short_CY
       , cy_month_name_short_CZ
       , cy_month_name_short
       , cy_month_name_short_DK
       , cy_month_name_short_EE
       , cy_month_name_short_ES
       , cy_month_name_short_FI
       , cy_month_name_short_FR
       , cy_month_name_short_GB
       , cy_month_name_short_GR
       , cy_month_name_short_HR
       , cy_month_name_short_HU
       , cy_month_name_short_IE
       , cy_month_name_short_IT
       , cy_month_name_short_LT
       , cy_month_name_short_LV
       , cy_month_name_short_NI
       , cy_month_name_short_NL
       , cy_month_name_short_DE
       , cy_month_name_short_PL
       , cy_month_name_short_PT
       , cy_month_name_short_RO
       , cy_month_name_short_SE
       , cy_month_name_short_SI
       , cy_month_name_short_SK
       , cy_month_name_short_CS
       , cy_month_name_short_MT
       , cy_month_name_short_US
       , cy_month_name_short_RS
       , month_name_AT
       , month_name_BE
       , month_name_BE_FR
       , month_name_BG
       , month_name_CH
       , month_name_CY
       , month_name_CZ
       , month_name
       , month_name_DK
       , month_name_EE
       , month_name_ES
       , month_name_FI
       , month_name_FR
       , month_name_GB
       , month_name_GR
       , month_name_HR
       , month_name_HU
       , month_name_IE
       , month_name_IT
       , month_name_LT
       , month_name_LV
       , month_name_NI
       , month_name_NL
       , month_name_DE
       , month_name_PL
       , month_name_PT
       , month_name_RO
       , month_name_SE
       , month_name_SI
       , month_name_SK
       , month_name_CS
       , month_name_MT
       , month_name_US
       , month_name_RS
  FROM P_LEW_MART_MSI.v_cal_month_desc
;
