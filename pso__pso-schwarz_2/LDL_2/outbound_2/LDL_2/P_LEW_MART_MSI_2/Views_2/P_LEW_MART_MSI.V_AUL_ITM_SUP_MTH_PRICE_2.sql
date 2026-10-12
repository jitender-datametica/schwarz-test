/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.v_aul_itm_sup_mth_price_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  02.01.2018    Mustafa, Sahin           display correct wh_id
#  1.3  17.01.2018    Murtenthaler,Martin      WAWI-Item_2 if possible
#  1.4  17.01.2018    Wieber,Harald            Release 2.2
#  1.5  14.02.2018    Toth,Gabriel             wh_id = 0 in special conditions price fixed
#  1.6  24.07.2018    Michael Ueding           Referenz Item_2 Mapping geaendert
#  1.7  17.12.2018    Florence Sklenarz        Patch 1902
#                                              use dat_rec_start/end instead of dat_valid_from/until for v_wawi_itm_sup_wh_buying_price_2
#  1.8  09.11.2020    Torsten Bachmann         CROSS JOIN LDL.P_LEW_TMP.to  v_supplier_map_key_2 added
#                                              PatchNo: 2652, REP3-7579
#  1.9  17.03.2021    Torsten Bachmann         Transall shutdown, repointing v_wawi_cal -> v_cal
#                                              PatchNo: 2790, REP3-8380
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/


