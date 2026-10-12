/*
#-------------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: DDL for view P_LEW_MART_LEAD.v_stc_item_nfb_wh_day_1
#-------------------------------------------------------------------------------
# History:
#  1.0  01.07.2019    Chandramani Kumbhale     Initial version.
#                                              VIEW migrated from MSI layer to LEAD layer for LEAD reports.
#                                              https://jira-lidl-public.pixsoftware.de/browse/IDMO-1975
#                                              20190701_2138_MCD_Obj_Migrt_To_Lead_Rep5
#  1.1  17.07.2020    Martin Lysik             20200702_2519_WH_Move_Store_Form_Access_DWH20
#                                              Pointed to new core stock-NFB table
#  1.2  30.12.2020    Michal Malinowski        20201214_2691_Frischfish_adjustments, REP3-7935
#                                              FrischFish WGI ID Conversion (3=>30,32) && (i(1,2,4,5,6,7,8,9)=>(i*10...)
#-------------------------------------------------------------------------------
*/



/*
#-------------------------------------------------------------------------------
# View: P_LEW_MART_LEAD.v_stc_item_nfb_wh_day_1
#-------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_STC_ITEM_NFB_WH_DAY_1
COMMENT = '$Revision: 16563 $ '

AS
SELECT
    bil.client_id                                                        AS client_id
  , cry.curr_cd_from                                                     AS currency_iso_cd
  , bil.dwh_cal_dt                                                       AS dat_calendar  /* Bestandsstichtag */
  , itmp.item_sid_map                                                    AS item_id
  , CAST(bil.price / cry.exchange_rate AS DECIMAL(18,4))                        AS price_retail
  , CAST(bil.price_net / cry.exchange_rate AS DECIMAL(19,5))                    AS price_retail_net
  , CAST(bil.stock_calc_qty / COALESCE(item.src_case_size, 1) AS DECIMAL(18,4)) AS qty_case_nfb_continuous  /* Umrechnen in Kolli damit Coex mit MIS korrekt ist */
  , CAST(0 AS DECIMAL(18,4))                                                    AS qty_case_nfb_diff
  , wh.src_wh_id                                                         AS wh_id
FROM P_LEW_BIL_AC.v_stock_location_item_1 AS bil

/* Ermitteln WH */
INNER JOIN P_LEW_BIL_AC.v_warehouse_1 AS wh
ON  bil.client_id    = wh.client_id
AND bil.loc_sid      = wh.loc_sid_wh
AND wh.dwh_actual_fg = 1

 /* Ermitteln Item_1 Infos */
INNER JOIN P_LEW_BIL_AC.v_item_1 AS item_1
ON  bil.client_id      = item.client_id
AND bil.item_sid       = item.item_sid
AND item.dwh_actual_fg = 1

INNER JOIN P_LEW_BIL_AC.v_itemgroup_international_1 AS wgi
ON  item.client_id             = wgi.client_id
AND item.item_grp_int_sid_asis = wgi.item_grp_int_sid

/* Kurse für Währungsumrechnung bestimmen */
INNER JOIN
(
    SELECT
        xr_kn_h.client_id
      , xrtyp.src_kurst
      , xr_kn_h.curr_cd_from
      , xr_kn_h.curr_cd_to
      , xr_kn_h.curr_sid_from
      , xr_kn_h.curr_sid_to
      , xr_kn_h.exchange_rate
      , xr_kn_h.active_from_dt
      , xr_kn_h.active_to_dt
      , xr_kn_h.deleted_fg
    FROM P_LEW_CORE_AC.v_exchange_rate_known_hist_1 AS xr_kn_h

    INNER JOIN P_LEW_CORE_AC.v_exchange_rate_type_1 AS xrtyp
    ON  xr_kn_h.client_id      = xrtyp.client_id
    AND xr_kn_h.x_rate_type_sid= xrtyp.x_rate_type_sid

    WHERE /* nur die aktuellste bekannte Kurs_1-Zeit_1-Tabelle: */
          Current_Date BETWEEN xr_kn_h.dwh_valid_from AND xr_kn_h.dwh_valid_to
          /* und nur die Berichtswesen-Kurse, diese werden extern geliefert als File und gelten als aktiv für einen langen Zeitraum: */
      AND xrtyp.src_kurst = '@BEWE'
) AS cry
ON  bil.client_id = cry.client_id
AND Current_Date BETWEEN cry.active_from_dt AND cry.active_to_dt

INNER JOIN P_LEW_CORE_AC.v_item_map_key_1 AS itmp
ON  itmp.client_id = bil.client_id
AND itmp.item_sid  = bil.item_sid

WHERE Cast(item.log_var_cd AS INTEGER) = 3             /* Beschaffungsvariante */
  AND Cast(wgi.src_itemgrp_int_cd AS INTEGER) IN ( 7, 70 )     /* Internationale Warengruppe Non-Food */
  AND wh.bges_active_fg = 1

UNION ALL

SELECT
    sinw.client_id
  , cry.currency_iso_cd
  , cal.cal_dt                                         AS dat_calendar
  , itmp.item_sid_map                                  AS item_id
  , sinw.retail_price     / cry.rate_currency_exchange AS price_retail
  , sinw.retail_net_price / cry.rate_currency_exchange AS price_retail_net
  , sinw.calc_stock_case_qty                           AS qty_case_nfb_continuous
  , CASE WHEN sinw.active_from_dt = cal.cal_dt
             THEN sinw.delta_case_qty
             ELSE 0
    END                                                AS qty_case_nfb_diff
  , wh.src_wh_id                                       AS wh_id
FROM P_LEW_CORE_AC.v_item_wh_stock_nfb_1 AS sinw

INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_1 AS cal
ON  cal.cal_dt BETWEEN sinw.active_from_dt AND sinw.active_to_dt
AND sinw.calc_stock_case_qty <> 0
AND sinw.deleted_fg = 0

INNER JOIN P_LEW_CORE_AC.v_wawi_ref_client_currency_rate_1 AS cry
ON  sinw.client_id = cry.client_id
AND Current_Date BETWEEN cry.dat_rec_start AND cry.dat_rec_end

INNER JOIN P_LEW_BIL_AC.v_warehouse_1 AS wh
ON  sinw.client_id   = wh.client_id
AND sinw.loc_sid     = wh.loc_sid_wh
AND wh.dwh_actual_fg = 1

INNER JOIN P_LEW_CORE_AC.v_item_map_key_1 AS itmp
ON  itmp.client_id = sinw.client_id
AND itmp.item_sid  = sinw.item_sid
    
WHERE wh.bges_active_fg = 1
;
