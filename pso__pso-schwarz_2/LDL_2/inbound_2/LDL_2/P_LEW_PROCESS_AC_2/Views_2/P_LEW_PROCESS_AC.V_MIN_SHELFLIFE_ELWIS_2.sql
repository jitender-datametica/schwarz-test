CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_MIN_SHELFLIFE_ELWIS_2
   AS
      SELECT    item_sid_config,
      min_consumption_day_cnt,
      min_shelflife_to_store_day_cnt,
      min_shelflife_to_wh_day_cnt
      FROM p_lew_process.v_min_shelflife_elwis_2;