CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ITEM_PRPTY_LST_ITEM_PRPTY_REL_1
(
  item_prpty_lst_id
, item_prpty_lst_id_curr
, item_prpty_sid
)
AS
SELECT
item_prpty_lst_id,
item_prpty_lst_id_curr,
item_prpty_sid
FROM p_lew_mart_lead.v_item_prpty_lst_item_prpty_rel_1
;


