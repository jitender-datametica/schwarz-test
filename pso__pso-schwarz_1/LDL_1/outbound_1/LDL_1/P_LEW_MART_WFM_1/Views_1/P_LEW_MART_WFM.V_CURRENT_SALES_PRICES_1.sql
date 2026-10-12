CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_current_sales_prices_1 AS
/* Es werden die Preise für Heute + 4 Tage wiedergegeben */ /* BURA */ /* NULL  Werte sind gueltig */
/* In der Basis-Tabelle gibt es Datensätze ohne Preise, die sind obsolet und dürfen nicht exportiert werden */
/* Filter auf nur SAP Länder. Notwendig, da sichergestellt werden muss, dass aus den Tabellen nur die SAP Länder mitgenommen werden, bis die Integration 100% durch ist. */
SELECT pr.country_cd,
 pr.org_store_nr,
 pr.orig_item_nr,
 pr.dat_price,
 pr.price,
 pr.price_net
FROM (SELECT CLIENT.client_id,
   CLIENT.country_cd,
   STWH.orig_store_nr AS org_store_nr,
   ROUND(CAST(ITM.config_item_cd AS BIGNUMERIC), 0) AS orig_item_nr,
   CAL.cal_dt AS dat_price,
   COALESCE(ITM_LOC_SALES.cond_val_adv, ITM_LOC_SALES.cond_val, ITM_LOC_SALES.cond_val_adv_cmpy, ITM_LOC_SALES.cond_val_cmpy
    , ITM_LOC_SALES.cond_val_adv_ent, ITM_LOC_SALES.cond_val_ent) AS price,
   CAST(COALESCE(ITM_LOC_SALES.net_val_adv, ITM_LOC_SALES.net_val, ITM_LOC_SALES.net_val_adv_cmpy, ITM_LOC_SALES.net_val_cmpy, ITM_LOC_SALES.net_val_adv_ent, ITM_LOC_SALES.net_val_ent) AS BIGNUMERIC)
   AS price_net,
   CAL.cal_dt,
   MIG.migration_dat_valid_from,
   MIG.migration_dat_valid_to
  FROM ldl_p_lew_bil_ac.v_item_loc_sales_cond_denorm_1 AS ITM_LOC_SALES
   INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_1 AS STWH ON ITM_LOC_SALES.client_id = STWH.client_id AND
      ITM_LOC_SALES.loc_sid = STWH.loc_sid_store AND CURRENT_DATE BETWEEN STWH.dwh_valid_from AND STWH.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL ON CAL.cal_dt BETWEEN ITM_LOC_SALES.dwh_valid_from AND
     ITM_LOC_SALES.dwh_valid_to AND CAL.cal_dt BETWEEN CURRENT_DATE AND (DATE_ADD(CURRENT_DATE, INTERVAL 4 DAY))
   INNER JOIN ldl_p_lew_bil_ac.v_item_1 AS ITM ON ITM_LOC_SALES.client_id = ITM.client_id AND ITM_LOC_SALES.item_sid = ITM
        .item_sid AND CURRENT_DATE BETWEEN ITM.dwh_valid_from AND ITM.dwh_valid_to AND CAST(ITM.log_var_cd AS INTEGER)
      IN (2) AND ITM_LOC_SALES.uom_sid_cond = ITM.uom_sid_base
   INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC ON ITM_LOC_SALES.client_id = LOC.client_id AND ITM_LOC_SALES.loc_sid =
      LOC.loc_sid AND LOC.wh_store_mark = 'A' /* Um nur auf Filialen zuzugreifen */
   INNER JOIN ldl_p_lew_core_ac.v_item_info_per_location_hist_1 AS ITM_LOC ON ITM_LOC_SALES.client_id = ITM_LOC.client_id
      AND ITM_LOC_SALES.loc_sid = ITM_LOC.loc_sid AND ITM_LOC_SALES.item_sid = ITM_LOC.item_sid AND CURRENT_DATE BETWEEN
     ITM_LOC.dwh_valid_from AND ITM_LOC.dwh_valid_to
   INNER JOIN ldl_p_lew_process_mstr_ac.v_wfm_export_config_1 AS MAP1 ON COALESCE(ITM_LOC.item_status_cd, 'NULL') =
      COALESCE(MAP1.item_status_cd, 'NULL') AND MAP1.interface_name = 'current_sales_prices' AND MAP1.active_fg = 1
   INNER JOIN ldl_p_lew_core_ac.v_client_1 AS CLIENT ON ITM_LOC_SALES.client_id = CLIENT.client_id
   INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIG ON CLIENT.client_id = MIG.client_id) AS pr
 INNER JOIN (SELECT MSL.client_id,
   MSL.dat_open,
   MSL.wh_loc_sid,
   B.orig_store_nr,
   MSL.st_loc_sid
  FROM ldl_p_lew_process_ac.v_wawi_sys_md_storelist_1 AS MSL
   INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_skey_act_1 AS B ON MSL.client_id = B.client_id AND MSL.st_loc_sid = B.st_loc_sid
       AND MSL.wh_loc_sid = B.wh_loc_sid) AS mdsl ON pr.client_id = mdsl.client_id AND pr.cal_dt = mdsl.dat_open AND pr
   .org_store_nr = mdsl.orig_store_nr
QUALIFY (ROW_NUMBER() OVER (PARTITION BY pr.client_id, CAST(pr.org_store_nr AS STRING), CAST(pr.orig_item_nr AS STRING)
        , pr.dat_price ORDER BY pr.price IS NULL, pr.price)) = 1 AND CURRENT_DATE BETWEEN pr.migration_dat_valid_from
    AND pr.migration_dat_valid_to AND pr.price IS NOT NULL;