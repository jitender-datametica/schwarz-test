CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_WEEK_ITEM_PERIOD_PV_1
(
     client_id
   , item_sid
   , action_type_id
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
   , adv_week_id
   , adv_week_sid
   , orig_adv_week_id
   , assigned_pv_start_dt
   , assigned_pv_end_dt
   , assigned_pv_period_descr
   , adv_period_id
   , orig_pv_fg_
   , orig_pv_local_fg
   , vat_pct_val
   , vat_factor
   , total_sales_net_val
   , total_pv_sales_net_val
   , total_sales_net_val_pct
   , base_receipts_cnt
   , base_sales_qty
   , base_sales_net_val
   , adv_period_nr_of_days
   , store_cnt_per_period
   , sales_qty
   , sales_net_val
   , sales_price_median_day
   , store_cnt
   , sales_price_old_median_day
   , pv_value
   , add_pv_sales_net_val
   , price_diff_pct
   , total_adv_week_sales_net_val
   , total_adv_week_receipts_cnt
   , total_adv_week_sales_qty
   , pv_effect_pct
   , receipts_cnt
   , pv_value_combined
   , pv_fg
   , pv_nr_of_stores_per_item_adv_week
   , regular_nr_of_stores_per_item_adv_week
   , nr_of_stores_per_item_adv_week_pct
   , nr_of_stores_per_item_adv_week
   , pv_nr_of_stores_per_item_period
   , regular_nr_of_stores_per_item_period
   , nr_of_stores_per_item_period_pct
   , nr_of_stores_per_item_period
   , sales_price_net_old
   , sales_price_old
   , sales_price_net_new
   , sales_price_new
   , sales_1d_qty
   , sales_3d_qty
   , sales_7d_qty
)
AS
SELECT
pvp.client_id                                 AS client_id
,pvp.item_sid                                  AS item_sid
,1::SMALLINT                      AS action_type_id /* 1: indicates PV*/
,CAST(   (  itm.item_sid * 100::INTEGER  )  + itm.client_id AS INTEGER) AS item_mstr_sid
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
,pvp.adv_week_id                               AS adv_week_id
,CAST ( ( pvp.adv_week_id * 100::INTEGER )  + pvp.client_id AS INTEGER )
                                                   AS adv_week_sid
