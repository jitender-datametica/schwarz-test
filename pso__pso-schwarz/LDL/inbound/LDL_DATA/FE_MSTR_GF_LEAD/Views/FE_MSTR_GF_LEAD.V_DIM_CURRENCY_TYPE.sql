CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_DIM_CURRENCY_TYPE (
curr_type_id COMMENT 'Column for Currency Type PK'
,curr_type_name COMMENT 'Description for Currency Type'
,curr_type_name_de COMMENT 'Description for Currency Type in German'
,curr_type_name_en COMMENT 'Description for Currency Type in English'
,curr_type_short_name COMMENT 'Short Description for Currency Type'
,curr_type_short_name_de COMMENT 'Short Description for Currency Type in German'
,curr_type_short_name_en COMMENT 'Short Description for Currency Type in English'
,curr_type_sort COMMENT 'Sorting column for Currency Type'
,curr_local_fg COMMENT 'Currency Local Flag'
,curr_group_fg COMMENT 'Currency Group Flag'
) COMMENT = 'Lookup/mapping table for the Technical Attribute Currency Type (usage: Prompts in MSTR)' AS SELECT
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