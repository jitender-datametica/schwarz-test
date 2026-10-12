create or replace view LDL_DATA_PRODUCTION.FE_MSTR_APP_FRAUD_DETECTION.V_DIM_CURRENCY_TYPE(
	CURR_TYPE_ID COMMENT 'Column for Currency Type PK',
	CURR_TYPE_NAME COMMENT 'Description for Currency Type',
	CURR_TYPE_NAME_DE COMMENT 'Description for Currency Type in German',
	CURR_TYPE_NAME_EN COMMENT 'Description for Currency Type in English',
	CURR_TYPE_SHORT_NAME COMMENT 'Short Description for Currency Type',
	CURR_TYPE_SHORT_NAME_DE COMMENT 'Short Description for Currency Type in German',
	CURR_TYPE_SHORT_NAME_EN COMMENT 'Short Description for Currency Type in English',
	CURR_TYPE_SORT COMMENT 'Sorting column for Currency Type',
	CURR_LOCAL_FG COMMENT 'Currency Local Flag',
	CURR_GROUP_FG COMMENT 'Currency Group Flag'
) COMMENT='Lookup/mapping table for the Technical Attribute Currency Type (usage: Prompts in MSTR)'
 as SELECT
0::NUMBER(38,0) AS curr_type_id
,'Gruppenwährung'::VARCHAR(100) AS curr_type_name
,'Gruppenwährung'::VARCHAR(100) AS curr_type_name_de
,'Group currency'::VARCHAR(100) AS curr_type_name_en
,'€'::VARCHAR(100) AS curr_type_short_name
,'€'::VARCHAR(100) AS curr_type_short_name_de
,'€'::VARCHAR(100) AS curr_type_short_name_en
,1::NUMBER(38,0) AS curr_type_sort
,0::NUMBER(38,0) AS curr_local_fg
,1::NUMBER(38,0)  AS curr_group_fg 
UNION ALL 
SELECT
0::NUMBER(38,0) AS curr_type_id
,'Gruppenwährung'::VARCHAR(100) AS curr_type_name
,'Gruppenwährung'::VARCHAR(100) AS curr_type_name_de
,'Group currency'::VARCHAR(100) AS curr_type_name_en
,'€'::VARCHAR(100) AS curr_type_short_name
,'€'::VARCHAR(100) AS curr_type_short_name_de
,'€'::VARCHAR(100) AS curr_type_short_name_en
,1::NUMBER(38,0) AS curr_type_sort
,1::NUMBER(38,0) AS curr_local_fg
,1::NUMBER(38,0)  AS curr_group_fg 
UNION ALL
SELECT
1::NUMBER(38,0) AS curr_type_id
,'Landeswährung'::VARCHAR(100) AS curr_type_name
,'Landeswährung'::VARCHAR(100) AS curr_type_name_de
,'Local currency'::VARCHAR(100) AS curr_type_name_en
,'LW'::VARCHAR(100) AS curr_type_short_name
,'LW'::VARCHAR(100) AS curr_type_short_name_de
,'LC'::VARCHAR(100) AS curr_type_short_name_en
,2::NUMBER(38,0) AS curr_type_sort
,1::NUMBER(38,0) AS curr_local_fg
,0::NUMBER(38,0)  AS curr_group_fg 
UNION ALL
SELECT
1::NUMBER(38,0) AS curr_type_id
,'Landeswährung'::VARCHAR(100) AS curr_type_name
,'Landeswährung'::VARCHAR(100) AS curr_type_name_de
,'Local currency'::VARCHAR(100) AS curr_type_name_en
,'LW'::VARCHAR(100) AS curr_type_short_name
,'LW'::VARCHAR(100) AS curr_type_short_name_de
,'LC'::VARCHAR(100) AS curr_type_short_name_en
,2::NUMBER(38,0) AS curr_type_sort
,1::NUMBER(38,0) AS curr_local_fg
,1::NUMBER(38,0)  AS curr_group_fg;