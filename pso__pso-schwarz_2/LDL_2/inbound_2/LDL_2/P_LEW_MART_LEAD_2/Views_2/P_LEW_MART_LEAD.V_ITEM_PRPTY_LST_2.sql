CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ITEM_PRPTY_LST_2

/*
#DescStart#
#$Revision: 16087 $, $LastChangedBy: mmalinowski $
#SubjectAreas#: Access Layer
#DescEnd#
*/
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
FROM p_lew_mart_lead.t_item_prpty_lst_hst_2
WHERE dat_valid_to = TO_DATE('9999-12-30', 'YYYY-MM_2-DD')
;


