/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_INVENTORY_LOSS_BASE_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* sonstige Warenverluste Filiale */ /* sonstige Warenverluste Betrieb */ /* sonstige Warenverluste Anlieferung */
/* Anlieferung QualitÃ¸Âýt Filiale */ /* sonstige Warenverluste WG (WarengeschÃ¸Âýft) */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_inventory_loss_base_2 (client_id, iso_cd, cy_month, kpi_aspect, aspect_id,
wh_id, v_id, currency_iso_cd, warenverlust_anlieferung_val, warenverlust_betrieb_val, warenverlust_filiale_val,
warenverlust_wg_val, anlieferung_qual_filiale_val) AS
/* #----------------------------------------------------------------------------
   #WAWI Laender
   #---------------------------------------------------------------------------- */
SELECT t5.client_id,
 t5.iso_cd,
 t5.cy_month,
  CASE
  WHEN t5.aspect_id = 1
  THEN 'BGES'
  ELSE 'VGES'
  END AS kpi_aspect,
 t5.aspect_id,
 t5.wh_id,
 t5.v_id,
 t5.currency_iso_cd,
 ROUND(ROUND(t5.a0), 2) AS warenverlust_anlieferung_val,
 ROUND(ROUND(t5.a0_0), 2) AS warenverlust_betrieb_val,
 ROUND(ROUND(t5.a0_1), 2) AS warenverlust_filiale_val,
 ROUND(ROUND(t5.a0_2), 2) AS warenverlust_wg_val,
 ROUND(ROUND(t5.a0_3), 2) AS anlieferung_qual_filiale_val
