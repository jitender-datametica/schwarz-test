/* #----------------------------------------------------------------------------
# History:
#  1.0  20.03.2018    -Sanjana Bharti - Initial version -20180319_1620_Create_Missing_Source_Rep3 
#  1.1  05.01.2022    Michael Morris    Added Estonia EE
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_itm_orig_item_desc (client_id
OPTIONS(description='Identifier of Client'), orig_item_nr OPTIONS(description='Original item id'), dat_valid_from
OPTIONS(description='Valid from date'), item_desc_at
OPTIONS(description='Item description in depending country language'), item_desc_be
OPTIONS(description='Item description in depending country language'), item_desc_bg
OPTIONS(description='Item description in depending country language'), item_desc_ch
OPTIONS(description='Item description in depending country language'), item_desc_cy
OPTIONS(description='Item description in depending country language'), item_desc_cz
OPTIONS(description='Item description in depending country language'), item_desc
OPTIONS(description='Main item description field'), item_desc_dk
OPTIONS(description='Item description in depending country language'), item_desc_ee
OPTIONS(description='Item description in depending country language'), item_desc_es
OPTIONS(description='Item description in depending country language'), item_desc_fi
OPTIONS(description='Item description in depending country language'), item_desc_fr
OPTIONS(description='Item description in depending country language'), item_desc_gb
OPTIONS(description='Item description in depending country language'), item_desc_gr
OPTIONS(description='Item description in depending country language'), item_desc_hr
OPTIONS(description='Item description in depending country language'), item_desc_hu
OPTIONS(description='Item description in depending country language'), item_desc_ie
OPTIONS(description='Item description in depending country language'), item_desc_it
OPTIONS(description='Item description in depending country language'), item_desc_lt
OPTIONS(description='Item description in depending country language'), item_desc_ni
OPTIONS(description='Item description in depending country language'), item_desc_nl
OPTIONS(description='Item description in depending country language'), item_desc_lv
OPTIONS(description='Item description in depending country language'), item_desc_de
OPTIONS(description='Item description in depending country language'), item_desc_pl
OPTIONS(description='Item description in depending country language'), item_desc_pt
OPTIONS(description='Item description in depending country language'), item_desc_ro
OPTIONS(description='Item description in depending country language'), item_desc_se
OPTIONS(description='Item description in depending country language'), item_desc_si
OPTIONS(description='Item description in depending country language'), item_desc_sk
OPTIONS(description='Item description in depending country language'), item_desc_cs
OPTIONS(description='Item description in depending country language'), item_desc_mt
OPTIONS(description='Item description in depending country language'), item_desc_us
OPTIONS(description='Item description in depending country language'), item_desc_rs
OPTIONS(description='Item description in depending country language'))
OPTIONS(DESCRIPTION = `ORIGINAL ITEM DESCRIPTION VIEW`) AS SELECT client_id,
 orig_item_nr,
 dat_valid_from,
 item_desc_at,
 item_desc_be,
 item_desc_bg,
 item_desc_ch,
 item_desc_cy,
 item_desc_cz,
 item_desc,
 item_desc_dk,
 item_desc_ee,
 item_desc_es,
 item_desc_fi,
 item_desc_fr,
 item_desc_gb,
 item_desc_gr,
 item_desc_hr,
 item_desc_hu,
 item_desc_ie,
 item_desc_it,
 item_desc_lt,
 item_desc_ni,
 item_desc_lv AS item_desc_nl,
 item_desc_nl AS item_desc_lv,
 item_desc_de,
 item_desc_pl,
 item_desc_pt,
 item_desc_ro,
 item_desc_se,
 item_desc_si,
 item_desc_sk,
 item_desc_cs,
 item_desc_mt,
 item_desc_us,
 item_desc_rs
FROM ldl_p_lew_mart_lead.v_itm_orig_item_desc;