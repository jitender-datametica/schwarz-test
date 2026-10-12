CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ADV_ITEM_ADVERTISING_1
  (
 client_id
 , wh_loc_sid
 , item_sid
 , dat_adv
 , dat_dayend
 , week_adv
 , dat_notification1
 , dat_notification2
 , dat_notificationx
 , repeat_fg
 , price_retail_adv
 , price_retail_net_adv
 , case_size_dec
 , load_id
  )
  AS
     SELECT
         client_id,
     wh_loc_sid,
     item_sid,
     dat_adv,
     dat_dayend,
     week_adv,
     dat_notification1,
     dat_notification2,
     dat_notificationx,
     repeat_fg,
     price_retail_adv,
     price_retail_net_adv,
     case_size_dec,
     load_id
     FROM p_lew_core_ac.v_wawi_adv_item_advertising_1;