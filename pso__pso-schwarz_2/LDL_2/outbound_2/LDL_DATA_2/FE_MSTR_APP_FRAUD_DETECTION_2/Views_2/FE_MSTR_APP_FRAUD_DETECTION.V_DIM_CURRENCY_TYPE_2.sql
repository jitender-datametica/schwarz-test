CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_currency_type_2 (curr_type_id
OPTIONS(description='Column for Currency Type PK'), curr_type_name OPTIONS(description='Description for Currency Type'),
curr_type_name_de OPTIONS(description='Description for Currency Type in German'), curr_type_name_en
OPTIONS(description='Description for Currency Type in English'), curr_type_short_name
OPTIONS(description='Short Description for Currency Type'), curr_type_short_name_de
OPTIONS(description='Short Description for Currency Type in German'), curr_type_short_name_en
OPTIONS(description='Short Description for Currency Type in English'), curr_type_sort
OPTIONS(description='Sorting column for Currency Type'), curr_local_fg OPTIONS(description='Currency Local Flag'),
curr_group_fg OPTIONS(description='Currency Group Flag'))
OPTIONS(DESCRIPTION = `LOOKUP/MAPPING TABLE FOR THE TECHNICAL ATTRIBUTE CURRENCY TYPE (USAGE: PROMPTS IN MSTR)`) AS
SELECT 0 AS curr_type_id,
 'Gruppenwährung' AS curr_type_name,
 'Gruppenwährung' AS curr_type_name_de,
 'Group currency' AS curr_type_name_en,
 '€' AS curr_type_short_name,
 '€' AS curr_type_short_name_de,
 '€' AS curr_type_short_name_en,
 1 AS curr_type_sort,
 0 AS curr_local_fg,
 1 AS curr_group_fg
UNION ALL
SELECT 0 AS curr_type_id,
 'Gruppenwährung' AS curr_type_name,
 'Gruppenwährung' AS curr_type_name_de,
 'Group currency' AS curr_type_name_en,
 '€' AS curr_type_short_name,
 '€' AS curr_type_short_name_de,
 '€' AS curr_type_short_name_en,
 1 AS curr_type_sort,
 1 AS curr_local_fg,
 1 AS curr_group_fg
UNION ALL
SELECT 1 AS curr_type_id,
 'Landeswährung' AS curr_type_name,
 'Landeswährung' AS curr_type_name_de,
 'Local currency' AS curr_type_name_en,
 'LW' AS curr_type_short_name,
 'LW' AS curr_type_short_name_de,
 'LC' AS curr_type_short_name_en,
 2 AS curr_type_sort,
 1 AS curr_local_fg,
 0 AS curr_group_fg
UNION ALL
SELECT 1 AS curr_type_id,
 'Landeswährung' AS curr_type_name,
 'Landeswährung' AS curr_type_name_de,
 'Local currency' AS curr_type_name_en,
 'LW' AS curr_type_short_name,
 'LW' AS curr_type_short_name_de,
 'LC' AS curr_type_short_name_en,
 2 AS curr_type_sort,
 1 AS curr_local_fg,
 1 AS curr_group_fg;