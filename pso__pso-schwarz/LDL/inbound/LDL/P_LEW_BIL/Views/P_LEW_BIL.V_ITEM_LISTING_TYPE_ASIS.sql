CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEM_LISTING_TYPE_ASIS as
   /*
   #DescStart#
   #$Revision: 6426 $, $LastChangedBy: hwieber $
   #SubjectAreas#: Artikelstamm
   #DescEnd#
   */
   SELECT
     client_id,
   item_sid,
   list_type
   FROM
   (
     SELECT
       a.client_id,
   a.item_sid,
   COALESCE(a.list_type_mark,'-') AS list_type,
   COUNT(*) AS counti
     FROM p_lew_core_ac.v_item_listing_type_hist a
   INNER JOIN p_lew_core_ac.v_location b
   ON b.loc_sid=a.loc_sid
   AND b.wh_store_mark = 'A'
   AND b.global_loc_type_cd='0'
   INNER JOIN p_lew_core_ac.v_location_hist c
   ON c.loc_sid=b.loc_sid
   AND c.demand_plan_active_fg = 1
   AND CURRENT_DATE BETWEEN c.dwh_valid_from AND c.dwh_valid_to
   AND c.deleted_fg = 0
   WHERE CURRENT_DATE BETWEEn a.dwh_valid_from AND a.dwh_valid_to
   AND a.deleted_fg = 0
   GROUP BY 1,2,3
 ) x
 QUALIFY ROW_NUMBER() OVER(PARTITION BY client_id,item_sid ORDER BY counti DESC NULLS LAST) = 1;