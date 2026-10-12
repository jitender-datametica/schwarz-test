create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_DIM_HOLIDAY_FLAG_1(
	HOLIDAY_FG COMMENT 'Holiday Flag Id',
	HOLIDAY_FG_NAME COMMENT 'Description for Holiday flag in German',
	HOLIDAY_FG_NAME_DE COMMENT 'Description for Holiday flag in German',
	HOLIDAY_FG_NAME_EN COMMENT 'Description for Holiday flag in English'
) COMMENT='Lookup/mapping table for the  Attribute Holiday Flag (usage: Prompts in MSTR)'
 as SELECT
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