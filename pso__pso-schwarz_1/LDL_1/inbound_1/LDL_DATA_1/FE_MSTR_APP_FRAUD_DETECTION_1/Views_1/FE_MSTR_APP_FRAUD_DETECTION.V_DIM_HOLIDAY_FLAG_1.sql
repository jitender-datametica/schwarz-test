CREATE OR REPLACE VIEW FE_MSTR_APP_FRAUD_DETECTION.V_DIM_HOLIDAY_FLAG_1 (
holiday_fg COMMENT 'Holiday Flag Id'
,holiday_fg_name COMMENT 'Description for Holiday flag in German'
,holiday_fg_name_de COMMENT 'Description for Holiday flag in German'
,holiday_fg_name_en COMMENT 'Description for Holiday flag in English'
) COMMENT = 'Lookup/mapping table for the  Attribute Holiday Flag (usage: Prompts in MSTR)' AS SELECT
1::NUMBER(38,0) AS holiday_fg
,'Ja'::VARCHAR(100) AS holiday_fg_name
,'Ja'::VARCHAR(100) AS holiday_fg_name_de
,'Yes'::VARCHAR(100) AS holiday_fg_name_en
UNION ALL 
SELECT
0::NUMBER(38,0) AS holiday_fg
,'Nein'::VARCHAR(100) AS holiday_fg_name
,'Nein'::VARCHAR(100) AS holiday_fg_name_de
,'No'::VARCHAR(100) AS holiday_fg_name_en
;