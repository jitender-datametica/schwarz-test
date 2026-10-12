/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_CLIENT_ORDER_CONSOLIDATED
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski, Michal           Initial Version
#  1.1  13.04.2022    Aparna Rayanki               Added column selection_purch_net_euro_price joining with V_MDM_ITEM_HIST 
#                                                  to improve Performance of MSTR report 'AM Tagesreporting'
#  1.2  23.05.2022    Aparna Rayanki               Added filter and additional columns 
#                                                  to improve Performance of MSTR report 'AM Tagesreporting'
#  1.3  17.06.2022    Aparna Rayanki               Added additional columns
#  1.4  06.02.2023    Aparna Rayanki               Filter applied to get active items and filter out rejected items
#                                                  removed prices from item_hist
#  1.5  16.02.2023    Aparna Rayanki               Added Säule and corrected ek_net_volume logic
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_CLIENT_ORDER_CONSOLIDATED(
	 CLIENT_ID
	,MDM_ITEM_SID
	,MDM_ITEM_NAME
	,CLIENT_ID_ORDER
	,CLIENT_CD
	,LOB_CD
	,CLIENT_BLOCK_ID_ORDER
	,ITEM_IAN
	,RANGE_PLAN_CD
	,STEP_ITEM_NR
	,MAX_SET_MULTIPACK_FG
	,ITEM_WORKFLOW_STATUS_ID
	,ITEM_FAM_GRP_SID
	,BRAND_SID
	,COUNTRY_POL_SID_ORIGIN
	,MDM_SUP_SID
	,EAN_OWNERSHIP_CD
	,SUP_FINAL_FG
	,MARKET_SID
	,KFL_BRAND_SID
	,ITEM_QUALITY_CLASS_CD
	,ITEM_CLASS_CD
	,CBX_ORDER_VERSION
	,CY_WEEK_ADVERTISE
	,CY_WEEK_IMPORT
	,CLIENT_SELL_FROM_DT
	,CLIENT_ORDER_CARTON_WEIGHT
	,CLIENT_ORDER_TOTAL_QTY
	,CLIENT_ORDER_TOTAL_CARTON_QTY
	,CLIENT_ORDER_NOTES
	,LDL_STORE_CNT
	,KFL_LARGE_STORE_CNT
	,KFL_SMALL_STORE_CNT
	,PURCH_NET_EURO_PRICE
	,SALES_VAT_PCT
	,SALES_GROSS_EURO_PRICE
	,EK_NET_VOLUME
	,MIN_CY_WEEK_DELIVERY
	,MIN_CY_WEEK_DELIVERY_REAL_FG
	,FROM_CAL_DT
	,DELETED_FG
	,DWH_VALID_FROM
	,DWH_VALID_TO
	,DWH_LOAD_ID
	,DWH_CREATED
	,DWH_UPDATED
) AS
SELECT
    /** Client_Order **/
      ico.client_id
    , ico.mdm_item_sid
    , i.mdm_item_name
    , ico.client_id_order
    , ico.client_cd
    , ct.lob_cd
    , ico.client_block_id_order
    , i.item_ian
    , i.range_plan_cd
    , i.step_item_nr
    , iset.max_set_multipack_fg
    , ih.item_workflow_status_id
    , ih.item_fam_grp_sid
    , ih.brand_sid
    , ih.country_pol_sid_origin         
    , ih.mdm_sup_sid                    
    , ih.ean_ownership_cd               
    , ih.sup_final_fg 
    , ih.market_sid
    , ih.kfl_brand_sid
    , ih.item_quality_class_cd
    , ih.item_class_cd

    /** Client_Order_Hist **/
    , icoh.cbx_order_version
    , icoh.cy_week_advertise
    , icoh.cy_week_import
    , icoh.client_sell_from_dt
    , icoh.client_order_carton_weight
    , icoh.client_order_total_qty
    , icoh.client_order_total_carton_qty
    , icoh.client_order_notes
    , icoh.ldl_store_cnt
    , icoh.kfl_large_store_cnt
    , icoh.kfl_small_store_cnt
    , icoh.purch_net_euro_price
    , CASE
           WHEN ico.client_id_order BETWEEN 2000 AND 3999 AND icoh.sales_vat_pct BETWEEN 1 AND 1.9
                THEN (icoh.sales_vat_pct-1)*100
           ELSE icoh.sales_vat_pct
      END sales_vat_pct
    , icoh.sales_gross_euro_price
    , icoh.client_order_total_qty * (CASE WHEN icoh.purch_net_euro_price IS NULL
                                                 THEN ipp.selection_purch_net_euro_price
                                             ELSE icoh.purch_net_euro_price
                                        END) AS ek_net_volume

   -- ,icodh.cy_week_delivery
    , icodh.min_cy_week_delivery
    , icodh.min_cy_week_delivery_real_fg
    , IFF(min_cy_week_delivery_real_fg=0,'9999-12-30'::DATE,cw.from_cal_dt) AS from_cal_dt

    , icoh.deleted_fg
    , icoh.dwh_valid_from
    , icoh.dwh_valid_to
    , icoh.dwh_load_id
    , icoh.dwh_created
    , icoh.dwh_updated

