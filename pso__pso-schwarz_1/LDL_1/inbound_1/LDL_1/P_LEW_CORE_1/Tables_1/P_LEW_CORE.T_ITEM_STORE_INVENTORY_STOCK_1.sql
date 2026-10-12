CREATE TABLE P_LEW_CORE.T_ITEM_STORE_INVENTORY_STOCK_1
     (
      client_id SMALLINT NOT NULL,
      loc_sid INTEGER NOT NULL,
      item_sid INTEGER NOT NULL,
      inv_status_id SMALLINT,
      inv_stock_qty DECIMAL(18,5),
      calc_stock_qty DECIMAL(18,5) ,
      inv_calc_stock_diff DECIMAL(18,5),
      retail_price DECIMAL(18,5),
      retail_net_price DECIMAL(18,5),
      retail_price_diff DECIMAL(18,5),
      retail_net_price_diff DECIMAL(18,5),
      dayend_dt DATE  NOT NULL,
      dwh_cal_dt DATE  NOT NULL,
      dwh_load_id INTEGER NOT NULL,
      dwh_created TIMESTAMP(6) NOT NULL,
      dwh_updated TIMESTAMP(6) NOT NULL,
      unique(client_id ,loc_sid ,item_sid ,dwh_cal_dt))
;