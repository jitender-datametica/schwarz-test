CREATE OR REPLACE VIEW ldl_data_fe_mstr_app_fraud_detection.v_dim_holiday_flag (holiday_fg
OPTIONS(description='Holiday Flag Id'), holiday_fg_name OPTIONS(description='Description for Holiday flag in German'),
holiday_fg_name_de OPTIONS(description='Description for Holiday flag in German'), holiday_fg_name_en
OPTIONS(description='Description for Holiday flag in English'))
OPTIONS(DESCRIPTION = `LOOKUP/MAPPING TABLE FOR THE  ATTRIBUTE HOLIDAY FLAG (USAGE: PROMPTS IN MSTR)`) AS SELECT 1 AS
 holiday_fg,
 'Ja' AS holiday_fg_name,
 'Ja' AS holiday_fg_name_de,
 'Yes' AS holiday_fg_name_en
UNION ALL
SELECT 0 AS holiday_fg,
 'Nein' AS holiday_fg_name,
 'Nein' AS holiday_fg_name_de,
 'No' AS holiday_fg_name_en;