create or replace view SZD_PRODUCTION.FE_MSTR_IOTCHARGERS.V_DIM_DIVISION_2(
	DIVISION_CD,
	DIVISION_NAME,
	DIVISION_LOGO
) as
SELECT 
	DIVISION_CD
	, DIVISION_NAME
	, CONCAT(
             'https://mis'
			 , CASE 
                   WHEN CURRENT_DATABASE() = 'SZD_PRODUCTION' THEN ''
                   WHEN CURRENT_DATABASE() = 'SZD_QUALITY' THEN '-qas'
                   ELSE '-dev'
              END
			  , '.schwarz/MicroStrategy/images/_custom/iotchargers/divisions/'
			  , CASE 
                   WHEN DIVISION_CD <> '-1' THEN DIVISION_CD 
                   ELSE 'UNKNOWN' 
              END
			  , '.png'
            )
FROM CORE.T_DIM_DIVISION_2
WHERE DWH_VALID_TO_TMSP >= '9999-12-31'
;