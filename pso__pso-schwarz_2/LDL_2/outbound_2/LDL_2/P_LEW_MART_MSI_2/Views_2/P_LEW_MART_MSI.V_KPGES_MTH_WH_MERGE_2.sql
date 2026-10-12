/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_KPGES_MTH_WH_MERGE_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  01.12.2017    Webster,Stuart           Add Austria SAP data
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  19.03.2018    Webster,Stuart           Update to include change of logic in 20170911_1454_Erweiterung_Bewegungsdaten_Lagerinventur
#  1.5  22.05.2018    Davis,Mike               Tidy up joins and ignore item_2 criteria.
#  1.6  28.01.2019    Michael Beerweiler       20190122_1929_InvDiffFiliale_neuer_Extraktor_Views
#                                              Umstellung auf neuen Extraktor/neue Core-Tabelle
#  1.7  31.03.2019    Camerzan,Dumitru         Replaced LEW_CORE_AC.V_WAWI_INDICATOR_MONTH_2 with LEW_BIL_AC.V_KPI_MONTH_2
#  1.8  22.02.2021    Prasanna Ranjan          REP2-9080 - Include item_2 types ZKM and ZVM from USA and Serbia
#  1.9  22.02.2021    Mittler Patrick          20210222_2758_wk_moni_fix_cry Include indicator_id 315,322,325
#  1.10 02.05.2022    Jaroslaw Syrokosz        LV: dummy_2 values for 2020 and 2021 until it started to operate INC430866, AP0127218
#       12.04.2024    Stephane Djiomou Tonga   Master Version was remigrated from Dev to Prod
#  1.12 01.07.2024    Marcin Malec             add logic for indicator 338, 339; average headcount for last only open 12 months; User Story 643630
#  1.13 22.05.2025    Marcin Malec             Division by zero hotfix
#  1.14 10.10.2025    Marcin Malec             add logic for indicator 340, 341; sum for last 12 months, calculated by month; User Story 767991
#----------------------------------------------------------------------------
*/


-- fuer kolli nur aspect_id = 1 relevant, weil nur BGES beruecksichtigt wird

/* This query produces val_indicators just for indicator_id = 315 (Kolli) AND
    BGES (org_type_id = 50 -> acpect_id = 1) on montly-level.
    Zweck:
    - Datenschutz fuer Kolli (Indicator_id = 315) duerfen auf Tagesebene (P_LEW_BIL.v_kpi_day_2) in dieser VIEW
      nicht ausgegeben werden.
    - Kollis werden auf Wochen (P_LEW_MART_MSI.v_kpges_week_wh_merge_2)
      und Monatsebene mit aufgenommen ( P_LEW_MART_MSI.v_kpges_mth_wh_merge_2)
----------------------------------------------------------------------- */
/* Block 1:
This query produces indicator values for all clients.
All indicators are processed both in EUR and the currency of the client_id country.
For all indicator_ids other than 117 there is no further processing.

Indicator_id = 117.
The query determines if the client_id was running in WAWI or SAP (eLwis) during the givem month
(established with: v_kpi_month.imth.cy * 100 + v_kpi_month.month_id) which the indicator value represents.

If the client_id has been migrated to eLwis then the values from KPGES are not processed further. If the
client_id has not been migrated then using the VAT factor (MwSt) calculated from the associated stock-take
values the indicator value is reduced by dividing the value by the calculated VAT. If the VAT factor cannot
be calculated due to no stock take data being available then the value is returned without further manipulation.

If the client_id = 1 and the indicator_id = 117 and the lies withing the time period where the client_id is
running on eLwis then the value from KPGES is ignored and the value returned is 0.

------------------------------------------------------------------------- */
-- BGES = 50 -> aspect_id = 1; VGES = 60 -> aspect_id = 2
 /* generate 1, 2 for aspect_id */
/* Ungefilterte Artikelarten */ /* Nur die Bewegungsarten, welche Inventuren betreffen oder NULL */
/* eLwis for this month */ -- BGES = 50 -> aspect_id = 1; VGES = 60 -> aspect_id = 2

