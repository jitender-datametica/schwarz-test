CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_ITEM_ECLIENT_DAY
(
     effective_client_id

,          dwh_cal_dt

,          item_sid

,          client_id

,          luxembourg_fg

,          cy_year

,          cy_month

,          cy_week

,          adv_week_id

,          lang_sid

,          item_mstr_sid

,          item_fam_grp_sid

,          brand_sid

,          sub_item_grp_sid

,          item_grp_int_sid

,          item_hist_deleted_fg

,          item_fg_hist_deleted_fg

,          item_sg_hist_deleted_fg

,          orig_item_nr

,          case_size

,          dat_valid_from

,          item_name

,          item_description

,          src_familygrp_id

,          src_familygrp_cd

,          item_fam_grp_name

,          item_fam_grp_descr

,          src_subitemgrp_id

,          src_subitemgrp_cd

,          sub_item_grp_name

,          sub_item_grp_descr

,          src_itemgrp_int_id

,          src_itemgrp_int_cd

,          item_grp_int_name

,          item_grp_int_descr

,          item_grp_int_cd

,          core_brand_sid

,          elwis_brand_sid

,          src_brand_cd

,          brand_type_cd

,          brand_name

,          brand_descr

,          elwis_brand_type_mark

,          elwis_brand_type_label

,          buying_list_type_id

,          core_buying_list_type_id

,          elwis_buying_list_type_id

,          buying_list_type_descr

,          core_buying_list_type_descr

,          elwis_buying_list_type_descr

,          buying_list_type_group_id

,          buying_list_type_group_descr

,          listing_type_id

,          listing_type_descr

,          listing_type_group_id

,          listing_type_group_descr

,          elwis_list_type_mark

,          elwis_list_type_label

,          listing_fg

,          action_type_id

,          isg_action_type_id

,          derived_brand_type_cd
)
AS
(SELECT
Icd.effective_client_id             AS effective_client_id
,Icd.dwh_cal_dt                      AS dwh_cal_dt
,Icd.item_sid                        AS item_sid
,Icd.client_id                       AS client_id
,Icd.luxembourg_fg                   AS luxembourg_fg
,Icd.cy_year                         AS cy_year
,Icd.cy_month                        AS cy_month
,Icd.cy_week                         AS cy_week
,Icd.adv_week_id                     AS adv_week_id
,Icd.lang_sid                        AS lang_sid
,Icd.item_mstr_sid                   AS item_mstr_sid
,Icd.item_fam_grp_sid                AS item_fam_grp_sid
,Icd.brand_sid                       AS brand_sid
,Icd.sub_item_grp_sid                AS sub_item_grp_sid
,Icd.item_grp_int_sid                AS item_grp_int_sid
,Icd.item_hist_deleted_fg            AS item_hist_deleted_fg
,Icd.item_fg_hist_deleted_fg         AS item_fg_hist_deleted_fg
,Icd.item_sg_hist_deleted_fg         AS item_sg_hist_deleted_fg
,Icd.orig_item_nr                    AS orig_item_nr
,Icd.case_size                       AS case_size
,Icd.dat_valid_from                  AS dat_valid_from
,Icd.item_name                       AS item_name
,Icd.item_description                AS item_description
,Icd.src_familygrp_id                AS src_familygrp_id
,Icd.src_familygrp_cd                AS src_familygrp_cd
,Icd.item_fam_grp_name               AS item_fam_grp_name
,Icd.item_fam_grp_descr              AS item_fam_grp_descr
,Icd.src_subitemgrp_id               AS src_subitemgrp_id
,Icd.src_subitemgrp_cd               AS src_subitemgrp_cd
,Icd.sub_item_grp_name               AS sub_item_grp_name
,Icd.sub_item_grp_descr              AS sub_item_grp_descr
,Icd.src_itemgrp_int_id              AS src_itemgrp_int_id
,Icd.src_itemgrp_int_cd              AS src_itemgrp_int_cd
,Icd.item_grp_int_name               AS item_grp_int_name
,Icd.item_grp_int_descr              AS item_grp_int_descr
,Icd.item_grp_int_cd                 AS item_grp_int_cd
,Icd.core_brand_sid                  AS core_brand_sid
,Icd.elwis_brand_sid                 AS elwis_brand_sid
,Icd.src_brand_cd                    AS src_brand_cd
,Icd.brand_type_cd                   AS brand_type_cd
,Icd.brand_name                      AS brand_name
,Icd.brand_descr                     AS brand_descr
,Icd.elwis_brand_type_mark           AS elwis_brand_type_mark
,Icd.elwis_brand_type_label          AS elwis_brand_type_label
,Icd.buying_list_type_id             AS buying_list_type_id
,Icd.core_buying_list_type_id        AS core_buying_list_type_id
,Icd.elwis_buying_list_type_id       AS elwis_buying_list_type_id
,Icd.buying_list_type_descr          AS buying_list_type_descr
,Icd.core_buying_list_type_descr     AS core_buying_list_type_descr
,Icd.elwis_buying_list_type_descr    AS elwis_buying_list_type_descr
,Icd.buying_list_type_group_id       AS buying_list_type_group_id
,Icd.buying_list_type_group_descr    AS buying_list_type_group_descr
,Icd.listing_type_id                 AS listing_type_id
,Icd.listing_type_descr              AS listing_type_descr
,Icd.listing_type_group_id           AS listing_type_group_id
,Icd.listing_type_group_descr        AS listing_type_group_descr
,Icd.elwis_list_type_mark            AS elwis_list_type_mark
,Icd.elwis_list_type_label           AS elwis_list_type_label
,Icd.listing_fg                      AS listing_fg
,Icd.action_type_id                  AS action_type_id
,Icd.isg_action_type_id              AS isg_action_type_id
,Icd.derived_brand_type_cd           AS derived_brand_type_cd
FROM p_lew_mart_pit_onprem.t_pit_item_eclient_day        AS Icd
);