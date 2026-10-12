CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_CURRENT_SALES_PRICES_2 as
   SELECT
     country_cd,
   org_store_nr,
   orig_item_nr,
   dat_price,
   price,
   price_net
  FROM (

  SELECT
    pr.client_id    AS client_id,
   pr.country_cd   AS country_cd,
   pr.org_store_nr AS org_store_nr,
   pr.orig_item_nr AS orig_item_nr,
   pr.dat_price    AS dat_price,
   pr.price        AS price,
   pr.price_net    AS price_net,
   pr.migration_dat_valid_from AS migration_dat_valid_from,
   pr.migration_dat_valid_to   AS migration_dat_valid_to,
   ROW_NUMBER()  OVER(PARTITION BY   pr.client_id, pr.org_store_nr, pr.orig_item_nr, pr.dat_price ORDER BY price) AS counter

  FROM
  (
  SELECT
    client.client_id    AS client_id,
   client.country_cd   AS country_cd,
   stwh.orig_store_nr  AS org_store_nr,
   CAST(itm.config_item_cd  AS DECIMAL (30))  AS orig_item_nr,
   cal.cal_dt AS dat_price,
   COALESCE(itm_loc_sales.cond_val_adv, itm_loc_sales.cond_val, itm_loc_sales.cond_val_adv_cmpy, itm_loc_sales.cond_val_cmpy, itm_loc_sales.cond_val_adv_ent, itm_loc_sales.cond_val_ent) AS price,
   CAST(COALESCE(itm_loc_sales.net_val_adv, itm_loc_sales.net_val, itm_loc_sales.net_val_adv_cmpy, itm_loc_sales.net_val_cmpy, itm_loc_sales.net_val_adv_ent, itm_loc_sales.net_val_ent)  AS DECIMAL (38,6)) AS price_net,
   cal.cal_dt,
   mig.migration_dat_valid_from,
   mig.migration_dat_valid_to
  FROM p_lew_bil_ac.v_item_loc_sales_cond_denorm_2 AS itm_loc_sales
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse_2 AS stwh
   ON itm_loc_sales.client_id = stwh.client_id
   AND itm_loc_sales.loc_sid = stwh.loc_sid_store
   AND CURRENT_DATE BETWEEN stwh.dwh_valid_from AND stwh.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_cal_calendarday_2 AS cal
   ON cal.cal_dt BETWEEN itm_loc_sales.dwh_valid_from AND itm_loc_sales.dwh_valid_to
   AND cal.cal_dt BETWEEN CURRENT_DATE AND  CURRENT_DATE + 4 /* Es werden die Preise für Heute + 4 Tage wiedergegeben*/
   INNER JOIN p_lew_bil_ac.v_item_2 AS itm
   ON itm.client_id = itm_loc_sales.client_id
   AND itm.item_sid = itm_loc_sales.item_sid
   AND CURRENT_DATE BETWEEN itm.dwh_valid_from AND itm.dwh_valid_to
   AND itm.log_var_cd IN (2)
   AND itm_loc_sales.uom_sid_cond = itm.uom_sid_base
   INNER JOIN p_lew_core_ac.v_location_2 AS loc
   ON itm_loc_sales.client_id = loc.client_id
   AND itm_loc_sales.loc_sid = loc.loc_sid
   AND loc.wh_store_mark = 'A' /* Um nur auf Filialen zuzugreifen*/
   INNER JOIN p_lew_core_ac.v_item_info_per_location_hist_2 AS itm_loc
   ON itm_loc_sales.client_id = itm_loc.client_id
   AND itm_loc_sales.loc_sid  = itm_loc.loc_sid
   AND itm_loc_sales.item_sid = itm_loc.item_sid
   AND CURRENT_DATE BETWEEN itm_loc.dwh_valid_from AND itm_loc.dwh_valid_to
   INNER JOIN p_lew_process_mstr_ac.v_wfm_export_config_2 map1  /*BURA*/
   ON COALESCE(itm_loc.item_status_cd, 'NULL') = COALESCE(map1.item_status_cd,'NULL')  /*NULL  Werte sind gueltig */
   AND map1.interface_name = 'current_sales_prices'
   AND map1.active_fg = 1
   INNER JOIN p_lew_core_ac.v_client_2 AS client
   ON itm_loc_sales.client_id = client.client_id
   INNER JOIN p_lew_core_ac.v_client_migration_per_2 AS mig
   ON client.client_id = mig.client_id

   ) pr
   INNER JOIN(
   SELECT
        msl.client_id,
   msl.dat_open,
   msl.wh_loc_sid,
   b.orig_store_nr,
   msl.st_loc_sid
      FROM p_lew_process_ac.v_wawi_sys_md_storelist_2 msl
   INNER JOIN p_lew_core_ac.v_wawi_org_store_skey_act_2 b
   ON msl.client_id = b.client_id
   AND msl.st_loc_sid  = b.st_loc_sid
   AND msl.wh_loc_sid  = b.wh_loc_sid
 )mdsl
   ON pr.client_id = mdsl.client_id
   AND pr.cal_dt   = mdsl.dat_open
   AND pr.org_store_nr =mdsl.orig_store_nr

   ) main
   WHERE counter = 1
   AND NOT (price IS NULL OR price_net IS NULL) /*In der Basis-Tabelle gibt es Datensätze ohne Preise, die sind obsolet und dürfen nicht exportiert werden */
   /*Filter auf nur SAP Länder. Notwendig, da sichergestellt werden muss, dass aus den Tabellen nur die SAP Länder mitgenommen werden, bis die Integration 100% durch ist.*/
   AND Current_Date BETWEEN main.migration_dat_valid_from AND main.migration_dat_valid_to
;