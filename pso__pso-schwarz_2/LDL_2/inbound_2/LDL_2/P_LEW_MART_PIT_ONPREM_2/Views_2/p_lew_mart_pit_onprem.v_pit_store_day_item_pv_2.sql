CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_STORE_DAY_ITEM_PV_2

(
     client_id
   , store_sid
   , store_name
   , city_name
   , dwh_cal_dt
   , weekday_nr
   , weekday_descr
   , weekday_sdescr
   , dwh_cal_dt_ldescr
   , cy_month
   , cy_month_descr
   , action_type_id
   , adv_week_id
   , assigned_PV_start_dt
   , assigned_PV_end_dt
   , assigned_PV_period_descr
   , adv_period_nr_of_days
   , adv_period_id
   , apt_promotion_start_dt
   , apt_promotion_end_dt
   , apt_adv_period_id
   , pv_adv_period_id
   , comp_assigned_PV_start_dt
   , comp_assigned_PV_end_dt
   , item_sid
   , item_mstr_sid
   , orig_item_nr
   , item_descr_int
   , item_descr
   , sub_item_grp_sid
   , src_subitemgrp_id
   , src_subitemgrp_cd
   , sub_item_grp_name
   , item_fam_grp_sid
   , src_familygrp_id
   , src_familygrp_cd
   , item_fam_grp_name
   , item_fam_grp_descr
   , item_grp_int_sid
   , src_itemgrp_int_id
   , src_itemgrp_int_cd
   , item_grp_int_name
   , item_grp_int_descr
   , brand_sid
   , brand_name_int
   , brand_descr
   , buying_list_type_id
   , buying_list_type_descr
   , buying_list_type_group_id
   , buying_list_type_group_descr
   , listing_type_id
   , listing_type_descr
   , listing_type_group_id
   , listing_type_group_descr
   , listing_fg
   , marke_em_descr
   , em_fg
   , marke_fg
   , case_size
   , sales_qty
   , receipts_cnt
   , sales_net_val
   , base_sales_net_val
   , total_sales_net_val
   , total_pv_sales_net_val
   , total_sales_net_val_pct
   , sales_price_net_old
   , sales_price_old
   , sales_price_net_new
   , sales_price_new
   , sales_price_p1_day
   , sales_price_p7_max_days
   , sales_price_p14_max_days
   , sales_price_median_day
   , sales_price_old_median_day
   , store_cnt
   , store_cnt_month
   , store_cnt_pv
   , pv_event_fg
   , pv_rule_1_state
   , pv_rule_2_state
   , pv_rule_3_state
   , pv_active_fg
   , pv_restricted_stores_fg
   , fa_nf_action_fg
   , pv_split_fg
   , orig_adv_week_id
   , pv_sunday_open_fg
   , local_price_fg
   , pit_price_integrity_fg
   , vat_pct_val
   , vat_factor
   , base_receipts_cnt
   , base_sales_qty
   , regular_nr_of_stores_per_item_day
   , pv_nr_of_stores_per_item_day
   , pv_value
   , price_diff_pct
   , pv_fg
   , pv_local_fg
   , add_pv_sales_net_val
   , pv_effect_pct
   , store_cnt_fg
   , nr_of_stores_per_item_day_pct
   , sales_net_pv_factor
   , add_pv_receipts_cnt
   , receipts_cnt_pv_factor
   , sales_qty_pv_factor
   , add_pv_sales_net_val_per_store
   , apt_only_fg
)
AS
SELECT

pvm.client_id
,pvm.store_sid
,COALESCE ( str.store_name, 'N/A')             AS store_name
,COALESCE ( str.city_name, 'N/A')              AS city_name
,pvm.dwh_cal_dt                                AS dwh_cal_dt
--TD_Day_of_Week ( pvm.dwh_cal_dt )             AS weekday_nr
--date_part('DayOFWeek',pvm.dwh_cal_dt ) + 1 As weekday_nr
--
--
--pvm.dwh_cal_dt /*** MSC-WARNING - MSCEWSMALLINT,034 - FORMAT 'E4' REMOVED. ***/:: CHAR ( 22)
--AS weekday_descr
--SUBSTR ( weekday_descr, 1, 2 )                AS weekday_sdescr       /* first 2 chars of the weekday description AS short description */
--pvm.dwh_cal_dt /*** MSC-WARNING - MSCEWSMALLINT,034 - FORMAT 'E4,BMMMMBDD,BYYYY' REMOVED. ***/:: CHAR ( 22) AS dwh_cal_dt_ldescr
--
--
--
--pvm.cy_month
----TO_VARCHAR(CAST((pvm.cy_month/100) AS VARCHAR(4)) || '-' || CAST(  ( pvm.cy_month MOD 100 ) AS VARCHAR(2)) || '-' || CAST( 1 AS VARCHAR(2)), '') AS cy_month_descr
--substr(TO_CHAR(pvm.cy_month/100),1,4) || '-' || TO_CHAR(mod(pvm.cy_month, 100),'09') || '01'  AS cy_month_descr

