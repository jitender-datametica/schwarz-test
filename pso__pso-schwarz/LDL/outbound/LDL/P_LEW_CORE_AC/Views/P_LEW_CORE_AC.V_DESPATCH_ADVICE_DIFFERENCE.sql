CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_despatch_advice_difference (client_id
OPTIONS(description='DWH-Mandant; FK auf CLIENT'), wh_loc_sid
OPTIONS(description='Surrogate Key warehouse, foreign key on location.'), despatch_advice_diff_sid
OPTIONS(description='''Surrogate Key based on difference per despatch advice (and warehouse). Usually one line for all differences per item.
C0025_despatch_adviceid and C0025_id'''),
despatch_advice_id
OPTIONS(description='Reference to a despatch advice, if a despatch advice technically has been used in the counting process.'),
despatch_advice_diff_nr
OPTIONS(description='Number of the individual item difference entered for a despatch advice delivered. It is the row number of the difference in the source system, the natural key.'),
src_orig_wh_nr OPTIONS(description='Techn. identifier of warehouses in WAWI source system.'), diff_create_dt
OPTIONS(description='Date on which the despatch advice difference item was entered.'), diff_create_tmsp
OPTIONS(description='Point in time at which the despatch advice difference item was entered.'), diff_change_dt
OPTIONS(description='Date on which the despatch advice difference item was modified.'), diff_change_tmsp
OPTIONS(description='Point in time at which the despatch advice difference item was modified.'), dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = '''Differences between despatch advices and purchase orders, checked at the warehouse.
Source: WAWI table: T0025_DESPATCH_ADVICE_DIFFERENCES''')
AS SELECT client_id,
 wh_loc_sid,
 despatch_advice_diff_sid,
 despatch_advice_id,
 despatch_advice_diff_nr,
 src_orig_wh_nr,
 diff_create_dt,
 diff_create_tmsp,
 diff_change_dt,
 diff_change_tmsp,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_despatch_advice_difference;