CREATE OR REPLACE VIEW FE_MSTR_IOTCHARGERS.V_DIM_CHARGER_AUTHENTICATION_METHOD_1(
	AUTHENTICATION_METHOD_CD
	, AUTHENTICATION_METHOD_NAME
    , AUTHENTICATION_METHOD_LOGO
) AS
SELECT 
	AUTHENTICATION_METHOD_CD
	, AUTHENTICATION_METHOD_NAME
    , CONCAT(
             'https://mis'
			 , CASE 
                   WHEN CURRENT_DATABASE() = 'SZD_PRODUCTION' THEN ''
                   WHEN CURRENT_DATABASE() = 'SZD_QUALITY' THEN '-qas'
                   ELSE '-dev'
              END
			  , '.schwarz/MicroStrategy/images/_custom/iotchargers/authentication_methods/'
			  , CASE 
                   WHEN AUTHENTICATION_METHOD_CD <> '-1' THEN AUTHENTICATION_METHOD_CD 
                   ELSE 'UNKNOWN' 
              END
			  , '.png'
            )
FROM CORE.T_DIM_CHARGER_AUTHENTICATION_METHOD_1
;