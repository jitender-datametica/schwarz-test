CREATE TABLE P_LEW_CORE.T_ITEM_WH_STOCK_NFB_1 
     (
      client_id SMALLINT NOT NULL,
      loc_sid INTEGER NOT NULL,
      item_sid INTEGER NOT NULL,
      active_from_dt DATE  NOT NULL,
      active_to_dt DATE  NOT NULL,
      stock_change_seq INTEGER NOT NULL,
      nfb_type_id SMALLINT NOT NULL,
      delta_case_qty DECIMAL(18,5),
      calc_stock_case_qty DECIMAL(18,5),
      retail_price DECIMAL(18,5),
      retail_net_price DECIMAL(18,5),
      vat_total_val DECIMAL(18,5),
      modification_dt DATE ,
      delta_day_dt DATE  NOT NULL,
      deleted_fg INTEGER NOT NULL,
      dwh_load_id INTEGER NOT NULL,
      dwh_created TIMESTAMP(6) NOT NULL,
      dwh_updated TIMESTAMP(6) NOT NULL,
UNIQUE ( client_id ,loc_sid ,
item_sid ,active_from_dt ))
;
