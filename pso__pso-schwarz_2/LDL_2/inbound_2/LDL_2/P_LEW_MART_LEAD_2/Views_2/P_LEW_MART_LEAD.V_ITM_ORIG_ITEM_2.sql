CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ITM_ORIG_ITEM_2

(
  client_id
, orig_item_nr
, dat_valid_from
, item_fam_grp_sid
, item_familygroup_id
, orig_item_nr_int
, sub_item_grp_sid
, subitemgroup_id
, dwh_updated
)

AS
SELECT
  client_id
, orig_item_nr
, dat_valid_from
, item_fam_grp_sid
, item_familygroup_id
, orig_item_nr_int
, sub_item_grp_sid
, subitemgroup_id
, dwh_updated

FROM p_lew_mart_lead.t_itm_orig_item_2
;
