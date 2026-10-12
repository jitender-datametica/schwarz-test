CREATE OR REPLACE VIEW ldl_p_lew_bil.v_subitemgroup_2 AS SELECT SIG.client_id,
 SIG.sub_item_grp_sid,
 SIG.src_subitemgrp_cd,
 SIG.src_subitemgrp_id,
 SIG.sub_item_grp_name,
 SIGH.item_grp_int_sid,
 SIG_LIDL.sub_item_grp_descr AS subitemgroup_desc_lidl_short,
 SIG_DEFAULT.sub_item_grp_descr AS subitemgroup_desc_default_short,
 SIG_LIDL.sub_item_grp_descr AS subitemgroup_desc_lidl,
 SIG_DEFAULT.sub_item_grp_descr AS subitemgroup_desc_default,
 SIGH.deleted_fg,
 SIG_DEFAULT.lang_cd AS lang_cd_default,
 SIG_LIDL.lang_sid AS lang_sid_lidl,
 1 AS active_fg
FROM ldl_p_lew_core_ac.v_subitemgroup_hist_2 AS SIGH
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_2 AS SIG ON SIGH.client_id = SIG.client_id AND SIGH.sub_item_grp_sid = SIG.sub_item_grp_sid
     AND CURRENT_DATE BETWEEN SIGH.dwh_valid_from AND SIGH.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_country_2 AS LIDLCTRY ON SIG.client_id = LIDLCTRY.country_sid
 LEFT JOIN ldl_p_lew_core_ac.v_subitemgroup_descr_2 AS SIG_DEFAULT ON LIDLCTRY.country_sid = SIG_DEFAULT.client_id AND
    LIDLCTRY.lang_sid = SIG_DEFAULT.lang_sid AND SIGH.sub_item_grp_sid = SIG_DEFAULT.sub_item_grp_sid
 LEFT JOIN ldl_p_lew_core_ac.v_subitemgroup_descr_2 AS SIG_LIDL ON SIG.sub_item_grp_sid = SIG_LIDL.sub_item_grp_sid AND
    SIG_LIDL.lang_sid = 2 AND SIG.client_id = SIG_LIDL.client_id;