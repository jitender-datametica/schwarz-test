CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_despatch_advice_status_hist_2 (client_id
OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'), wh_loc_sid
OPTIONS(description='Surrogate Key warehouse, foreign key on location.'), despatch_advice_id
OPTIONS(description='''Identifier of the individual despatch advice at a warehouse.
Row number of the WAWI source table T0020_DESPATCH_ADVICE_2 in the local WAWI system.'''),
despatch_advice_status_id
OPTIONS(description='Status_2 ID of the despatch advice such as open, booked, invalid, differences, deleted.'), deleted_fg
OPTIONS(description='Attribute set was not delivered by source system (anymore), if deleted_fg=1.'), dwh_valid_from
OPTIONS(description='Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = '''The table stores changes to despatch advices from supplieres in warehouse.
Source: WAWI table: T0020_DESPATCH_ADVICE_2''')
AS SELECT client_id,
 wh_loc_sid,
 despatch_advice_id,
 despatch_advice_status_id,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_despatch_advice_status_hist_2;