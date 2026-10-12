CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_despatch_advice_difference_check_hist_2 (client_id
OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'), wh_loc_sid
OPTIONS(description='Surrogate Key warehouse, foreign key on location.'), despatch_advice_diff_sid
OPTIONS(description='''Surrogate Key based on difference per despatch advice (and warehouse).
C0025_despatch_adviceid and C0025_id'''),
despatch_advice_check_type_id OPTIONS(description='Code of the despatch advice difference check type.'),
despatch_advice_check_type_fg OPTIONS(description='Flag: Set if difference exists.'),
despatch_advice_check_type_value_id OPTIONS(description='Code of the check type value for differences checked'),
deleted_fg OPTIONS(description='Attribute set was not delivered by source system (anymore), if deleted_fg=1.'),
dwh_valid_from
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = '''Table with all the checks and its changes during the checks. Each difference can have multiple checks.
Source: WAWI table: T0025_DESPATCH_ADVICE_DIFFERENCE''')
AS SELECT client_id,
 wh_loc_sid,
 despatch_advice_diff_sid,
 despatch_advice_check_type_id,
 despatch_advice_check_type_fg,
 despatch_advice_check_type_value_id,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_despatch_advice_difference_check_hist_2;