--TD_Day_of_Week ( Icd.DWH_CAL_DT )        AS weekday_nr
--TD_Day_of_Week ( Icd.DWH_CAL_DT )        AS weekday_nr
--date_part('DayOFWeek',Icd.DWH_CAL_DT::DATE ) + 1 As weekday_nr
 
,date_part('DayOFWeekiso',pvm.dwh_cal_dt::DATE ) As weekday_nr
 
--Icd.dwh_cal_dt /*** MSC-WARNING - MSCEWSMALLINT,034 - FORMAT 'E4' REMOVED. ***/:: CHAR ( 22)
--AS weekday_descr
,TO_CHAR(pvm.dwh_cal_dt::DATE, 'DY' )           AS weekday_descr       -- first 2 chars of the weekday description AS short description
--SUBSTR ( weekday_descr, 1, 2 )           AS weekday_sdescr        -- first 2 chars of the weekday description AS short description
,TO_CHAR(pvm.dwh_cal_dt::DATE, 'DY' )           AS weekday_sdescr        -- first 2 chars of the weekday description AS short description
--,Icd.dwh_cal_dt /*** MSC-WARNING - MSCEWSMALLINT,034 - FORMAT 'E4,BMMMMBDD,BYYYY' REMOVED. ***/:: CHAR ( 22)
,TO_CHAR(pvm.dwh_cal_dt::DATE, 'DY, MON DD , YYYY') AS dwh_cal_dt_ldescr

,try_to_number( TO_CHAR(pvm.dwh_cal_dt::DATE, 'YYYYMM') ) AS cy_month
--TO_VARCHAR(CAST((cy_month/100) AS VARCHAR(4)) || '-' || CAST(  ( cy_month MOD 100 ) AS VARCHAR(2)) || '-' || CAST( 1 AS VARCHAR(2)), '') AS cy_month_descr
-- substr(TO_CHAR(cy_month),1,4) || '-' || TO_CHAR(mod(cy_month, 100),'09') || '01'  AS cy_month_descr, 
,TO_CHAR(pvm.dwh_cal_dt ::DATE, 'MON-YYYY') AS cy_month_descr

,1::SMALLINT                       AS action_type_id /* 1: indicates PV */
,pvm.adv_week_id
,pvm.assigned_PV_start_dt
,pvm.assigned_PV_end_dt

--TO_VARCHAR(PUBLIC.INT_TO_DATE_UDF( assigned_PV_start_dt) /*** MSC-WARNING - MSCEWI2026 - CUSTOM UDF 'INT_TO_DATE_UDF' INSERTED. ***/, 'YYYY/MM_2/DD') || ' - ' || TO_VARCHAR( assigned_PV_end_dt, '') AS assigned_PV_period_descr

 --  CAST ( assigned_PV_start_dt /*Warning, Format 'E3' removed, semantic information not found.*/  AS VARCHAR ( 10 ) )
,TO_CHAR(pvm.assigned_PV_start_dt , 'DY' )
        || ' - ' ||
 --       CAST ( assigned_PV_end_dt /*Warning, Format 'E3' removed, semantic information not found.*/ AS VARCHAR ( 10 ) )
TO_CHAR(pvm.assigned_PV_end_dt , 'DY' )
                                                      AS assigned_PV_period_descr
,CAST( ( pvm.assigned_PV_end_dt - pvm.assigned_PV_start_dt + 1 ) AS INTEGER)         AS adv_period_nr_of_days
,pvm.adv_period_id
,pvm.apt_promotion_start_dt
,pvm.apt_promotion_end_dt
,pvm.apt_adv_period_id
,pvm.pv_adv_period_id
,pvm.comp_assigned_PV_start_dt
,pvm.comp_assigned_PV_end_dt
,pvm.item_sid                                  AS item_sid
,CAST (   (  itm.item_sid * 100::INTEGER  )  + itm.client_id AS INTEGER )
                                                   AS item_mstr_sid
