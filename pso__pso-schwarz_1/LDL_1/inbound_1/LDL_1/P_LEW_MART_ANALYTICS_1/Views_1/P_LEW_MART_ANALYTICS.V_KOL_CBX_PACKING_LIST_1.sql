CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS.V_KOL_CBX_PACKING_LIST_1
(
      client_id
    , client_id_recipient
    , mdm_item_sid
    , mdm_pack_list_sid
    , src_pack_method_cd
    , pack_list_name
    , pack_list_carton_qty
)
AS
   SELECT
         pakl.client_id,
   pakl_ch.client_id_recipient,
   pakl.mdm_item_sid,
   pakl.mdm_pack_list_sid,
   pakl.src_pack_method_cd,
   pakl_h.pack_list_name,
   pakl_h.pack_list_carton_qty
  FROM p_lew_core_ac.v_mdm_item_packing_list_1 AS pakl
   INNER JOIN p_lew_core_ac.v_mdm_item_packing_list_client_hist_1 AS pakl_ch
   ON pakl_ch.client_id = pakl.client_id
   AND pakl_ch.mdm_pack_list_sid = pakl.mdm_pack_list_sid
   AND pakl_ch.deleted_fg = 0
   AND CURRENT_DATE BETWEEN pakl_ch.dwh_valid_from AND pakl_ch.dwh_valid_to
   LEFT JOIN p_lew_core_ac.v_mdm_item_packing_list_hist_1 AS pakl_h
   ON pakl_h.client_id = pakl.client_id
   AND pakl_h.mdm_pack_list_sid = pakl.mdm_pack_list_sid
   AND pakl_h.deleted_fg = 0
   AND CURRENT_DATE BETWEEN pakl_h.dwh_valid_from AND pakl_h.dwh_valid_to
   ;