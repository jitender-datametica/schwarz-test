CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_indicator_week AS SELECT client_id,
 org_type_id,
 org_unit_nr,
 indicator_id,
 indicator_type_id,
 cy,
 cal_week,
 val_indicator,
 dat_dayend,
 load_id
FROM ldl_p_lew_core_ac.v_wawi_indicator_week;