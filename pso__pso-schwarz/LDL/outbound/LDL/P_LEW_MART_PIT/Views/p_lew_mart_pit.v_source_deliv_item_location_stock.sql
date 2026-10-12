CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_deliv_item_location_stock
OPTIONS(DESCRIPTION = `V_SOURCE_DELIV_ITEM_LOCATION_STOCK`) AS SELECT CAST(client_id AS BIGNUMERIC) AS client_id,
 CAST(item_sid AS BIGNUMERIC) AS item_sid,
 CAST(loc_sid AS BIGNUMERIC) AS store_sid,
 CAST(diff_qty_inv_calc AS BIGNUMERIC) AS diff_qty_inv_calc,
 CAST(calc_qty AS BIGNUMERIC) AS calc_qty,
 CAST(inv_qty AS BIGNUMERIC) AS inv_qty,
 CAST(price AS BIGNUMERIC) AS stc_price_gross_val,
 CAST(IF(IFNULL(diff_qty_inv_calc, 0) = 0, calc_qty, inv_qty) AS BIGNUMERIC) AS item_stock_real_qty,
 COALESCE(DATE(dwh_valid_from), PARSE_DATE('%F', '1900-01-01')) AS valid_from_dt,
 DATE(ldl_p_lew_mart_pit.f_cleanvalidtodate(dwh_valid_to)) AS valid_to_dt,
 COALESCE(CAST(deleted_fg AS BIGNUMERIC), 0) AS deleted_fg,
 dwh_updated AS dwh_updated_ts
FROM ldl_p_lew_core.t_item_location_stock_hist AS STC;