,itm.orig_item_nr                              AS orig_item_nr
,itm.item_descr_int                            AS item_descr_int
,itm.item_descr                                AS item_descr
,itm.sub_item_grp_sid                          AS sub_item_grp_sid
,itm.src_subitemgrp_id                         AS src_subitemgrp_id
,itm.src_subitemgrp_cd                         AS src_subitemgrp_cd
,itm.sub_item_grp_name                         AS sub_item_grp_name
,itm.item_fam_grp_sid                          AS item_fam_grp_sid
,itm.src_familygrp_id                          AS src_familygrp_id
,itm.src_familygrp_cd                          AS src_familygrp_cd
,itm.item_fam_grp_name                         AS item_fam_grp_name
,itm.item_fam_grp_descr                        AS item_fam_grp_descr
,itm.item_grp_int_sid                          AS item_grp_int_sid
,itm.src_itemgrp_int_id                        AS src_itemgrp_int_id
,itm.src_itemgrp_int_cd                        AS src_itemgrp_int_cd
,itm.item_grp_int_name                         AS item_grp_int_name
,itm.item_grp_int_descr                        AS item_grp_int_descr
,itm.brand_sid                                 AS brand_sid
,itm.brand_name_int                            AS brand_name_int
,itm.brand_descr                               AS brand_descr
,itm.buying_list_type_id                       AS buying_list_type_id
,itm.buying_list_type_descr                    AS buying_list_type_descr
,itm.buying_list_type_group_id                 AS buying_list_type_group_id
,itm.buying_list_type_group_descr              AS buying_list_type_group_descr
,itm.listing_type_id                           AS listing_type_id
,itm.listing_type_descr                        AS listing_type_descr
,itm.listing_type_group_id                     AS listing_type_group_id
,itm.listing_type_group_descr                  AS listing_type_group_descr
,itm.listing_fg                                AS listing_fg
,itm.marke_em_descr                            AS marke_em_descr
,itm.em_fg                                     AS em_fg
,itm.marke_fg                                  AS marke_fg
,itm.case_size                                 AS case_size
,pvm.sales_qty                                 AS sales_qty
,pvm.receipts_cnt                              AS receipts_cnt
,pvm.sales_net_val                             AS sales_net_val
,pvm.base_sales_net_val                        AS base_sales_net_val
,pvm.total_sales_net_val                       AS total_sales_net_val
,pvm.total_pv_sales_net_val                    AS total_pv_sales_net_val
--CAST (   ( total_sales_net_val / CASE WHEN  total_pv_sales_net_val = 0 THEN NULL ELSE  total_pv_sales_net_val END) * 100.0
--AS NUMBER(38,5)
-- )                                            AS total_sales_net_val_pct
,DIV0( pvm.total_sales_net_val, pvm.total_pv_sales_net_val) * 100    
                                              AS total_sales_net_val_pct
,pvm.sales_price_old                           AS sales_price_net_old /* VK_2  ( alt )   ( netto )  */

--CAST (
--       sales_price_old * CAST ( ( 1.00 + vat_factor )  AS NUMBER(38,5) )
--       AS NUMBER(38,5)
--        )                                          AS sales_price_old /* VK_2  ( alt )   ( brutto )  */
,pvm.sales_price_old * ( 1.00 + pvm.vat_factor ) 	AS sales_price_old
,pvm.sales_price                                     AS sales_price_net_new /* VK_2  ( netto )  PV: VK_2  ( neu )  */
--CAST (
--       sales_price * CAST ( ( 1.00 + vat_factor )  AS NUMBER(38,5) )
--       AS NUMBER(38,5)
--        )                                          AS sales_price_new /* VK_2  ( brutto )  PV: VK_2  ( neu )   ( brutto ) */
,pvm.sales_price * ( 1.00 + pvm.vat_factor )         AS sales_price_new
,pvm.sales_price_p1_day
,pvm.sales_price_p7_max_days
,pvm.sales_price_p14_max_days
,pvm.sales_price_median_day
,pvm.sales_price_old_median_day
,pvm.store_cnt
,pvm.store_cnt_month
,pvm.store_cnt_pv
,pvm.pv_event_fg
,pvm.pv_rule_1_state
,pvm.pv_rule_2_state
,pvm.pv_rule_3_state
,pvm.pv_active_fg
,pvm.pv_restricted_stores_fg
,pvm.fa_nf_action_fg
,pvm.pv_split_fg
,pvm.orig_adv_week_id
,pvm.pv_sunday_open_fg
,pvm.local_price_fg
,pvm.pit_price_integrity_fg
,pvm.vat_pct_val
,pvm.vat_factor
,pvm.base_receipts_cnt
,pvm.base_sales_qty
,pvm.regular_nr_of_stores_per_item_day
,pvm.pv_nr_of_stores_per_item_day
,CAST (
       ( pvm.sales_price - pvm.sales_price_old )  * pvm.sales_qty       AS NUMBER(38,5) )
                                               AS pv_value
,CAST (
        ( pvm.sales_price / CASE WHEN  pvm.sales_price_old = 0 THEN NULL ELSE  pvm.sales_price_old END ) - 1
AS NUMBER(38,5) )
                                        AS price_diff_pct
