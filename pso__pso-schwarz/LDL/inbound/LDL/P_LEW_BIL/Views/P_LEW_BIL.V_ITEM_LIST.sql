CREATE OR REPLACE VIEW P_LEW_BIL.V_ITEM_LIST as
   /*
   #DescStart#
   #$Revision: 6283 $, $LastChangedBy: hwieber $
   #SubjectAreas#: Artikelstamm
   #DescEnd#
   */
   SELECT
     client_id,
   item_sid,
   loc_sid,
   active_from_dt,
   active_to_dt,
   list_type_mark,
   list_type_label,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   CASE WHEN Current_Date BETWEEN dwh_valid_from AND dwh_valid_to
         THEN 1
       ELSE 0
     END AS dwh_actual_fg,
   CASE WHEN deleted_fg = 1 OR active_to_dt < Current_Date OR active_from_dt > Current_Date
         THEN 0
       ELSE 1
     END AS active_fg
  FROM p_lew_core_ac.v_item_listing_type_hist;