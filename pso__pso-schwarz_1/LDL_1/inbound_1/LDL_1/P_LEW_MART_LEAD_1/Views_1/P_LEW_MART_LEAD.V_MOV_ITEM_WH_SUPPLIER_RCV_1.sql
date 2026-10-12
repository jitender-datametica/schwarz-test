CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_MOV_ITEM_WH_SUPPLIER_RCV_1
AS
   SELECT client_id,
   loc_sid_wh,
   src_wh_id,
   item_sid,
   sup_sid,
   dat_formdate,
   cy_week
   FROM p_lew_mart_lead.t_mov_item_wh_supplier_rcv_1;