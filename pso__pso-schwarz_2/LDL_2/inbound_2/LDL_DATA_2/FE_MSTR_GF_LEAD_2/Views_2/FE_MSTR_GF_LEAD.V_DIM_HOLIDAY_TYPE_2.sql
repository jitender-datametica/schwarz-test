CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_HOLIDAY_TYPE_2(
holiday_type_cd COMMENT 'Holiday Type Code'
,holiday_name COMMENT 'Description for Holiday type in German'
,holiday_name_de COMMENT 'Description for Holiday type in German'
,holiday_name_en COMMENT 'Description for Holiday type in German'
) AS
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