,CASE WHEN  (  pvm.pv_active_fg = 1 AND pvm.pv_restricted_stores_fg = 0 AND pvm.fa_nf_action_fg = 0 AND pvm.pv_sunday_open_fg = 0 )
       THEN
           1::SMALLINT
       ELSE
           0::SMALLINT
    END                                        AS pv_fg
,CASE WHEN  (  pvm.pv_active_fg = 1 AND pvm.pv_restricted_stores_fg = 1 AND pvm.fa_nf_action_fg = 0 AND pvm.pv_sunday_open_fg = 0 )
        THEN
            1::SMALLINT
        ELSE
            0::SMALLINT
     END                                        AS pv_local_fg
,CAST (
        pvm.sales_net_val - pvm.base_sales_net_val
            AS NUMBER(38,5) )
                                                AS add_pv_sales_net_val
,CAST (
             (
                 ( add_pv_sales_net_val / CASE WHEN (-1.00 * pv_value ) = 0 THEN NULL ELSE (-1.00 * pv_value ) END
)  - 1.00
)* 100::INTEGER
AS NUMBER(38,5) )
                               AS pv_effect_pct
,CASE WHEN CAST (TRUNC( ( pvm.store_cnt * 1.00 ) / CASE WHEN  pvm.store_cnt_month*1.00 = 0 THEN NULL ELSE  pvm.store_cnt_month*1.00 END)  AS NUMBER(38,5) )
>= pa.pv_sunday_open_threshold /* 0.20 20 % of stores must be open */
THEN
    1::SMALLINT
ELSE
    0::SMALLINT
END                                        AS store_cnt_fg
,CAST (
             (
                 ( CAST ( pvm.pv_nr_of_stores_per_item_day AS NUMBER(38,5) )  / CASE WHEN  CAST (  pvm.regular_nr_of_stores_per_item_day AS NUMBER(38,5) ) = 0 THEN NULL ELSE  CAST (  pvm.regular_nr_of_stores_per_item_day AS NUMBER(38,5) ) END
)
)
AS NUMBER(38,5) )                   AS nr_of_stores_per_item_day_pct
,CAST (
             (
                 ( pvm.sales_net_val / CASE WHEN  pvm.base_sales_net_val = 0 THEN NULL ELSE  pvm.base_sales_net_val END
)
)
AS NUMBER(38,5) )
                               AS sales_net_pv_factor
,pvm.receipts_cnt - pvm.base_receipts_cnt           AS add_pv_receipts_cnt
,CAST (
             (
                 ( pvm.receipts_cnt / CASE WHEN  pvm.base_receipts_cnt = 0 THEN NULL ELSE  pvm.base_receipts_cnt END
)
)
AS NUMBER(38,5) )
                               AS receipts_cnt_pv_factor
,CAST (
             (
                 ( pvm.sales_qty / CASE WHEN  pvm.base_sales_qty = 0 THEN NULL ELSE  pvm.base_sales_qty END
)
)
AS NUMBER(38,5) )
                               AS sales_qty_pv_factor
,CAST (TRUNC(
add_pv_sales_net_val / CASE WHEN  CAST ( pvm.store_cnt AS NUMBER(38,5) ) = 0 THEN NULL ELSE  CAST ( store_cnt AS NUMBER(38,5) ) END)
AS NUMBER(38,5) )
                                        AS add_pv_sales_net_val_per_store
,pvm.apt_only_fg

FROM p_lew_mart_pit_onprem.t_pit_store_day_item_pv_2 pvm

/* ## Parameter TABLE */
INNER JOIN 
		( 
        SELECT
              CLIENT_ID     
            , MAX( iff(pa.param_id = 2,CAST(pa.param_value AS NUMBER(38,5)),NULL) )   				AS PV_SUNDAY_OPEN_THRESHOLD
        FROM        
		(
				SELECT * FROM P_LEW_MART_PIT_ONPREM.T_PIT_SCOPE_COUNTRY_PARAM_2 
				WHERE TRUE
					AND CURRENT_DATE() BETWEEN DWH_VALID_FROM AND DWH_VALID_TO
					AND	DELETED_FG 	= 0									
				QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
		) pa
        GROUP BY 1
        )pa
	ON TRUE
    AND pa.client_id = pvm.client_id

/* ## Join new ClientItemDay View */
INNER JOIN p_lew_mart_pit_onprem.v_pit_item_client_day_hist_2 itm
ON
    TRUE
    AND pvm.client_id   = itm.client_id
    AND pvm.item_sid    = itm.item_sid
    AND pvm.dwh_cal_dt  = itm.dwh_cal_dt

/* ## Store Descriptions */
LEFT JOIN p_lew_bil_ac.v_dim_store_2 str
ON
    TRUE
    AND str.client_id   = pvm.client_id
    AND str.store_sid   = pvm.store_sid

WHERE
TRUE;