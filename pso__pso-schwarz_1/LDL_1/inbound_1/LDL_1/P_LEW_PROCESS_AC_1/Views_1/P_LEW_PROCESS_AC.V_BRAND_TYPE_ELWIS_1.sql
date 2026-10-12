CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_BRAND_TYPE_ELWIS_1
      AS
         SELECT    item_sid_config,
         brand_type_cd
         FROM p_lew_process.v_brand_type_elwis_1;