/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_KZP_ARTIKELSTAMM
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* grouping is actually superfluous, because "item" guarantees key-ness of "client_id", "nat_item_nr", but
     we leave it in for now, in case the logic must be changed again: KZP expects grouping like this */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_kzp_artikelstamm (client_id, country_iso_cd, subitemgroup_id, itemfamily_cd,
vat_id, itemstatus_cd, orig_item_nr, orig_item_nr_int, item_valid_from, item_valid_until, deleted_fg,
itemfamily_valid_from, itemfamaliy_valid_until, smallest_unit, weight_fg, dangerous_goods_fg, buying_list_type_id,
brand_name, load_id) AS -- Country
 SELECT item.client_id,
 T.src_country_lidl_cd AS country_iso_cd,
 item.subitemgroup_id,
 item.itemfamily_cd,
 item.vat_id,
 item.itemstatus_cd,
 item.orig_item_nr,
 item.orig_item_nr_int,
 item.item_valid_from,
 item.item_valid_until,
 item.deleted_fg,
 item.itemfamily_valid_from,
 item.itemfamaliy_valid_until,
  CASE
  WHEN STRPOS(item.smallest_unit, 'NA') <> 0
  THEN NULL
  ELSE item.smallest_unit
  END AS smallest_unit,
 COALESCE(item.weight_fg, 0) AS weight_fg,
 item.dangerous_goods_fg,
 item.buying_list_type_id,
 item.brand_name,
 item.dwh_load_id AS load_id
FROM (SELECT M.client_id,
   M.item_sid,
   M.subitemgroup_id,
   M.item_familygroup_id,
   M.vat_id,
   M.itemstatus_cd,
   M.orig_item_nr,
   M.orig_item_nr_int,
   M.valid_from AS item_valid_from,
   M.valid_until AS item_valid_until,
   M.deleted_fg,
   M.smallest_unit,
   M.weight_fg,
   M.dangerous_goods_fg,
   M.buying_list_type_id,
   M.brand_name,
   i.itemfamily_cd,
   i.dat_rec_start AS itemfamily_valid_from,
   i.dat_rec_end AS itemfamaliy_valid_until,
   M.dwh_load_id
  FROM ldl_p_lew_mart_cs.v_gen_item_hist AS M
   LEFT JOIN (SELECT client_id,
     item_familygroup_id,
     itemfamily_cd,
     dat_rec_start,
     dat_rec_end
    FROM ldl_p_lew_mart_cs.v_gen_item_family
    GROUP BY client_id,
     item_familygroup_id,
     dat_rec_start,
     dat_rec_end,
     itemfamily_cd) AS i ON M.client_id = i.client_id AND M.item_familygroup_id = i.item_familygroup_id
  WHERE M.deleted_fg = 0) AS item
 INNER JOIN ldl_p_lew_core_ac.v_client AS C ON item.client_id = C.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country AS T ON C.country_sid = T.country_sid;