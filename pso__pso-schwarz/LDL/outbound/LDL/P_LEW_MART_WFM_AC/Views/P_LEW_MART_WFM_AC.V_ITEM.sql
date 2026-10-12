/* Last Change 2025-11-03 - APAP0273402 - by Daniel Vering */ CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_item (country_lidl_cd
, src_subitemgrp_cd, src_familygrp_cd, vat_id, status_id_hq, item_nr, orig_item_nr_int, smallest_orderunit,
dat_valid_from, smallest_unit, weight_item_fg, dangerous_goods_fg, list_type, brand_type_mark, val_deposit,
buying_list_type_id, item_sid, item_custom_need_type_cd, item_custom_need_type_desc, item_custom_need_subtype_cd,
item_custom_need_subtype_desc) AS SELECT *
FROM ldl_p_lew_mart_wfm.v_item;