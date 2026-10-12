/*
#-------------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-------------------------------------------------------------------------------
# Interface: DDL for view P_LEW_MART_MSI.v_stc_item_nfb_wh_day_2
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------





#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  21.09.2017    H.Wieber                 Change loc_sid to loc_sid_wh
#  1.2  11.10.2017    Arnold.Arne              Spaltenreihenfolge fuer WAWI-Teil angepasst. ITEM_SID und DAT_CALENDAR waren vertauscht.
#  1.3  15.11.2017    Wieber.Harald            Release 1.1
#  1.4  16.11.2017    Thole.Jens               UNION->UNION ALL und Client-Einschränkung WAWI-Teil eliminiert. da sinnlos.
#  1.5  17.01.2018    Murtenthaler.Martin      WAWI-Item_2 if possible
#  1.6  17.01.2018    Wieber.Harald            Release 2.2
#  1.7  18.01.2018    Martin Murtenthaler      Group by Syntax changed
#  1.8  31.01.2018    Wieber,Harald            Release 2.3
#  1.9  17.04.2018    Michael Ueding           Gruppierung entfernt (erfolgt im FE)
#                                              Ermittlung Umrechnungskurs vereinheitlicht
#  2.0  18.04.2018    Michael Ueding           Datumstransformation Stichtag-1 ueber cal_calendarday
#  2.1  24.07.2018    Michael Ueding           Referenz Item_2 Mapping geaendert
#  2.2  05.11.2018    Thole,Jens               Umhängen auf historisierte globale Stockstruktur
#  2.3  30.09.2020    Martin Lysik             20200702_2519_WH_Move_Store_Form_Access_DWH20
#                                              Pointed to new core stock-NFB table
#  2.4  30.12.2020    Michal Malinowski        20201214_2691_Frischfish_adjustments, REP3-7935
#                                              FrischFish WGI ID Conversion (3=>30,32) && (i(1,2,4,5,6,7,8,9)=>(i*10...)
#  2.5  28.10.2021    Torsten Bachmann         20211026_2959_L145_bestande_eingelagert, REP3-9170
#                                              Added join to P_LEW_CORE_AC.v_client_migration_per_2
#-------------------------------------------------------------------------------
*/



/*
#-------------------------------------------------------------------------------
# View: P_LEW_MART_MSI.v_inv_stc_store_item_2
#-------------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_STC_ITEM_NFB_WH_DAY_2
COMMENT = '$Revision: 16565 $ '

AS
SELECT
    bil.client_id                                                               AS client_id
  , cry.curr_cd_from                                                            AS currency_iso_cd
  , bil.dwh_cal_dt                                                              AS dat_calendar  /* Bestandsstichtag */
  , itmp.item_sid_map                                                           AS item_id
  , CAST(bil.price / cry.exchange_rate AS DECIMAL(18,4))                        AS price_retail
  , CAST(bil.price_net / cry.exchange_rate AS DECIMAL(19,5))                    AS price_retail_net
  , CAST(bil.stock_calc_qty / COALESCE(item.src_case_size, 1) AS DECIMAL(18,4)) AS qty_case_nfb_continuous  /* Umrechnen in Kolli damit Coex mit MIS korrekt ist */
  , CAST(0 AS DECIMAL(18,4))                                                    AS qty_case_nfb_diff
  , wh.src_wh_id                                                                AS wh_id
FROM P_LEW_BIL_AC.v_stock_location_item_2 AS bil
INNER JOIN P_LEW_CORE_AC.v_client_migration_per_2 mig
ON bil.client_id = mig.client_id
AND bil.dwh_cal_dt BETWEEN mig.migration_dat_valid_from AND mig.migration_dat_valid_to

/* Ermitteln WH */
INNER JOIN P_LEW_BIL_AC.v_warehouse_2 AS wh
ON  bil.client_id    = wh.client_id
AND bil.loc_sid      = wh.loc_sid_wh
AND wh.dwh_actual_fg = 1

/* Ermitteln Item_2 Infos */
INNER JOIN P_LEW_BIL_AC.v_item_2 AS item_2
ON  bil.client_id      = item.client_id
AND bil.item_sid       = item.item_sid
AND item.dwh_actual_fg = 1

INNER JOIN P_LEW_BIL_AC.v_itemgroup_international_2 AS wgi
ON  item.client_id             = wgi.client_id
AND item.item_grp_int_sid_asis = wgi.item_grp_int_sid

/* Kurse für Währungsumrechnung bestimmen */
INNER JOIN P_LEW_MART_MSI.v_report_fixed_exchange_rate_2 AS cry
ON  bil.client_id = cry.client_id
AND CURRENT_DATE  BETWEEN cry.active_from_dt AND cry.active_to_dt

INNER JOIN P_LEW_CORE_AC.v_item_map_key_2 AS itmp
ON  itmp.client_id = bil.client_id
AND itmp.item_sid  = bil.item_sid

WHERE CAST(item.log_var_cd AS INTEGER) = 3             /* Beschaffungsvariante */
AND   CAST(wgi.src_itemgrp_int_cd AS INTEGER) IN ( 7, 70 )     /* Internationale Warengruppe Non-Food */
AND   wh.bges_active_fg = 1

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
FROM P_LEW_CORE_AC.v_item_wh_stock_nfb_2 AS sinw

INNER JOIN P_LEW_CORE_AC.v_cal_calendarday_2 AS cal
ON  cal.cal_dt BETWEEN sinw.active_from_dt AND sinw.active_to_dt
AND sinw.calc_stock_case_qty <> 0
AND sinw.deleted_fg = 0

INNER JOIN P_LEW_CORE_AC.v_client_migration_per_2 mig
ON sinw.client_id = mig.client_id
AND cal.cal_dt NOT BETWEEN mig.migration_dat_valid_from AND mig.migration_dat_valid_to

INNER JOIN P_LEW_CORE_AC.v_wawi_ref_client_currency_rate_2 AS cry
ON  sinw.client_id = cry.client_id
AND Current_Date BETWEEN cry.dat_rec_start AND cry.dat_rec_end

INNER JOIN P_LEW_BIL_AC.v_warehouse_2 AS wh
ON  sinw.client_id   = wh.client_id
AND sinw.loc_sid     = wh.loc_sid_wh
AND wh.dwh_actual_fg = 1

INNER JOIN P_LEW_CORE_AC.v_item_map_key_2 AS itmp
ON  itmp.client_id = sinw.client_id
AND itmp.item_sid  = sinw.item_sid

WHERE wh.bges_active_fg = 1
;

