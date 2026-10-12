CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ITEM_PRPTY_LST_HST_1
(
  client_id
, item_sid
, item_prpty_lst_id
, dat_valid_from
, dat_valid_to
, item_prpty_lst_id_curr
)
AS
SELECT
client_id,
item_sid,
item_prpty_lst_id,
dat_valid_from,
dat_valid_to,
item_prpty_lst_id_curr
FROM p_lew_mart_lead.v_item_prpty_lst_hst_1
;