FROM (SELECT warenverluste.client_id,
   warenverluste.cy_month,
   warenverluste.src_wh_id AS wh_id,
   warenverluste.wh_loc_sid AS store_location,
   curr.curr_cd_to AS currency_iso_cd,
   warenverluste.aspect_id,
   curr.exchange_rate,
   warenverluste.src_country_lidl_cd AS iso_cd,
   warenverluste.v_id,
   SUM(warenverluste.fuhrenbruch_lager + warenverluste.reklamation_direktlieferung) AS a0,
   SUM(warenverluste.fuhrenbruch_filiale + warenverluste.hoehere_gewalt_lager + warenverluste.spenden_lager +
     warenverluste.warenentnahme_lager) AS a0_0,
   SUM(warenverluste.hoehere_gewalt_filiale + warenverluste.spenden_filiale + warenverluste.warenentnahme_filiale) AS
   a0_1,
   SUM(warenverluste.defektes_non_food_filiale) AS a0_2,
   SUM(warenverluste.qualitaet_filiale) AS a0_3
  FROM (SELECT AGG.client_id,
      CASE
      WHEN OSM.aspect_id = 1
      THEN STW.orig_wh_nr
      ELSE NULL
      END AS src_wh_id,
      CASE
      WHEN OSM.aspect_id = 1
      THEN STW.loc_sid_wh
      ELSE OSM.wh_loc_sid
      END AS wh_loc_sid,
     AGG.cy_month,
     OSM.aspect_id,
      CASE
      WHEN OSM.aspect_id = 2
      THEN WH.src_wh_id
      ELSE NULL
      END AS v_id,
     CL.src_country_lidl_cd,
     IFNULL(SUM(CASE
        WHEN AGG.sfotype_id IN (182, 192) AND AGG.pcwo_reason_id IN (28) OR AGG.sfotype_id IN (181, 191) AND AGG.pcwo_reason_id
            IN (84)
        THEN AGG.sfo_total_rtl_rl_net_val_asis
        ELSE NULL
        END), 0) AS fuhrenbruch_lager,
     IFNULL(SUM(CASE
        WHEN AGG.sfotype_id IN (182, 192) AND AGG.pcwo_reason_id IN (27)
        THEN AGG.sfo_total_rtl_rl_net_val_asis
        ELSE NULL
        END), 0) AS reklamation_direktlieferung,
     IFNULL(SUM(CASE
        WHEN AGG.sfotype_id IN (182, 192) AND AGG.pcwo_reason_id IN (26, 132) OR AGG.sfotype_id IN (181, 191) AND AGG.pcwo_reason_id
            IN (82)
        THEN AGG.sfo_total_rtl_rl_net_val_asis
        ELSE NULL
        END), 0) AS fuhrenbruch_filiale,
     IFNULL(SUM(CASE
        WHEN AGG.sfotype_id IN (182, 192) AND AGG.pcwo_reason_id IN (29)
        THEN AGG.sfo_total_rtl_rl_net_val_asis
        ELSE NULL
        END), 0) AS hoehere_gewalt_lager,
     IFNULL(SUM(CASE
        WHEN AGG.sfotype_id IN (182, 192) AND AGG.pcwo_reason_id IN (31, 103, 104, 123, 124)
        THEN AGG.sfo_total_rtl_rl_net_val_asis
        ELSE NULL
        END), 0) AS spenden_lager,
     IFNULL(SUM(CASE
        WHEN AGG.sfotype_id IN (182, 192) AND AGG.pcwo_reason_id IN (30, 105, 106, 107, 108, 109, 113, 114, 115, 116,
           117, 118, 119, 120, 121, 122, 125, 133)
        THEN AGG.sfo_total_rtl_rl_net_val_asis
        ELSE NULL
        END), 0) AS warenentnahme_lager,
     IFNULL(SUM(CASE
        WHEN AGG.sfotype_id IN (137, 147) AND AGG.pcwo_reason_id IN (3)
        THEN AGG.sfo_total_rtl_rl_net_val_asis
        ELSE NULL
        END), 0) AS hoehere_gewalt_filiale,
     IFNULL(SUM(CASE
        WHEN AGG.sfotype_id IN (137, 147) AND AGG.pcwo_reason_id IN (7, 130, 131)
        THEN AGG.sfo_total_rtl_rl_net_val_asis
        ELSE NULL
        END), 0) AS spenden_filiale,
     IFNULL(SUM(CASE
        WHEN AGG.sfotype_id IN (137, 147) AND AGG.pcwo_reason_id IN (4, 101, 102, 110, 111, 129)
        THEN AGG.sfo_total_rtl_rl_net_val_asis
        ELSE NULL
        END), 0) AS warenentnahme_filiale,
     IFNULL(SUM(CASE
        WHEN AGG.sfotype_id IN (182, 192) AND AGG.pcwo_reason_id IN (25)
        THEN AGG.sfo_total_rtl_rl_net_val_asis
        ELSE NULL
        END), 0) AS defektes_non_food_filiale,
     IFNULL(SUM(CASE
        WHEN AGG.sfotype_id IN (137, 147) AND AGG.pcwo_reason_id IN (8)
        THEN AGG.sfo_total_rtl_rl_net_val_asis
        ELSE NULL
        END), 0) AS qualitaet_filiale
    FROM ldl_p_lew_bil_ac.v_agg_store_day_sfo_2 AS AGG
     INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_merge_act_2 AS OSM ON AGG.client_id = OSM.client_id AND AGG.loc_sid_store
        = OSM.st_loc_sid
     INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_merge_act_2 AS OWM ON OSM.client_id = OWM.client_id AND OSM.wh_loc_sid =
        OWM.wh_loc_sid AND OSM.aspect_id = OWM.aspect_id
     INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON OSM.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_valid_to = PARSE_DATE('%m/%d/%Y'
         , '12/30/9999') AND OSM.client_id IS NOT NULL
     INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_2 AS CAL ON AGG.booking_dat = CAL.cal_dt AND CAL.busyear_seq IN (0, -
        1)
     INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_2 AS STW ON AGG.client_id = STW.client_id AND OSM.move_to_st_loc_sid
         = STW.loc_sid_store AND STW.dwh_valid_to = PARSE_DATE('%m/%d/%Y', '12/30/9999')
     INNER JOIN ldl_p_lew_core_ac.v_client_2 AS CL ON AGG.client_id = CL.client_id
    GROUP BY AGG.client_id,
     WH.src_wh_id,
     STW.orig_wh_nr,
     AGG.cy_month,
     OSM.aspect_id,
     STW.loc_sid_wh,
     OSM.wh_loc_sid,
     CL.src_country_lidl_cd,
     v_id) AS warenverluste
   INNER JOIN (SELECT CURR.exchange_rate,
     CURR.client_id,
     CURR.curr_cd_to
    FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CURR
     INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS ERT ON CURR.x_rate_type_sid = ERT.x_rate_type_sid AND ERT.src_kurst
          = '@BEWE' AND CURR.curr_cd_from = 'EUR' AND CURR.dwh_valid_to = PARSE_DATE('%m/%d/%Y', '12/30/9999')
    WHERE CURRENT_DATE BETWEEN CURR.active_from_dt AND CURR.active_to_dt) AS curr ON warenverluste.client_id = curr.client_id
    
  GROUP BY warenverluste.client_id,
   warenverluste.cy_month,
   wh_id,
   store_location,
   currency_iso_cd,
   warenverluste.aspect_id,
   curr.exchange_rate,
   iso_cd,
   warenverluste.v_id) AS t5;