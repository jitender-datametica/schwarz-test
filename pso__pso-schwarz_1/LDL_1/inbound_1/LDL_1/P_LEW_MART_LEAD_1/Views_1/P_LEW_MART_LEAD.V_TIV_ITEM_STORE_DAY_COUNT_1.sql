create or replace view LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_TIV_ITEM_STORE_DAY_COUNT_1(
	DAT_FORMDATE COMMENT 'DATUM DER INVENTURANFORDERUNG',
	CLIENT_ID COMMENT 'MIS CLIENT ID',
	REQUEST_ID COMMENT 'ANFORDERUNGS ID',
	LOC_SID_WH COMMENT 'S-KEY DER LOCATION_1 HIER DER GESELLSCHAFT',
	MOVE_TO_STORE_ID COMMENT 'S-KEY DER LOCATION_1 HIER DER FILIALE',
	ASPECT_ID COMMENT 'GESELLSCHAFTSFORM (1 = BETRIEBS- 2 = VERTRIEBSGESELLSCHAFT)',
	CURRENCY_ISO_CD COMMENT '3 STELLIGER WÄHRUNGS-CODE',
	CURR_TOT_ID COMMENT 'INTERNER WÄHRUNGS-CODE',
	REQUEST_LIST_ID COMMENT 'ANFORDERUNGS LITE ID',
	INV_TYPE_ID COMMENT 'INVENTURTYP',
	STOCK_CORR_REQ_STATUS_ID COMMENT 'STATUS_1 DER INVENTURANFORDERUNG',
	ITEM_SID COMMENT 'S-KEY DER ARTIKEL_1',
	CNT_REASON_ID COMMENT 'GRUND DER INVENTURANFORDERUNG',
	ACT_ITEM_CNT COMMENT 'GEZÄHLTE MENGE',
	SOLL_BESTAND COMMENT 'SOLLMENGE',
	KORREKTURMENGE COMMENT 'KORREKTURMENGE',
	PRICE_RETAIL_NETTO,
	KORREKTURWERT,
	INV_CNT COMMENT 'REPORTING-ZÄHLER',
	QTY_STC_CALC COMMENT 'STC SOLLBESTAND',
	KORREKTURMENGE_DYNAMISCH COMMENT 'KORREKTURMENGE_DYNAMISCH',
	KORREKTURWERT_DYNAMISCH COMMENT 'KORREKTURWERT_DYNAMISCH'
) as
WITH RELEVANT_SCOPE AS (
    

    SELECT DISTINCT 
           requested_cnt_dt
         , client_id
         , item_sid
         , move_to_store_id
         , aspect_id
    FROM p_lew_mart_lead.t_tiv_item_store_day_count_1
    WHERE requested_cnt_dt <= CURRENT_DATE
      AND client_id < 41
),
STC_AGGREGATED AS (
    
    SELECT 
           sli.client_id
         , mrg.move_to_store_id
         , mrg.aspect_id
         , sli.item_sid
         , sli.dwh_cal_dt AS dat_formdate
         , SUM(sli.stock_calc_qty) AS qty_stc_calc
    FROM p_lew_bil_ac.v_stock_location_item_1 sli
    INNER JOIN P_LEW_MART_LEAD_AC.v_org_store_merge_1 mrg
        ON  sli.client_id = mrg.client_id
        AND sli.loc_sid = mrg.store_id
        AND mrg.mis_store_active_fg = 1
        AND mrg.test_store_fg = 0
        AND sli.dwh_cal_dt BETWEEN mrg.dat_opening_ovis AND COALESCE(mrg.dat_closing_ovis, DATE '9999-12-31')
    
    INNER JOIN RELEVANT_SCOPE rel
        ON  sli.client_id = rel.client_id
        AND sli.item_sid = rel.item_sid
        AND sli.dwh_cal_dt = rel.requested_cnt_dt
        AND mrg.move_to_store_id = rel.move_to_store_id
        AND mrg.aspect_id = rel.aspect_id
    GROUP BY 1, 2, 3, 4, 5
)
SELECT 
       tiv.requested_cnt_dt AS dat_formdate
     , tiv.client_id
     , tiv.request_id
     , tiv.loc_sid_wh
     , tiv.move_to_store_id
     , tiv.aspect_id
     , tiv.currency_iso_cd
     , tiv.curr_tot_id
     , tiv.request_list_id
     , tiv.inv_type_id
     , tiv.stock_corr_req_status_id
     , tiv.item_sid
     , tiv.cnt_reason_id
     , tiv.act_item_cnt
     , tiv.soll_bestand
     , tiv.korrekturmenge
     , tiv.price_retail_netto
     , tiv.korrekturwert
     , tiv.inv_cnt
     , ZEROIFNULL(stc.qty_stc_calc) AS qty_stc_calc
     , (tiv.act_item_cnt - ZEROIFNULL(stc.qty_stc_calc))::NUMBER(38,4) AS korrekturmenge_dynamisch
     , ((tiv.act_item_cnt - ZEROIFNULL(stc.qty_stc_calc)) * tiv.price_retail_netto)::NUMBER(38,4) AS korrekturwert_dynamisch
FROM p_lew_mart_lead.t_tiv_item_store_day_count_1 tiv
LEFT JOIN STC_AGGREGATED stc
    ON  tiv.client_id = stc.client_id
    AND tiv.move_to_store_id = stc.move_to_store_id
    AND tiv.aspect_id = stc.aspect_id
    AND tiv.requested_cnt_dt = stc.dat_formdate
    AND tiv.item_sid = stc.item_sid
;