/* LV fix - dummy_2 values for 2020 and 2021 until it started to operate INC430866, AP0127218
----------------------------------------------------------------------- */
/* Block 2:
This query produces indicator values for indicator_id = 117 and client_id = 1 for the time period where this client_id
was running on eLwis.

------------------------------------------------------------------------- */
-- fuer kolli nur aspect_id = 1 relevant, weil nur BGES beruecksichtigt wird

CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_kpges_mth_wh_merge_2 (client_id, wh_id, aspect_id, indicator_id, cy_month,
val_indicator, currency_iso_cd, dat_dayend) AS SELECT client_id,
 wh_id,
 aspect_id,
 indicator_id,
 cy_month,
 SUM(val_indicator) AS val_indicator,
 currency_iso_cd,
 MAX(dat_dayend) AS dat_dayend
FROM (SELECT wh.client_id,
    wh.wh_id,
    wh.aspect_id,
    wh.indicator_id,
    wh.cy_month,
     CASE
     WHEN wh.indicator_id = 117 AND wh.indicator_type_id = 1 AND wh.mig_fg = 0
     THEN CASE
      WHEN alt_mwst.mwst IS NOT NULL
      THEN wh.val_indicator / alt_mwst.mwst
      ELSE wh.val_indicator
      END
     WHEN wh.indicator_id = 117 AND wh.indicator_type_id = 1 AND wh.mig_fg = 1 AND wh.client_id = 1
     THEN 0
     WHEN wh.indicator_id = 338
     THEN (SELECT ROUND(SUM(SUBQRY.val_indicator) / IF(COALESCE(CASE
             WHEN SUM(CASE
                WHEN SUBQRY.val_indicator <> 0
                THEN 1
                ELSE 0
                END) <> 0
             THEN SUM(CASE
               WHEN SUBQRY.val_indicator <> 0
               THEN 1
               ELSE 0
               END)
             ELSE 1
             END, 1) = 0, NULL, COALESCE(CASE
            WHEN SUM(CASE
               WHEN SUBQRY.val_indicator <> 0
               THEN 1
               ELSE 0
               END) <> 0
            THEN SUM(CASE
              WHEN SUBQRY.val_indicator <> 0
              THEN 1
              ELSE 0
              END)
            ELSE 1
            END, 1)), 2) AS val_indicator_val_indicator_val_indicator
      FROM ldl_p_lew_bil_ac.v_kpi_month_2 AS SUBQRY
       INNER JOIN ldl_p_lew_core_ac.v_cal_month_2 AS SUBMON ON SUBQRY.cy * 100 + SUBQRY.month_id = SUBMON.cy_month AND
         SUBMON.cy_month_seq BETWEEN MON.cy_month_seq - 11 AND MON.cy_month_seq
      WHERE wh.client_id = SUBQRY.client_id
       AND wh.wh_id = SUBQRY.org_unit_nr
       AND SUBQRY.indicator_id = 236
       AND SUBQRY.indicator_type_id = 1
       AND SUBQRY.org_type_id IN (50, 60))
     WHEN wh.indicator_id = 339
     THEN (SELECT ROUND(SUM(SUBQRY0.val_indicator) / IF(COALESCE(CASE
             WHEN SUM(CASE
                WHEN SUBQRY0.val_indicator <> 0
                THEN 1
                ELSE 0
                END) <> 0
             THEN SUM(CASE
               WHEN SUBQRY0.val_indicator <> 0
               THEN 1
               ELSE 0
               END)
             ELSE 1
             END, 1) = 0, NULL, COALESCE(CASE
            WHEN SUM(CASE
               WHEN SUBQRY0.val_indicator <> 0
               THEN 1
               ELSE 0
               END) <> 0
            THEN SUM(CASE
              WHEN SUBQRY0.val_indicator <> 0
              THEN 1
              ELSE 0
              END)
            ELSE 1
            END, 1)), 2) AS val_indicator_val_indicator_val_indicator
      FROM ldl_p_lew_bil_ac.v_kpi_month_2 AS SUBQRY0
       INNER JOIN ldl_p_lew_core_ac.v_cal_month_2 AS SUBMON0 ON SUBQRY0.cy * 100 + SUBQRY0.month_id = SUBMON0.cy_month AND
         SUBMON0.cy_month_seq BETWEEN MON.cy_month_seq - 11 AND MON.cy_month_seq
      WHERE wh.client_id = SUBQRY0.client_id
       AND wh.wh_id = SUBQRY0.org_unit_nr
       AND SUBQRY0.indicator_id = 237
       AND SUBQRY0.indicator_type_id = 1
       AND SUBQRY0.org_type_id IN (50, 60))
     WHEN wh.indicator_id = 340
     THEN (SELECT ROUND(SUM(SUBQRY1.val_indicator), 2) AS val_indicator
      FROM ldl_p_lew_bil_ac.v_kpi_month_2 AS SUBQRY1
       INNER JOIN ldl_p_lew_core_ac.v_cal_month_2 AS SUBMON1 ON SUBQRY1.cy * 100 + SUBQRY1.month_id = SUBMON1.cy_month AND
         SUBMON1.cy_month_seq BETWEEN MON.cy_month_seq - 11 AND MON.cy_month_seq
      WHERE wh.client_id = SUBQRY1.client_id
       AND wh.wh_id = SUBQRY1.org_unit_nr
       AND SUBQRY1.indicator_id = 191
       AND SUBQRY1.indicator_type_id = 1
       AND SUBQRY1.org_type_id IN (50))
     WHEN wh.indicator_id = 341
     THEN (SELECT ROUND(SUM(SUBQRY2.val_indicator), 2) AS val_indicator
      FROM ldl_p_lew_bil_ac.v_kpi_month_2 AS SUBQRY2
       INNER JOIN ldl_p_lew_core_ac.v_cal_month_2 AS SUBMON2 ON SUBQRY2.cy * 100 + SUBQRY2.month_id = SUBMON2.cy_month AND
         SUBMON2.cy_month_seq BETWEEN MON.cy_month_seq - 11 AND MON.cy_month_seq
      WHERE wh.client_id = SUBQRY2.client_id
       AND wh.wh_id = SUBQRY2.org_unit_nr
       AND SUBQRY2.indicator_id = 239
       AND SUBQRY2.indicator_type_id = 1
       AND SUBQRY2.org_type_id IN (50))
     ELSE wh.val_indicator
     END AS val_indicator,
    wh.currency_iso_cd,
     CASE
     WHEN wh.indicator_id = 117 AND wh.indicator_type_id = 1 AND wh.mig_fg = 1 AND wh.client_id = 1
     THEN NULL
     ELSE wh.dat_dayend
     END AS dat_dayend
   FROM (SELECT IMTH.client_id,
      IMTH.org_unit_nr AS wh_id,
       CASE
       WHEN IMTH.org_type_id = 50
       THEN 1
       ELSE 2
       END AS aspect_id,
      IMTH.indicator_id,
      IMTH.cy,
        IMTH.cy * 100 + IMTH.month_id AS cy_month,
       CASE
       WHEN IMTH.indicator_id IN (117, 120, 125, 126, 133, 135, 136, 155, 156, 157, 163, 168, 169, 170, 172, 174, 177,
         179, 203, 204, 209, 210, 212, 216, 228, 229, 230, 238, 240, 242, 250, 251, 255, 256, 257, 258, 259, 260, 261,
         270, 271, 272, 273, 280, 281, 282, 283, 284, 286)
       THEN IMTH.val_indicator / cry.rate_currency_exchange
       ELSE IMTH.val_indicator
       END AS val_indicator,
      cry.currency_iso_cd,
      IMTH.dat_dayend,
       CASE
       WHEN (IMTH.cy * 100 + IMTH.month_id) BETWEEN ROUND(CAST(FORMAT_DATE('%Y%m', MIG.migration_dat_valid_from) AS BIGNUMERIC)
         , 0) AND (ROUND(CAST(FORMAT_DATE('%Y%m', MIG.migration_dat_valid_to) AS BIGNUMERIC), 0))
       THEN 1 /* eLwis for this month */
       ELSE 0 /* Wawi  for this month */
       END AS mig_fg,
      IMTH.indicator_type_id
     FROM ldl_p_lew_bil_ac.v_kpi_month_2 AS IMTH
      INNER JOIN (SELECT B.client_id,
        B.curr_cd_from AS currency_iso_cd,
        B.curr_cd_to AS to_currency_iso_cd,
        B.exchange_rate AS rate_currency_exchange
       FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS B
        INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS C ON B.client_id = C.client_id AND B.x_rate_type_sid = C.x_rate_type_sid
            AND C.src_kurst = '@BEWE'
       WHERE CURRENT_DATE BETWEEN B.active_from_dt AND B.active_to_dt
        AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to) AS cry ON IMTH.client_id = cry.client_id
      INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS MIG ON IMTH.client_id = MIG.client_id
     WHERE IMTH.indicator_type_id = 1
      AND IMTH.org_type_id IN (50, 60)) AS wh
    LEFT JOIN (SELECT client_id,
      wh_id,
      FORMAT_DATE('%Y%m', inv_end_date) AS cy_month,
       SUM(val_retail) / IF(SUM(val_retail_net) = 0, NULL, SUM(val_retail_net)) AS mwst
     FROM ldl_p_lew_mart_msi_ac.v_inv_wh_ejr_txj_ww_2 AS WW
     GROUP BY client_id,
      wh_id,
      cy_month) AS alt_mwst ON CAST(alt_mwst.cy_month AS FLOAT64) = wh.cy_month AND wh.client_id = alt_mwst.client_id
     AND wh.wh_id = alt_mwst.wh_id
    INNER JOIN ldl_p_lew_core_ac.v_cal_month_2 AS MON ON wh.cy_month = MON.cy_month
   UNION DISTINCT
   SELECT COALESCE(inv.client_id, rtn.client_id) AS client_id,
    COALESCE(inv.wh_id, rtn.wh_id) AS wh_id,
    cal.id AS aspect_id,
    117 AS indicator_id,
    ROUND(CAST(FORMAT_DATE('%Y%m', COALESCE(inv.dwh_cal_dt, rtn.dwh_cal_dt)) AS BIGNUMERIC), 0) AS cy_month,
     SUM(COALESCE(inv.inv_diff_net_val, 0) + COALESCE(rtn.sales_net_val, 0)) / cry.rate_currency_exchange AS
    val_indicator,
    cry.currency_iso_cd,
    MAX(COALESCE(inv.dwh_cal_dt, rtn.dwh_cal_dt)) AS dat_dayend
   FROM (SELECT MOV.client_id,
      MOV.loc_sid,
      BGES.src_wh_id AS wh_id,
      MOV.item_sid,
      MOV.dwh_cal_dt,
      SUM(MOV.ship_qty) AS ship_qty,
      SUM(MOV.ship_qty * COALESCE(PRC.cond_val_eff_calc, 0)) AS gross_val,
      SUM(CAST(MOV.ship_qty * COALESCE(PRC.cond_val_eff_calc, 0) * 100 / (100 + COALESCE(PRC.tax_rate_calc, 0)) AS NUMERIC)
       ) AS sales_net_val
     FROM ldl_p_lew_core_ac.v_item_movement_record_pos_2 AS MOV
      LEFT JOIN ldl_p_lew_bil_ac.v_item_loc_sales_cond_denorm_2 AS PRC ON MOV.client_id = PRC.client_id AND MOV.item_sid =
           PRC.item_sid AND MOV.loc_sid = PRC.loc_sid AND MOV.uom_sid_base = PRC.uom_sid_cond AND MOV.dwh_cal_dt BETWEEN
        PRC.dwh_valid_from AND PRC.dwh_valid_to
      INNER JOIN ldl_p_lew_core_ac.v_location_2 AS BGES ON MOV.loc_sid = BGES.loc_sid AND MOV.client_id = BGES.client_id
         AND BGES.global_loc_type_cd = '9' AND BGES.global_loc_id_length = 7 AND BGES.wh_store_mark = 'B'
        /* Artikelstamm */
      INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS ITM ON MOV.client_id = ITM.client_id AND MOV.item_sid = ITM.item_sid
       AND CURRENT_DATE BETWEEN ITM.dwh_valid_from AND ITM.dwh_valid_to
        /* Referenz ueber Fachschluessel weil noch nicht alle SID verfuegbar sind */
      LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore_2 AS IG ON ITM.client_id = IG.client_id AND ITM.item_type_sid = IG
          .item_type_sid AND (IG.client_id IN (33, 34) AND IG.item_type_cd NOT IN ('ZKM', 'ZVM') OR IG.client_id NOT IN
            (33, 34)) AND IG.item_type_grp_cd IN ('BAGLEVY', 'INV')
     WHERE MOV.client_id = 1
      AND MOV.move_type_cd IN ('911', '912', '913', '914', '921', '922', '923', '924', '925', '926', '927', '928', '963'
        , '964', '987', '988')
      AND IG.item_type_sid IS NULL
     GROUP BY MOV.client_id,
      MOV.loc_sid,
      wh_id,
      MOV.item_sid,
      MOV.dwh_cal_dt) AS rtn
    FULL JOIN (SELECT INV.client_id,
      INV.loc_sid,
      BGES0.src_wh_id AS wh_id,
      INV.item_sid,
      INV.dwh_cal_dt,
      SUM(INV.inv_diff_qty) AS inv_diff_qty,
      SUM(INV.inv_diff_gross_val) AS inv_diff_gross_val,
      SUM(INV.inv_diff_net_val) AS inv_diff_net_val
     FROM ldl_p_lew_core_ac.v_inv_diff_record_pos_2 AS INV
      INNER JOIN ldl_p_lew_core_ac.v_location_2 AS BGES0 ON INV.loc_sid = BGES0.loc_sid AND INV.client_id = BGES0.client_id
            AND BGES0.global_loc_type_cd = '9' AND BGES0.global_loc_id_length = 7 AND BGES0.wh_store_mark = 'B'
        /* Artikelstamm */
      INNER JOIN ldl_p_lew_core_ac.v_item_hist_2 AS ITM0 ON INV.client_id = ITM0.client_id AND INV.item_sid = ITM0.item_sid
          AND CURRENT_DATE BETWEEN ITM0.dwh_valid_from AND ITM0.dwh_valid_to
        /* Referenz ueber Fachschluessel weil noch nicht alle SID verfuegbar sind */
      LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore_2 AS IG0 ON ITM0.client_id = IG0.client_id AND ITM0.item_type_sid
          = IG0.item_type_sid AND (IG0.client_id IN (33, 34) AND IG0.item_type_cd NOT IN ('ZKM', 'ZVM') OR IG0.client_id
            NOT IN (33, 34)) AND IG0.item_type_grp_cd IN ('BAGLEVY', 'INV')
     WHERE INV.client_id = 1
      AND /* Ungefilterte Artikelarten */ IG0.item_type_sid IS NULL
      AND (CAST(INV.move_type_cd AS INTEGER) IN (701, 702, 703, 704, 707, 708, 711, 712, 717, 718) OR INV.move_type_cd
        IS NULL)
     GROUP BY INV.client_id,
      INV.loc_sid,
      wh_id,
      INV.item_sid,
      INV.dwh_cal_dt) AS inv ON rtn.client_id = inv.client_id AND rtn.loc_sid = inv.loc_sid AND rtn.item_sid = inv.item_sid
        AND rtn.dwh_cal_dt = inv.dwh_cal_dt
    INNER JOIN (SELECT day_of_month AS id
     FROM ldl_p_lew_mart_msi.v_cal_calendarday_2
     WHERE day_of_month IN (1, 2)
     GROUP BY id) AS cal ON TRUE
    INNER JOIN (SELECT B.client_id,
      B.curr_cd_from AS currency_iso_cd,
      B.curr_cd_to AS to_currency_iso_cd,
      B.exchange_rate AS rate_currency_exchange
     FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS B
      INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS C ON B.client_id = C.client_id AND B.x_rate_type_sid = C.x_rate_type_sid
          AND C.src_kurst = '@BEWE'
     WHERE CURRENT_DATE BETWEEN B.active_from_dt AND B.active_to_dt
      AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to) AS cry ON COALESCE(inv.client_id, rtn.client_id) =
     cry.client_id
    INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS MIG ON COALESCE(inv.client_id, rtn.client_id) = MIG.client_id
       AND COALESCE(inv.dwh_cal_dt, rtn.dwh_cal_dt) BETWEEN MIG.migration_dat_valid_from AND MIG.migration_dat_valid_to
      /* SAP period */
   GROUP BY client_id,
    wh_id,
    aspect_id,
    indicator_id,
    cy_month,
    cry.currency_iso_cd,
    cry.rate_currency_exchange) AS unn
