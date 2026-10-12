CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_BRAND_ELWIS
   AS
      SELECT    item_sid_config,
      brand
      FROM p_lew_process.v_brand_elwis;