,pvp.orig_adv_week_id                          AS orig_adv_week_id
,pvp.assigned_pv_start_dt                      AS assigned_pv_start_dt
,pvp.assigned_pv_end_dt                        AS assigned_pv_end_dt
--CAST ( assigned_pv_start_dt /*** MSC-WARNING - MSCEWSMALLINT,033 - FORMAT 'E3' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/  AS VARCHAR ( 10 ) )
,TO_CHAR (assigned_pv_start_dt, 'DY')
     || ' - ' ||
--CAST ( assigned_pv_end_dt /*** MSC-WARNING - MSCEWSMALLINT,033 - FORMAT 'E3' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/ AS VARCHAR ( 10 ) )
TO_CHAR (assigned_pv_end_dt, 'DY')
                                              AS assigned_pv_period_descr
,pvp.adv_period_id                             AS adv_period_id
,pvp.pv_fg                                     AS orig_pv_fg_
,pvp.pv_local_fg                               AS orig_pv_local_fg
,pvp.vat_pct_val                               AS vat_pct_val
,pvp.vat_factor                                AS vat_factor
,pvp.total_sales_net_val                       AS total_sales_net_val
,pvp.total_pv_sales_net_val                    AS total_pv_sales_net_val
--CAST ( ( pvp.total_sales_net_val / CASE WHEN pvp.total_pv_sales_net_val = 0 THEN NULL ELSE pvp.total_pv_sales_net_val END) * 100.0
--AS NUMBER(38,5)
-- )                                          AS total_sales_net_val_pct
,DIV0( pvp.total_sales_net_val, pvp.total_pv_sales_net_val) * 100    
                                              AS total_sales_net_val_pct
,pvp.base_receipts_cnt                         AS base_receipts_cnt
,pvp.base_sales_qty                            AS base_sales_qty
,pvp.base_sales_net_val                        AS base_sales_net_val
,pvp.adv_period_nr_of_days                     AS adv_period_nr_of_days
,pvp.store_cnt_per_period                      AS store_cnt_per_period
,pvp.sales_qty                                 AS sales_qty
,pvp.sales_net_val                             AS sales_net_val
,pvp.sales_price_median_day                    AS sales_price_median_day
,pvp.store_cnt                                 AS store_cnt
,pvp.sales_price_old_median_day                AS sales_price_old_median_day
,pvp.pv_value                                  AS pv_value
,pvp.add_pv_sales_net_val                      AS add_pv_sales_net_val
,pvp.price_diff_pct                            AS price_diff_pct
,pvp.total_adv_week_sales_net_val              AS total_adv_week_sales_net_val
,pvp.total_adv_week_receipts_cnt               AS total_adv_week_receipts_cnt
,pvp.total_adv_week_sales_qty                  AS total_adv_week_sales_qty
,CAST (
            (
                ( pvp.add_pv_sales_net_val / CASE WHEN (-1.00 * pvp.pv_value ) = 0 THEN NULL ELSE (-1.00 * pvp.pv_value ) END
)  - 1.00
)* 100.0
AS NUMBER(38,5) )
                                   AS pv_effect_pct
,pvp.receipts_cnt                              AS receipts_cnt
,SUM
       (
       CASE WHEN pvp.pv_fg = 1 AND pvp.pv_local_fg = 0
           THEN
               pv_value
           ELSE
               CAST ( NULL AS NUMBER(38,5) )
           END
       )  OVER  ( PARTITION BY pvp.client_id , pvp.item_sid, pvp.adv_week_id )
                                                   AS pv_value_combined
,CASE WHEN pvp.pv_fg = 1 AND pv_value_combined < pa.pv_value_adv_week /*AND NOT  ( itm.src_subitemgrp_cd > 100 OR itm.src_subitemgrp_cd < 9 )  */
          AND NOT  ( itm.src_subitemgrp_cd > pa.pv_uwg_upperlimit OR itm.src_subitemgrp_cd < pa.pv_uwg_lowerlimit )
       THEN
           1::SMALLINT  /* a PV Value must have at least 1000 ? */
              /* exclude UWGs 996 | Leergut ( Pfand )  AND -1000 | Verkauf, Artikel_1 nicht in WaWi angelegt | 199 Pauschal |112 Elektrogeraete*/
       ELSE
           0::SMALLINT  /* do not consider*/
     END                                           AS pv_fg
,pvp.pv_nr_of_stores_per_item_adv_week         AS pv_nr_of_stores_per_item_adv_week
,pvp.regular_nr_of_stores_per_item_adv_week    AS regular_nr_of_stores_per_item_adv_week
,CAST (
            (
                ( CAST ( pvp.pv_nr_of_stores_per_item_adv_week AS NUMBER(38,5) )  / CASE WHEN CAST (  pvp.regular_nr_of_stores_per_item_adv_week AS NUMBER(38,5) ) = 0 THEN NULL ELSE CAST (  pvp.regular_nr_of_stores_per_item_adv_week AS NUMBER(38,5) ) END
)
)
AS NUMBER(38,5) )                       AS nr_of_stores_per_item_adv_week_pct
,pvp.pv_nr_of_stores_per_item_adv_week + pvp.regular_nr_of_stores_per_item_adv_week
                                                   AS nr_of_stores_per_item_adv_week
,pvp.pv_nr_of_stores_per_item_period           AS pv_nr_of_stores_per_item_period
,pvp.regular_nr_of_stores_per_item_period      AS regular_nr_of_stores_per_item_period
,CAST (
            (
                ( CAST ( pvp.pv_nr_of_stores_per_item_period AS NUMBER(38,5) )  / CASE WHEN CAST (  pvp.regular_nr_of_stores_per_item_period AS NUMBER(38,5) ) = 0 THEN NULL ELSE CAST (  pvp.regular_nr_of_stores_per_item_period AS NUMBER(38,5) ) END
)
)
AS NUMBER(38,5) )                       AS nr_of_stores_per_item_period_pct
,pvp.pv_nr_of_stores_per_item_period + pvp.regular_nr_of_stores_per_item_period
                                                   AS nr_of_stores_per_item_period
,pvp.sales_price_old AS sales_price_net_old /* VK_1  ( alt )   ( netto ) */
,CAST
       (
       pvp.sales_price_old * CAST ( ( 1.00 + pvp.vat_factor )  AS NUMBER(38,5) )
       AS NUMBER(38,5)
        )                                          AS sales_price_old /* VK_1  ( alt )   ( brutto )  */
,pvp.sales_price                               AS sales_price_net_new /* VK_1  ( netto )  PV: VK_1  ( neu ) */
,CAST
       (
       pvp.sales_price * CAST ( ( 1.00 + pvp.vat_factor )  AS NUMBER(38,5) )
       AS NUMBER(38,5)
        )                                          AS sales_price_new /* VK_1  ( brutto )  PV: VK_1  ( neu )   ( brutto )  */
,pvp.sales_1d_qty                              AS sales_1d_qty
,pvp.sales_3d_qty                              AS sales_3d_qty
,pvp.sales_7d_qty                              AS sales_7d_qty
FROM p_lew_mart_pit_onprem.t_pit_week_item_period_pv_1 pvp

/* ## Parameter TABLE */
INNER JOIN ( 
        SELECT
              CLIENT_ID    
			, MAX( iff(pa.param_id = 1,CAST(pa.param_value AS NUMBER(38,5)),NULL) )   				AS PV_THRESHOLD
			, MAX( iff(pa.param_id = 2,CAST(pa.param_value AS NUMBER(38,5)),NULL) )   				AS PV_SUNDAY_OPEN_THRESHOLD
			, MAX( iff(pa.param_id = 3,CAST(pa.param_value AS NUMBER(38,5)),NULL) )   				AS PV_LOCAL_PV_THRESHOLD
			, MAX( iff(pa.param_id = 5,CAST(pa.param_value AS INTEGER),NULL) )   					AS PV_TIME_GAP_IN_DAYS
			, MAX( iff(pa.param_id = 9,CAST(pa.param_value AS NUMBER(38,5)),NULL) )   				AS PV_VALUE_MONTH
			, MAX( iff(pa.param_id = 10,CAST(pa.param_value AS INTEGER),NULL) )   					AS PV_UWG_LOWERLIMIT
			, MAX( iff(pa.param_id = 11,CAST(pa.param_value AS INTEGER),NULL) )   					AS PV_UWG_UPPERLIMIT
			, MAX( iff(pa.param_id = 12,CAST(pa.param_value AS NUMBER(38,5)),NULL) )   				AS PV_VALUE_ADV_WEEK			  
        FROM        
		(
				SELECT * FROM P_LEW_MART_PIT_ONPREM.T_PIT_SCOPE_COUNTRY_PARAM_1 
				WHERE TRUE
					AND CURRENT_DATE() BETWEEN DWH_VALID_FROM AND DWH_VALID_TO
					AND	DELETED_FG 	= 0									
				QUALIFY VERSION_NR = MAX(VERSION_NR) OVER (PARTITION BY CLIENT_ID, PARAM_ID)
		) pa
        GROUP BY 1
        ) pa
ON  TRUE
    AND pa.client_id = pvp.client_id

/* ## Join new ClientItemDay View */
INNER JOIN p_lew_mart_pit_onprem.v_pit_item_client_day_hist_1 itm
ON
    TRUE
    AND pvp.client_id               = itm.client_id
    AND pvp.item_sid                = itm.item_sid
    AND pvp.assigned_pv_start_dt    = itm.dwh_cal_dt

WHERE
TRUE;