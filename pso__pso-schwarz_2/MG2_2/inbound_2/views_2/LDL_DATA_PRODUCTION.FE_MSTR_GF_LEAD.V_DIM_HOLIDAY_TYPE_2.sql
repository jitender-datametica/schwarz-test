create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_HOLIDAY_TYPE_2(
	HOLIDAY_TYPE_CD COMMENT 'Holiday Type Code',
	HOLIDAY_NAME COMMENT 'Description for Holiday type in German',
	HOLIDAY_NAME_DE COMMENT 'Description for Holiday type in German',
	HOLIDAY_NAME_EN COMMENT 'Description for Holiday type in German'
) as
SELECT DISTINCT 
holiday_name AS holiday_type_cd
,holiday_name AS holiday_name
,holiday_name AS holiday_name_de
,holiday_name AS holiday_name_en
FROM CORE_DIM.T_FACT_NATIONAL_HOLIDAY_2
UNION ALL
SELECT
'NA' AS holiday_name
,'' AS holiday_name
,'' AS holiday_name_de
,'' AS holiday_name_en;