GROUP BY client_id,
 wh_id,
 aspect_id,
 indicator_id,
 cy_month,
 currency_iso_cd
UNION ALL
SELECT client_id,
 org_unit_nr AS wh_id,
  CASE
  WHEN org_type_id = 50
  THEN 1
  ELSE 2
  END AS aspect_id,
 indicator_id,
 cy_month,
 val_indicator,
 'EUR' AS currency_iso_cd,
 dat_dayend
FROM (SELECT IDAY.client_id -- 50 = BGES; 60 = VGES
,
    IDAY.org_type_id,
    IDAY.org_unit_nr,
    IDAY.indicator_id,
    CAL.cy_month,
    MAX(IDAY.dat_dayend) AS dat_dayend,
    SUM(IDAY.val_indicator) AS val_indicator
   FROM ldl_p_lew_core_ac.v_wawi_indicator_day_2 AS IDAY
    INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON IDAY.dat_formdate = CAL.cal_dt
   WHERE IDAY.indicator_id IN (315) -- Nur BGES (aspect_id = 1)

    AND IDAY.org_type_id = 50
   GROUP BY IDAY.client_id,
    IDAY.org_type_id,
    IDAY.org_unit_nr,
    IDAY.indicator_id,
    CAL.cy_month
   UNION ALL
   SELECT IDAY.client_id -- 50 = BGES; 60 = VGES
,
    IDAY.org_type_id,
    IDAY.org_unit_nr,
    IDAY.indicator_id,
    CAL.cy_month,
    MAX(IDAY.dat_dayend) AS dat_dayend,
    SUM(IDAY.val_indicator) AS val_indicator
   FROM ldl_p_lew_core_ac.v_wawi_indicator_day_2 AS IDAY
    INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON IDAY.dat_formdate = CAL.cal_dt
   WHERE IDAY.indicator_id IN (322, 325) -- Nur BGES (aspect_id = 1)

    AND IDAY.org_type_id IN (50, 60)
   GROUP BY IDAY.client_id,
    IDAY.org_type_id,
    IDAY.org_unit_nr,
    IDAY.indicator_id,
    CAL.cy_month) AS imonth
UNION ALL
SELECT KM.client_id,
 KM.org_unit_nr AS wh_id,
  CASE
  WHEN KM.org_type_id = 50
  THEN 1
  ELSE 2
  END AS aspect_id,
 KM.indicator_id,
 CAL.cy_month,
 0 AS val_indicator,
 'EUR' AS currency_iso_cd,
 MAX(LAST_DAY(CAL.cal_dt, MONTH)) AS dat_dayend
FROM ldl_p_lew_bil_ac.v_kpi_month_2 AS KM
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON EXTRACT(YEAR FROM CAL.cal_dt) = 2021 AND EXTRACT(MONTH FROM
     CAL.cal_dt) BETWEEN 1 AND 9 OR EXTRACT(YEAR FROM CAL.cal_dt) = 2020
WHERE KM.client_id = 20
 AND KM.org_type_id IN (50, 60)
GROUP BY KM.client_id,
 KM.org_type_id,
 KM.org_unit_nr,
 KM.indicator_id,
 CAL.cy_month;