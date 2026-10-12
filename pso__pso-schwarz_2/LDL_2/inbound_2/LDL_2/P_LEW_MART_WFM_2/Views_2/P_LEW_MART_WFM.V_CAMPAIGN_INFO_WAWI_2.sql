CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_CAMPAIGN_INFO_WAWI_2
AS
   SELECT DISTINCT
           adv.client_id             AS client_id,
   cntry.src_country_lidl_cd AS country_2,
   loc.src_wh_id             AS wh_id,
--        loc.loc_sid               AS wh_loc_sid,
--        adv.item_sid              AS item_sid, 
   itm.src_orig_item_nr      AS orig_item_nr,
   adv.price_retail_adv      AS gross_price,
   adv.price_retail_net_adv  AS net_price,
   adv.repeat_fg             AS repeat_fg,
   adv.dat_adv               AS dat_adv_date,
   adv.week_adv              AS week_adv
--        adv.dat_dayend            AS dat_dayend,
--        adv.load_id               AS load_id
FROM
   p_lew_core_ac.v_wawi_adv_item_advertising_2 adv
   INNER JOIN p_lew_core_ac.v_location_2 loc
   ON loc.client_id = adv.client_id
   AND loc.loc_sid   = adv.wh_loc_sid
   INNER JOIN p_lew_core_ac.v_country_2 cntry
   ON loc.client_id = cntry.country_sid
   INNER JOIN p_lew_core_ac.v_item_2 itm
   ON itm.client_id = adv.client_id
   AND itm.item_sid  = adv.item_sid

 /* 29.05.2018 added */
 QUALIFY ROW_NUMBER() OVER(
  PARTITION BY adv.client_id, loc.src_wh_id, itm.src_orig_item_nr, adv.dat_adv
  ORDER BY adv.repeat_fg, adv.price_retail_net_adv DESC NULLS LAST, adv.week_adv ) = 1
;