create or replace view SZD_PRODUCTION.FE_MSTR_IOTCHARGERS.V_DIM_COUNTRY_POLITICAL_2(
	ISO_COUNTRY_CD,
	COUNTRY_NAME_EN,
	COUNTRY_NAME_DE,
	CURR_CD,
	LATITUDE,
	LONGITUDE,
	EU_MEMBER_FG,
	COUNTRY_FLAG
) as
SELECT 
	  ISO_COUNTRY_CD
	, COUNTRY_NAME_EN	
    , COUNTRY_NAME_DE
    , CURR_CD
    , LATITUDE
    , LONGITUDE    
    , EU_MEMBER_FG
    , CONCAT(
             'https://mis'
             , CASE 
                   WHEN CURRENT_DATABASE() = 'SZD_PRODUCTION' THEN ''
                   WHEN CURRENT_DATABASE() = 'SZD_QUALITY' THEN '-qas'
                   ELSE '-dev'
              END
              , '.schwarz/MicroStrategy/images/_custom/iotchargers/flags/'
              , CASE 
                   WHEN ISO_COUNTRY_CD <> '-1' THEN ISO_COUNTRY_CD 
                   ELSE 'UNKNOWN' 
              END
              , '.png'
            )
FROM CORE.T_DIM_COUNTRY_POLITICAL_2
WHERE DWH_VALID_FG = TRUE
;