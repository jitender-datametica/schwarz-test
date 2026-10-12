CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_adl_trend_transformed_1 (date, country_1, wh,
item_packagecapacity, trend_id, trend_type, active_fg, trend_value, trend_start_date, trend_end_date, mod_date,
source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp, item_nr)
OPTIONS(DESCRIPTION = `VERSION: 1.0 - INITIAL VERSION	 VERSION: 1.1 - ADJUST WH COLUMN NAME`) AS SELECT C.cal_dt AS date
 ,
 T.country_1,
 T.wh_nr AS wh,
 T.item_packagecapacity,
 T.trend_id,
 T.trend_type,
 T.active_fg,
 T.trend_value,
 T.trend_start_date,
 T.trend_end_date,
 T.mod_date,
 T.source_extraction_tmsp,
 T.snflk_insert_tmsp,
 T.snflk_update_tmsp,
 T.item_nr
FROM ldl_autodispo_core.t_oracle_v_fk_trend_adl_1 AS T
 INNER JOIN ldl_autodispo_fe_mstr_autodispo.v_dim_calendar_date_1 AS C ON C.cal_dt BETWEEN T.trend_start_date AND (COALESCE(T
    .trend_end_date, DATE_ADD(CURRENT_DATE, INTERVAL 28 DAY)))
WHERE T.active_fg = 1;