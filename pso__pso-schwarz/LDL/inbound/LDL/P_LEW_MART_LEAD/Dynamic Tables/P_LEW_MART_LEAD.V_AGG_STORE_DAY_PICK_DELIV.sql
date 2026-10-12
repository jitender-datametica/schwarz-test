create or replace dynamic table LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_LEAD.V_AGG_STORE_DAY_PICK_DELIV(
	CLIENT_ID COMMENT 'Identification of a country',
	LOC_SID_STORE_MOVE_TO COMMENT 'SID for the store',
	WH_LOC_SID COMMENT 'SID for warehouse',
	WH_ID COMMENT 'warehouse ID',
	ASPECT_ID COMMENT '1 - BGES, 2 - VGES',
	CROSSDOCKING_FG COMMENT '1 - warehouse picks cases for the stores belonging to other warehouses, 0 - warehouse picks cases for its own stores',
	DAT_FORMDATE COMMENT 'calendar date',
	CY_MONTH COMMENT 'calendar month',
	CY_WEEK COMMENT 'calendar week',
	PICKING_MAIN_AREA_NR_PP COMMENT 'main picking area number',
	PICKING_MAIN_AREA_DESC_PP COMMENT 'maini picking area description',
	PICKING_AREA_NR_PP COMMENT 'picking area number',
	PICKING_AREA_DESC_PP COMMENT 'picking area description',
	CURR_TOT_ID COMMENT 'currency id',
	CURRENCY_ISO_CD COMMENT 'currency identification code',
	QTY_ORD_CASE COMMENT 'Zuteilung',
	QTY_DEL_CASE COMMENT 'picked cases without Zuteilung',
	FOREIGN_STORE_CASE COMMENT 'Amount of picked cases when crossdocking',
	ORDER_CNT COMMENT 'amount of order position'
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_LDL_D_DYNAMIC_TABLE_P_LEW_MART_LEAD
 as
SELECT
    src.CLIENT_ID
  , src.LOC_SID_STORE_MOVE_TO
  , src.WH_LOC_SID
  , src.WH_ID
  , src.ASPECT_ID
  , src.CROSSDOCKING_FG
  , src.DAT_FORMDATE
  , src.CY_MONTH
  , src.CY_WEEK
  , src.PICKING_MAIN_AREA_NR_PP
  , src.PICKING_MAIN_AREA_DESC_PP
  , src.PICKING_AREA_NR_PP
  , src.PICKING_AREA_DESC_PP
  , cur.curr_tot_id
  , cur.currency_iso_cd
  , SUM(src.QTY_ORD_CASE) AS QTY_ORD_CASE
  , SUM(src.QTY_DEL_CASE) AS QTY_DEL_CASE
  , SUM(src.foreign_store_case) AS foreign_store_case
  , SUM(src.ORDER_CNT) AS ORDER_CNT
FROM
    (
    SELECT
        pck.CLIENT_ID
      , pck.LOC_SID_STORE_MOVE_TO
      , pck.wh_loc_sid
      , IFF(pck.wh_id <> act.wh_id,pck.wh_id,act.wh_id) AS wh_id
      , pck.ASPECT_ID
      , IFF(pck.wh_id <> act.wh_id, 1, 0) AS crossdocking_fg
      , pck.DAT_FORMDATE
      , pck.CY_MONTH
      , pck.CY_WEEK
      , (10 * (TRUNC(slot.STC_LOCATION_NR_WAMAS / 10))) AS PICKING_MAIN_AREA_NR_PP
      , pp.PICKING_MAIN_AREA_DESC_PP AS PICKING_MAIN_AREA_DESC_PP
      , IFNULL(area.PICKING_AREA_NR_PP,0) AS picking_area_nr_pp
      , IFNULL(area.PICKING_AREA_DESC_PP, 'DummY') AS picking_area_desc_pp
      , pck.QTY_ORD_CASE
      , pck.QTY_DEL_CASE
      , (CASE WHEN crossdocking_fg = 1 THEN IFNULL(pck.qty_del_case,0) ELSE 0 END) + (CASE WHEN crossdocking_fg = 1 THEN IFNULL(pck.qty_ord_case,0) ELSE 0 END) AS foreign_store_case
      , pck.ORDER_CNT
    FROM
        P_LEW_MART_LEAD.T_AGG_STORE_DAY_PICK_DELIV pck
    LEFT OUTER JOIN p_lew_bil_ac.v_org_all_store_merge act
    ON pck.client_id = act.client_id
    AND pck.loc_sid_store_move_to = act.move_to_store_id
    AND pck.aspect_id = act.aspect_id
    LEFT OUTER JOIN P_LEW_CORE_AC.V_WAWI_STC_SLOT_AREA slot
        ON  slot.CLIENT_ID         = pck.CLIENT_ID
        AND slot.WH_LOC_SID        = pck.WH_LOC_SID
        AND pck.STC_SLOT_ID        BETWEEN slot.STC_SLOT_ID_FROM AND slot.STC_SLOT_ID_UNTIL
        AND slot.DAT_REC_END       = '9999-12-31'
    LEFT OUTER JOIN
        ( SELECT
              PICKING_MAIN_AREA_NR_PP
            , PICKING_MAIN_AREA_DESC_PP
          FROM P_LEW_BIL_AC.V_ITM_PP_PICKING_MAIN_AREA pp
          GROUP BY 1,2
        ) pp
        ON  (10 * (TRUNC(slot.STC_LOCATION_NR_WAMAS / 10))) = pp.PICKING_MAIN_AREA_NR_PP
    LEFT OUTER JOIN
        ( SELECT
              pa.CLIENT_ID
            , pa.CLIENT_ID         AS LANGUAGE_ID
            , pa.PICK_AREA_DESCR   AS PICKING_AREA_DESC_PP
            , pa.PICK_AREA_ID      AS PICKING_AREA_NR_PP
            , wh.SRC_WH_ID         AS WH_ID_PP
          FROM
              P_LEW_CORE_AC.V_REF_PICK_AREA_DESCR AS pa
          -- Auflösung WH
          INNER JOIN P_LEW_BIL_AC.V_WAREHOUSE AS wh
              ON wh.CLIENT_ID = pa.CLIENT_ID
              AND wh.LOC_SID_WH = pa.LOC_SID
              AND wh.DWH_ACTUAL_FG = 1
          -- außer Stiftungssprache
          WHERE pa.LANG_SID <> 2
        ) AS area
        ON  area.CLIENT_ID = pck.CLIENT_ID
        AND area.WH_ID_PP = pck.WH_ID
        AND area.PICKING_AREA_NR_PP = slot.STC_LOCATION_NR_WAMAS
   -- WHERE  slot.STC_SLOT_SEND_CD   = 1 /*indicate picking areas that have been sent to WAMAS */
    QUALIFY RANK()
    OVER(PARTITION BY pck.CLIENT_ID, pck.WH_LOC_SID, pck.WH_ID, pck.LOC_SID_STORE_MOVE_TO, pck.STC_SLOT_ID
    ORDER BY slot.DAT_REC_START DESC NULLS LAST)=1
    ) src
INNER JOIN p_lew_mart_lead.v_ref_currency cur
ON src.client_id = cur.client_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
;