/* #DescStart#
#$Revision: 16815 $, $LastChangedBy: tbachmann $
#SubjectAreas#: AUL
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_aul_itm_sup_mth_price_2 OPTIONS(DESCRIPTION = `REVISION__DM: 16815 $ `) AS
SELECT es.client_id,
 ITMP.item_sid_map AS item_id,
 es.cy_month,
 WH2.src_wh_id AS wh_id,
 SUPMAP.sup_sid_map AS supplier_id,
 es.price_buying,
 es.price_buying_sp_cond,
 es.currency_iso_cd,
 WH.order_buying_list_cd,
 COALESCE(sp.main_negot_cntry_cd, 'N/A') AS main_negot_cntry_cd,
 CAST(NULL AS STRING) AS agg_co_negot_cntry_cd,
 MAX(CASE
   WHEN vk.position_article_sales_rep = 1
   THEN vk.article_sales_rep_desc
   ELSE NULL
   END) AS article_sales_rep_desc1,
 MAX(CASE
   WHEN vk.position_article_sales_rep = 1
   THEN vk.price_retail
   ELSE NULL
   END) AS price_retail1,
 MAX(CASE
   WHEN vk.position_article_sales_rep = 1
   THEN vk.price_retail_net
   ELSE NULL
   END) AS price_retail1_net,
 MAX(CASE
   WHEN vk.position_article_sales_rep = 2
   THEN vk.article_sales_rep_desc
   ELSE NULL
   END) AS article_sales_rep_desc2,
 MAX(CASE
   WHEN vk.position_article_sales_rep = 2
   THEN vk.price_retail
   ELSE NULL
   END) AS price_retail2,
 MAX(CASE
   WHEN vk.position_article_sales_rep = 2
   THEN vk.price_retail_net
   ELSE NULL
   END) AS price_retail2_net,
 MAX(CASE
   WHEN vk.position_article_sales_rep = 3
   THEN vk.article_sales_rep_desc
   ELSE NULL
   END) AS article_sales_rep_desc3,
 MAX(CASE
   WHEN vk.position_article_sales_rep = 3
   THEN vk.price_retail
   ELSE NULL
   END) AS price_retail3,
 MAX(CASE
   WHEN vk.position_article_sales_rep = 3
   THEN vk.price_retail_net
   ELSE NULL
   END) AS price_retail3_net
FROM (SELECT client_id,
   item_id,
   cy_month,
   wh_loc_sid,
   supplier_id,
   price_buying,
    price_buying + COALESCE(a0, 0) AS price_buying_sp_cond,
   currency_iso_cd
  FROM (SELECT A.client_id,
     A.item_sid AS item_id,
     M.cy_month,
     BP.wh_loc_sid,
     BP.sup_sid AS supplier_id,
     COALESCE(crs.unit_currency_exchange * BP.price_buying_special / crs.rate_currency_exchange / CRY.rate_currency_exchange
       , cr.unit_currency_exchange * BP.price_buying / cr.rate_currency_exchange / CRY.rate_currency_exchange) AS
     price_buying,
     CRY.currency_iso_cd,
     SUM(crsc.unit_currency_exchange * sp.val_special_condition / crsc.rate_currency_exchange / CRYS.rate_currency_exchange
         * sp.sign_fg) AS a0
    FROM ldl_p_lew_core_ac.v_wawi_itm_item_skey_act_2 AS A
     INNER JOIN ldl_p_lew_core_ac.v_cal_month_2 AS M ON TRUE
     INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_sup_wh_buying_price_2 AS BP ON DATE_SUB(IF(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M
               .cy_month as STRING), 1, 6) || '01') = LAST_DAY(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M.cy_month as STRING)
               , 1, 6) || '01')), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M.cy_month as STRING), 1, 6)
              || '01'), INTERVAL 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M.cy_month as STRING), 1, 6)
             || '01'), INTERVAL 1 MONTH)), INTERVAL 1 DAY) BETWEEN BP.dat_rec_start AND BP.dat_rec_end AND A.item_sid =
        BP.item_sid AND A.client_id = BP.client_id
     INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_2 AS IIA ON A.item_sid = IIA.item_sid AND A.client_id = IIA.client_id
       
     INNER JOIN (SELECT A0.client_id,
       A0.currency_nr,
       A0.currency_iso_cd,
       cal.cal_dt AS dat_formdate,
       A0.unit_currency_exchange,
       A0.rate_currency_exchange,
       A0.dat_dayend,
       A0.load_id
      FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_currency_rate_2 AS A0
       INNER JOIN (SELECT cal_dt
        FROM ldl_p_lew_core_ac.v_cal_calendarday_2
        WHERE cy_month_seq <= 0
         AND cal_dt >= PARSE_DATE('%F', '2007-01-01')
        QUALIFY cal_dt = (MAX(cal_dt) OVER (PARTITION BY CAST(cy_month AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING))) AS cal ON cal.cal_dt BETWEEN A0.dat_valid_from AND A0.dat_valid_until) AS cr ON BP.client_id
         = cr.client_id AND BP.currency_nr = cr.currency_nr AND DATE_SUB(IF(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M.cy_month
              as STRING), 1, 6) || '01') = LAST_DAY(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M.cy_month as STRING), 1, 6)
             || '01')), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M.cy_month as STRING), 1, 6) || '01'),
           INTERVAL 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M.cy_month as STRING), 1, 6) || '01'),
          INTERVAL 1 MONTH)), INTERVAL 1 DAY) = cr.dat_formdate
     LEFT JOIN (SELECT A1.client_id,
       A1.currency_nr,
       A1.currency_iso_cd,
       cal.cal_dt AS dat_formdate,
       A1.unit_currency_exchange,
       A1.rate_currency_exchange,
       A1.dat_dayend,
       A1.load_id
      FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_currency_rate_2 AS A1
       INNER JOIN (SELECT cal_dt
        FROM ldl_p_lew_core_ac.v_cal_calendarday_2
        WHERE cy_month_seq <= 0
         AND cal_dt >= PARSE_DATE('%F', '2007-01-01')
        QUALIFY cal_dt = (MAX(cal_dt) OVER (PARTITION BY CAST(cy_month AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING))) AS cal ON cal.cal_dt BETWEEN A1.dat_valid_from AND A1.dat_valid_until) AS crs ON BP.client_id
         = crs.client_id AND BP.currency_nr_special = crs.currency_nr AND DATE_SUB(IF(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M
              .cy_month as STRING), 1, 6) || '01') = LAST_DAY(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M.cy_month as STRING)
              , 1, 6) || '01')), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M.cy_month as STRING), 1, 6) ||
             '01'), INTERVAL 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M.cy_month as STRING), 1, 6) ||
            '01'), INTERVAL 1 MONTH)), INTERVAL 1 DAY) = crs.dat_formdate
     INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON BP.client_id = CRY.client_id AND
       CURRENT_DATE BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end /* wh und hq-Konditionen */
     LEFT JOIN (SELECT C.client_id,
       C.orig_item_nr,
       C.case_size,
       C.dat_valid_from_item,
       C.wh_loc_sid,
       C.sup_sid,
       C.include_margin_fg,
       C.dat_valid_from,
       C.dat_valid_until,
       C.val_special_condition,
       C.sign_fg,
       C.currency_nr,
       L.loc_sid AS zero_loc_sid
      FROM ldl_p_lew_core_ac.v_wawi_itm_sup_wh_spcondition_2 AS C
       INNER JOIN ldl_p_lew_core_ac.v_location_2 AS L ON C.client_id = L.client_id AND L.src_wh_id = 0
      WHERE C.include_margin_fg = 1) AS sp ON A.client_id = sp.client_id AND A.orig_item_nr = sp.orig_item_nr AND (sp.case_size
             IS NULL OR A.case_size = sp.case_size) AND IIA.dat_valid_from = sp.dat_valid_from_item AND (BP.wh_loc_sid =
            sp.wh_loc_sid OR sp.wh_loc_sid = sp.zero_loc_sid) AND BP.sup_sid = sp.sup_sid AND sp.include_margin_fg = 1
      AND DATE_SUB(IF(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M.cy_month as STRING), 1, 6) || '01') = LAST_DAY(PARSE_DATE('%Y%m%d'
            , SUBSTR(SAFE_CAST(M.cy_month as STRING), 1, 6) || '01')), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M
               .cy_month as STRING), 1, 6) || '01'), INTERVAL 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M
              .cy_month as STRING), 1, 6) || '01'), INTERVAL 1 MONTH)), INTERVAL 1 DAY) BETWEEN sp.dat_valid_from AND sp
       .dat_valid_until
     LEFT JOIN (SELECT A2.client_id,
       A2.currency_nr,
       A2.currency_iso_cd,
       cal.cal_dt AS dat_formdate,
       A2.unit_currency_exchange,
       A2.rate_currency_exchange,
       A2.dat_dayend,
       A2.load_id
      FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_currency_rate_2 AS A2
       INNER JOIN (SELECT cal_dt
        FROM ldl_p_lew_core_ac.v_cal_calendarday_2
        WHERE cy_month_seq <= 0
         AND cal_dt >= PARSE_DATE('%F', '2007-01-01')
        QUALIFY cal_dt = (MAX(cal_dt) OVER (PARTITION BY CAST(cy_month AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING))) AS cal ON cal.cal_dt BETWEEN A2.dat_valid_from AND A2.dat_valid_until) AS crsc ON sp
        .client_id = crsc.client_id AND sp.currency_nr = crsc.currency_nr AND DATE_SUB(IF(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M
              .cy_month as STRING), 1, 6) || '01') = LAST_DAY(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M.cy_month as STRING)
              , 1, 6) || '01')), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M.cy_month as STRING), 1, 6) ||
             '01'), INTERVAL 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M.cy_month as STRING), 1, 6) ||
            '01'), INTERVAL 1 MONTH)), INTERVAL 1 DAY) = crsc.dat_formdate
     LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRYS ON sp.client_id = CRYS.client_id AND
        CURRENT_DATE BETWEEN CRYS.dat_rec_start AND CRYS.dat_rec_end AND CRY.currency_iso_cd = CRYS.currency_iso_cd
    GROUP BY A.client_id,
     item_id,
     M.cy_month,
     BP.wh_loc_sid,
     supplier_id,
     price_buying,
     CRY.currency_iso_cd) AS t17) AS es
 LEFT JOIN (SELECT PR.client_id,
   PR.item_id,
   M0.cy_month,
   PR.currency_iso_cd,
   PG.position_article_sales_rep,
   PG.article_sales_rep_desc,
   PR.price_retail,
     PR.price_retail * 100 / IF(100 + REF.pct_vat = 0, NULL, 100 + REF.pct_vat) AS price_retail_net
  FROM ldl_p_lew_mart_msi.v_itm_price_2 AS PR
   INNER JOIN ldl_p_lew_core_ac.v_cal_month_2 AS M0 ON DATE_SUB(IF(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M0.cy_month as STRING)
          , 1, 6) || '01') = LAST_DAY(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M0.cy_month as STRING), 1, 6) || '01')),
      LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M0.cy_month as STRING), 1, 6) || '01'), INTERVAL 1 MONTH)
       ), DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M0.cy_month as STRING), 1, 6) || '01'), INTERVAL 1 MONTH)),
     INTERVAL 1 DAY) BETWEEN PR.dat_rec_start AND PR.dat_rec_end
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values_2 AS REF ON PR.vat_id = REF.vat_id AND PR.client_id = REF.client_id
       AND DATE_SUB(IF(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M0.cy_month as STRING), 1, 6) || '01') = LAST_DAY(PARSE_DATE('%Y%m%d'
          , SUBSTR(SAFE_CAST(M0.cy_month as STRING), 1, 6) || '01')), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M0
             .cy_month as STRING), 1, 6) || '01'), INTERVAL 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M0
            .cy_month as STRING), 1, 6) || '01'), INTERVAL 1 MONTH)), INTERVAL 1 DAY) BETWEEN REF.dat_rec_start AND REF
     .dat_rec_end
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_pricegrp_2 AS PG ON PR.client_id = PG.client_id AND PR.pricegroup_id = PG.pricegroup_id
       AND DATE_SUB(IF(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M0.cy_month as STRING), 1, 6) || '01') = LAST_DAY(PARSE_DATE('%Y%m%d'
          , SUBSTR(SAFE_CAST(M0.cy_month as STRING), 1, 6) || '01')), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M0
             .cy_month as STRING), 1, 6) || '01'), INTERVAL 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M0
            .cy_month as STRING), 1, 6) || '01'), INTERVAL 1 MONTH)), INTERVAL 1 DAY) BETWEEN PG.dat_valid_from AND PG.dat_valid_until
     ) AS vk_2 ON es.client_id = vk.client_id AND es.item_id = vk.item_id AND es.cy_month = vk.cy_month AND es.currency_iso_cd
    = vk.currency_iso_cd
 LEFT JOIN (SELECT S.client_id,
   S.sup_sid,
   M1.cy_month,
   S.main_negot_cntry_cd
  FROM ldl_p_lew_core_ac.v_wawi_sup_supplier_2 AS S
   INNER JOIN ldl_p_lew_core_ac.v_cal_month_2 AS M1 ON DATE_SUB(IF(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M1.cy_month as STRING)
          , 1, 6) || '01') = LAST_DAY(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M1.cy_month as STRING), 1, 6) || '01')),
      LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M1.cy_month as STRING), 1, 6) || '01'), INTERVAL 1 MONTH)
       ), DATE_ADD(PARSE_DATE('%Y%m%d', SUBSTR(SAFE_CAST(M1.cy_month as STRING), 1, 6) || '01'), INTERVAL 1 MONTH)),
     INTERVAL 1 DAY) BETWEEN S.dat_rec_start AND S.dat_rec_end) AS sp ON es.client_id = sp.client_id AND es.supplier_id
    = sp.sup_sid AND es.cy_month = sp.cy_month
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_act_2 AS WH ON es.client_id = WH.client_id AND es.wh_loc_sid = WH.wh_loc_sid
  AND WH.language_id = 7
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH2 ON es.client_id = WH2.client_id AND es.wh_loc_sid = WH2.loc_sid_wh AND
   WH2.dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key_2 AS ITMP ON es.client_id = ITMP.client_id AND es.item_id = ITMP.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_supplier_map_key_2 AS SUPMAP ON es.client_id = SUPMAP.client_id AND es.supplier_id =
   SUPMAP.sup_sid
GROUP BY es.client_id,
 item_id,
 es.cy_month,
 wh_id,
 supplier_id,
 es.price_buying,
 es.price_buying_sp_cond,
 es.currency_iso_cd,
 WH.order_buying_list_cd,
 main_negot_cntry_cd,
 agg_co_negot_cntry_cd;