FROM P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_CLIENT_ORDER ico
     INNER JOIN P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_CLIENT_ORDER_HIST icoh
            ON ico.mdm_item_sid=icoh.mdm_item_sid
            AND ico.client_id_order=icoh.client_id_order
            AND CURRENT_DATE BETWEEN icoh.dwh_valid_from AND icoh.dwh_valid_to
            AND icoh.deleted_fg=0
    INNER JOIN P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM  i
            ON ico.mdm_item_sid = i.mdm_item_sid
    INNER JOIN P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_HIST ih
            ON i.mdm_item_sid = ih.mdm_item_sid
            AND CURRENT_DATE BETWEEN ih.dwh_valid_from AND ih.dwh_valid_to
            AND ih.deleted_fg=0
    INNER JOIN  P_LEW_FE_MSTR_APOLLO.v_item_familygroup fg
            ON  ih.item_fam_grp_sid = fg.item_fam_grp_sid
    INNER JOIN  P_LEW_FE_MSTR_APOLLO.V_MDM_CLIENT ct
            ON  ico.client_id_order = ct.client_id
    LEFT OUTER JOIN
                (
                 SELECT
                    icodh.mdm_item_sid
                    ,icodh.client_id_order
                    --,LTRIM(CAST(listAgg(TRIM(icodh.cy_week_delivery),',') WITHIN GROUP (ORDER BY icodh.country_del_seq_nr) AS VARCHAR(100) ),',') AS cy_week_delivery
                    ,MIN(CASE WHEN country_delivery_qty>0 THEN icodh.cy_week_delivery ELSE NULL END) min_cy_week_delivery
                    ,IFF(SUBSTRING(min_cy_week_delivery,5,2)=99, 0,1) AS min_cy_week_delivery_real_fg
                  FROM P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_CLIENT_ORDER_DELIVERY_HIST icodh
                  WHERE CURRENT_DATE BETWEEN icodh.dwh_valid_from AND icodh.dwh_valid_to
                    AND icodh.deleted_fg=0 
                  GROUP BY icodh.mdm_item_sid,icodh.client_id_order
                ) icodh
            ON ico.mdm_item_sid=icodh.mdm_item_sid
            AND ico.client_id_order=icodh.client_id_order
    LEFT OUTER JOIN P_LEW_CORE.T_CAL_WEEK_PARTIAL cw
                               ON icodh.min_cy_week_delivery=cw.cy_week
                              AND cw.cy_week_part=1
    LEFT OUTER JOIN
                (SELECT
                  mdm_item_sid
                 ,MAX(set_multipack_fg) max_set_multipack_fg
                 ,COUNT(DISTINCT set_multipack_fg) dist_set_multipack_fg
                 FROM P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_SET
                 GROUP BY mdm_item_sid
                ) iset
            ON i.mdm_item_sid=iset.mdm_item_sid
/* Lookup selection_purch_net_euro_price */
LEFT OUTER JOIN
    (
            SELECT
            iph.mdm_item_sid
            ,iph.item_price selection_purch_net_euro_price
            FROM
            (
                SELECT 
                ps.mdm_price_scenario_nr
                FROM p_lew_core.t_mdm_price_scenario ps
                INNER JOIN p_lew_core.t_mdm_price_type pt
                ON pt.mdm_price_Type_cd=ps.mdm_price_type_cd
                WHERE pt.mdm_price_type_name='EK-Preis AM' --selection_purch_net_euro_price
            ) ips
            INNER JOIN p_lew_core.t_mdm_item_price_hist iph
                ON ips.mdm_price_scenario_nr=iph.mdm_price_scenario_nr
                AND iph.deleted_fg=0
                AND CURRENT_DATE BETWEEN iph.dwh_valid_from AND iph.dwh_valid_to
    ) ipp
    ON ipp.mdm_item_sid=i.mdm_item_sid
    WHERE fg.src_familygrp_cd NOT IN ('995.200')
      AND i.item_ian<>0
      AND ih.item_workflow_status_id NOT IN (6) /* items rejected */
      AND ih.cbx_item_doc_status='active'       /* Active items */
;