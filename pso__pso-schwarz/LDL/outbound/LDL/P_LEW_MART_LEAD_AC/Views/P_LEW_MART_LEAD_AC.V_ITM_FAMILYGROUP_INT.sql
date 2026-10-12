/* #----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0   26-04-2019   Aleksander Bialek  Patch_Number: 2044
#                                       INITIAL VERSION
#                                       This is workaround version for Saeule Tool
#                                       In near future there will be something new
#                                       in Bil-layer
#  1.1  10.08.2020   Roy,Ritanjal       Introduce new country Latviya
#  1.2  04.01.2022   Michael Morris     Added Estonia EE
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_itm_familygroup_int (subitemgroup_id
OPTIONS(description='Identifier for subitemgroup'), src_familygrp_cd
OPTIONS(description='Full Identifier of subitemgroup_id abd family_cd'), family_cd
OPTIONS(description='Item family code'), item_family_desc OPTIONS(description='International family description'),
item_family_desc_at OPTIONS(description='Individual country description'), item_family_desc_be
OPTIONS(description='Individual country description'), item_family_desc_bg
OPTIONS(description='Individual country description'), item_family_desc_ch
OPTIONS(description='Individual country description'), item_family_desc_cy
OPTIONS(description='Individual country description'), item_family_desc_cz
OPTIONS(description='Individual country description'), item_family_desc_dk
OPTIONS(description='Individual country description'), item_family_desc_ee
OPTIONS(description='Individual country description'), item_family_desc_es
OPTIONS(description='Individual country description'), item_family_desc_fi
OPTIONS(description='Individual country description'), item_family_desc_fr
OPTIONS(description='Individual country description'), item_family_desc_gb
OPTIONS(description='Individual country description'), item_family_desc_gr
OPTIONS(description='Individual country description'), item_family_desc_hr
OPTIONS(description='Individual country description'), item_family_desc_hu
OPTIONS(description='Individual country description'), item_family_desc_ie
OPTIONS(description='Individual country description'), item_family_desc_it
OPTIONS(description='Individual country description'), item_family_desc_lt
OPTIONS(description='Individual country description'), item_family_desc_lv
OPTIONS(description='Individual country description'), item_family_desc_ni
OPTIONS(description='Individual country description'), item_family_desc_nl
OPTIONS(description='Individual country description'), item_family_desc_de
OPTIONS(description='Individual country description'), item_family_desc_pl
OPTIONS(description='Individual country description'), item_family_desc_pt
OPTIONS(description='Individual country description'), item_family_desc_ro
OPTIONS(description='Individual country description'), item_family_desc_se
OPTIONS(description='Individual country description'), item_family_desc_si
OPTIONS(description='Individual country description'), item_family_desc_sk
OPTIONS(description='Individual country description'), item_family_desc_cs
OPTIONS(description='Individual country description'), item_family_desc_mt
OPTIONS(description='Individual country description'), item_family_desc_us
OPTIONS(description='Individual country description'), item_family_desc_rs
OPTIONS(description='Individual country description'))
OPTIONS(DESCRIPTION = `VIEW USED FOR ITEMFAMILYGROUP INTERNATIONAL INFORMATION`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_itm_familygroup_int;