CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics.v_kol_cbx_packing_list_1 (client_id, client_id_recipient, mdm_item_sid,
mdm_pack_list_sid, src_pack_method_cd, pack_list_name, pack_list_carton_qty) AS SELECT PAKL.client_id,
 PAKL_CH.client_id_recipient,
 PAKL.mdm_item_sid,
 PAKL.mdm_pack_list_sid,
 PAKL.src_pack_method_cd,
 PAKL_H.pack_list_name,
 PAKL_H.pack_list_carton_qty
FROM ldl_p_lew_core_ac.v_mdm_item_packing_list_1 AS PAKL
 INNER JOIN ldl_p_lew_core_ac.v_mdm_item_packing_list_client_hist_1 AS PAKL_CH ON PAKL.client_id = PAKL_CH.client_id AND
     PAKL.mdm_pack_list_sid = PAKL_CH.mdm_pack_list_sid AND PAKL_CH.deleted_fg = 0 AND CURRENT_DATE BETWEEN PAKL_CH.dwh_valid_from
   AND PAKL_CH.dwh_valid_to
 LEFT JOIN ldl_p_lew_core_ac.v_mdm_item_packing_list_hist_1 AS PAKL_H ON PAKL.client_id = PAKL_H.client_id AND PAKL.mdm_pack_list_sid
      = PAKL_H.mdm_pack_list_sid AND PAKL_H.deleted_fg = 0 AND CURRENT_DATE BETWEEN PAKL_H.dwh_valid_from AND PAKL_H.dwh_valid_to;