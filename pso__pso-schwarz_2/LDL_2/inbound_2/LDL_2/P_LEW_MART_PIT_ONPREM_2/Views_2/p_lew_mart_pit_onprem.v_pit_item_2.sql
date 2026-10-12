CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_ITEM_2

AS
SELECT

itm.client_id                                     AS client_id
,itm.dwh_cal_dt                                    AS dwh_cal_dt
,itm.cy_year                                       AS cy_year
,itm.cy_month                                      AS cy_month
,itm.iso_year_week                                 AS iso_year_week
,itm.adv_week_id                                   AS adv_week_id
,itm.lang_sid                                      AS lang_sid
,itm.weekday_nr                                    AS weekday_nr
,itm.weekday_descr                                 AS weekday_descr
,itm.weekday_sdescr                                AS weekday_sdescr
,itm.dwh_cal_dt_ldescr                             AS dwh_cal_dt_ldescr
,itm.cy_month_descr                                AS cy_month_descr
,itm.item_sid                                      AS item_sid
,itm.item_mstr_sid                                 AS item_mstr_sid
,itm.item_fam_grp_sid                              AS uwg_af_sid
,itm.brand_sid                                     AS brand_sid
,itm.sub_item_grp_sid                              AS uwg_sid
,itm.item_grp_int_sid                              AS wgi_sid
,itm.orig_item_nr                                  AS orig_item_nr
,itm.item_descr_int                                AS item_descr_int
,itm.item_descr                                    AS item_descr_loc
,itm.item_variant_descr_int                        AS item_variant_descr_int
,itm.item_variant_descr                            AS item_variant_descr_loc
,itm.src_familygrp_id                              AS uwg_af_id
,itm.src_familygrp_cd                              AS uwg_af_cd
,itm.src_familygrp_cd                              AS uwg_af_desc
,itm.item_fam_grp_name                             AS uwg_af_desc_int
,itm.item_fam_grp_descr                            AS uwg_af_desc_loc
,itm.src_subitemgrp_id                             AS uwg_id
,itm.src_subitemgrp_cd                             AS uwg_cd
,itm.sub_item_grp_name                             AS uwg_desc_int
,itm.src_itemgrp_int_id                            AS wgi_id
,itm.src_itemgrp_int_cd                            AS wgi_cd
,itm.item_grp_int_name                             AS wgi_desc_int
,itm.item_grp_int_descr                            AS wgi_desc_loc
,itm.brand_name_int                                AS brand_name_int
,itm.brand_descr                                   AS brand_descr
,itm.buying_list_type_id                           AS buying_list_type_id
,itm.buying_list_type_descr                        AS buying_list_type_descr
,itm.buying_list_type_group_id                     AS buying_list_type_group_id
,itm.buying_list_type_group_descr                  AS buying_list_type_group_descr
,itm.listing_type_id                               AS listing_type_id
,itm.listing_type_descr                            AS listing_type_descr
,itm.listing_type_group_id                         AS listing_type_group_id
,itm.listing_type_group_descr                      AS listing_type_group_descr
,itm.listing_fg                                    AS listing_fg
,itm.action_type_id                                AS action_type_id
,itm.marke_em_descr                                AS marke_em_descr
,itm.case_size                                     AS case_size
,itm.marke_fg                                      AS marke_fg
,itm.em_fg                                         AS em_fg
FROM p_lew_mart_pit_onprem.v_pit_item_client_day_current_2 itm

WHERE
    itm.client_id IN (SELECT DISTINCT client_id
FROM p_lew_mart_pit_onprem.t_pit_clients_2
)

UNION ALL

/* Subtotal level (item_sid = -2) */
SELECT

Clients.client_id                         AS client_id
,DATE '9999-12-31'                         AS dwh_cal_dt
,-2::INTEGER                               AS cy_year
,-2::INTEGER                               AS cy_month
,-2::INTEGER                               AS iso_year_week
,-2::INTEGER                               AS adv_week_id
,-2::INTEGER                               AS lang_sid
,-2::INTEGER                               AS weekday_nr
,'TOT'                                     AS weekday_descr
,'TT'                                      AS weekday_sdescr
,'TOT'                                     AS dwh_cal_dt_ldescr
,'TOT'                                     AS cy_month_descr
,-2::INTEGER                                        AS item_sid                 /* Later: item_sid no longer 
    PRIMARY KEY: probably use -client_id */
,( ( -2::INTEGER * 100::INTEGER ) +  Clients.client_id )          AS item_mstr_sid            /* Later: probably use -client_id*100 - client_id */
,-2::INTEGER                                        AS uwg_af_sid
,-2::INTEGER                                        AS brand_sid
,-2::INTEGER                                        AS uwg_sid
,-2::INTEGER                                        AS wgi_sid
,-2::INTEGER                                        AS orig_item_nr
,'TOT'                                     AS item_descr_int
,'TOT'                                     AS item_descr_loc
,'TOT'                                     AS item_variant_descr_int
,'TOT'                                     AS item_variant_descr_loc
,-2::INTEGER                                        AS uwg_af_id
,'TOT'                                     AS uwg_af_cd
,'TOT'                                     AS uwg_af_desc
,'TOT'                                     AS uwg_af_desc_int
,'TOT'                                     AS uwg_af_desc_loc
,-2::INTEGER                                        AS uwg_id
,'TOT'                                     AS uwg_cd
,'TOT'                                     AS uwg_desc_int
,-2::INTEGER                                        AS wgi_id
,'TOT'                                     AS wgi_cd
,'TOT'                                     AS wgi_desc_int
,'TOT'                                     AS wgi_desc_loc
,'TOT'                                     AS brand_name_int
,'TOT'                                     AS brand_descr
,-2::INTEGER                                        AS buying_list_type_id
,'TOT'                                     AS buying_list_type_descr
,-2::INTEGER                                        AS buying_list_type_group_id
,'TOT'                                     AS buying_list_type_group_descr
,-2::INTEGER                                        AS listing_type_id
,'TOT'                                     AS listing_type_descr
,-2::INTEGER                                        AS listing_type_group_id
,'TOT'                                     AS listing_type_group_descr
,0::SMALLINT                                         AS listing_fg
,-2::INTEGER                                        AS action_type_id
,'TOT'                                     AS marke_em_descr
,-2::INTEGER                                        AS case_size
,0::SMALLINT                                         AS marke_fg
,0::SMALLINT                                         AS em_fg
FROM (SELECT DISTINCT client_id
FROM p_lew_mart_pit_onprem.t_pit_clients_2
)         AS Clients;