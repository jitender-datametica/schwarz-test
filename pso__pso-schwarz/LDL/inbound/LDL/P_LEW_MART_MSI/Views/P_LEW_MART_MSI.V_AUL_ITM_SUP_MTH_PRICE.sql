/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.v_aul_itm_sup_mth_price
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  02.01.2018    Mustafa, Sahin           display correct wh_id
#  1.3  17.01.2018    Murtenthaler,Martin      WAWI-Item if possible
#  1.4  17.01.2018    Wieber,Harald            Release 2.2
#  1.5  14.02.2018    Toth,Gabriel             wh_id = 0 in special conditions price fixed
#  1.6  24.07.2018    Michael Ueding           Referenz Item Mapping geaendert
#  1.7  17.12.2018    Florence Sklenarz        Patch 1902
#                                              use dat_rec_start/end instead of dat_valid_from/until for v_wawi_itm_sup_wh_buying_price
#  1.8  09.11.2020    Torsten Bachmann         join P_LEW_TMP.to  v_supplier_map_key added
#                                              PatchNo: 2652, REP3-7579
#  1.9  17.03.2021    Torsten Bachmann         Transall shutdown, repointing v_wawi_cal -> v_cal
#                                              PatchNo: 2790, REP3-8380
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AUL_ITM_SUP_MTH_PRICE COMMENT = '$Revision: 16815 $ '
AS
/*
#DescStart#
#$Revision: 16815 $, $LastChangedBy: tbachmann $
#SubjectAreas#: AUL
#DescEnd#
*/
SELECT
   es.client_id
  ,itmp.item_sid_map AS item_id
  ,es.cy_month
  ,wh2.src_wh_id AS wh_id
  ,supmap.sup_sid_map AS supplier_id
  ,es.price_buying
  ,es.price_buying_sp_cond
  ,es.currency_iso_cd
  ,wh.order_buying_list_cd
  ,COALESCE(sp.main_negot_cntry_cd, 'N/A') AS main_negot_cntry_cd
  ,CAST(NULL AS VARCHAR(150)) AS agg_co_negot_cntry_cd
  ,MAX(CASE WHEN vk.position_article_sales_rep = 1 THEN vk.article_sales_rep_desc ELSE NULL END  ) article_sales_rep_desc1
  ,MAX(CASE WHEN vk.position_article_sales_rep = 1 THEN vk.price_retail ELSE NULL END  ) price_retail1
  ,MAX(CASE WHEN vk.position_article_sales_rep = 1 THEN vk.price_retail_net ELSE NULL END  ) price_retail1_net
  ,MAX(CASE WHEN vk.position_article_sales_rep = 2 THEN vk.article_sales_rep_desc ELSE NULL END  ) article_sales_rep_desc2
  ,MAX(CASE WHEN vk.position_article_sales_rep = 2 THEN vk.price_retail ELSE NULL END  ) price_retail2
  ,MAX(CASE WHEN vk.position_article_sales_rep = 2 THEN vk.price_retail_net ELSE NULL END  ) price_retail2_net
  ,MAX(CASE WHEN vk.position_article_sales_rep = 3 THEN vk.article_sales_rep_desc ELSE NULL END  ) article_sales_rep_desc3
  ,MAX(CASE WHEN vk.position_article_sales_rep = 3 THEN vk.price_retail ELSE NULL END  ) price_retail3
  ,MAX(CASE WHEN vk.position_article_sales_rep = 3 THEN vk.price_retail_net ELSE NULL END  ) price_retail3_net
FROM
(
  SELECT
     ek.client_id
    ,ek.item_id
    ,ek.cy_month
    ,ek.wh_loc_sid
    ,ek.supplier_id
    ,ek.price_buying
    ,ek.price_buying + COALESCE(SUM(ek.val_special_condition) ,0)  price_buying_sp_cond
    ,ek.currency_iso_cd
  FROM
  (
    SELECT
       a.client_id
      ,a.item_sid  AS item_id
      ,m.cy_month
      ,bp.wh_loc_sid AS wh_loc_sid
      ,bp.sup_sid AS supplier_id
      ,COALESCE(crs.unit_currency_exchange * bp.price_buying_special / crs.rate_currency_exchange / cry.rate_currency_exchange, cr.unit_currency_exchange * bp.price_buying / cr.rate_currency_exchange / cry.rate_currency_exchange) price_buying
      ,crsc.unit_currency_exchange * sp.val_special_condition / crsc.rate_currency_exchange / crys.rate_currency_exchange * sp.sign_fg val_special_condition
      ,cry.currency_iso_cd
    FROM P_LEW_CORE_AC.v_wawi_itm_item_skey_act AS a

    CROSS JOIN P_LEW_CORE_AC.v_cal_month AS m

    INNER JOIN P_LEW_CORE_AC.v_wawi_itm_sup_wh_buying_price AS bp
    ON ADD_MONTHS(TO_DATE(CAST(m.cy_month AS CHAR(6)) || '01', 'YYYYMMDD'), 1) -1 BETWEEN bp.dat_rec_start AND bp.dat_rec_end
      AND a.item_sid  =  bp.item_sid
      AND a.client_id = bp.client_id

    INNER JOIN P_LEW_CORE_AC.v_wawi_itm_item_act AS iia
    ON a.item_sid  =  iia.item_sid
      AND a.client_id = iia.client_id

    INNER JOIN
    (
      SELECT
         a.client_id
        ,a.currency_nr
        ,a.currency_iso_cd
        ,cal.cal_dt dat_formdate
        ,a.unit_currency_exchange
        ,a.rate_currency_exchange
        ,a.dat_dayend
        ,a.load_id
      FROM P_LEW_CORE_AC.v_wawi_ref_wawi_currency_rate AS a

      INNER JOIN
      (
        SELECT
          cal_dt
        FROM P_LEW_CORE_AC.v_cal_calendarday
        WHERE cy_month_seq <= 0
          AND cal_dt >= TO_DATE('2007-01-01', 'YYYY-MM-DD')
        QUALIFY cal_dt = MAX(cal_dt ) OVER (PARTITION BY cy_month)
      ) cal
      ON cal.cal_dt BETWEEN a.dat_valid_from AND  a.dat_valid_until
    ) cr
    ON bp.client_id   = cr.client_id
      AND bp.currency_nr = cr.currency_nr
      AND ADD_MONTHS(TO_DATE(CAST(m.cy_month AS CHAR(6)) || '01', 'YYYYMMDD'), 1) -1 = cr.dat_formdate

    LEFT OUTER JOIN
    (
      SELECT
         a.client_id
        ,a.currency_nr
        ,a.currency_iso_cd
        ,cal.cal_dt dat_formdate
        ,a.unit_currency_exchange
        ,a.rate_currency_exchange
        ,a.dat_dayend
        ,a.load_id
      FROM P_LEW_CORE_AC.v_wawi_ref_wawi_currency_rate a

      INNER JOIN
      (
        SELECT
          cal_dt
        FROM P_LEW_CORE_AC.v_cal_calendarday
        WHERE cy_month_seq <= 0
          AND cal_dt >= TO_DATE('2007-01-01', 'YYYY-MM-DD')
        QUALIFY cal_dt = MAX(cal_dt ) OVER (PARTITION BY cy_month)
      ) cal
      ON cal.cal_dt BETWEEN a.dat_valid_from AND a.dat_valid_until
    ) crs
    ON bp.client_id   = crs.client_id
      AND bp.currency_nr_special = crs.currency_nr
      AND ADD_MONTHS(TO_DATE(CAST(m.cy_month AS CHAR(6)) || '01', 'YYYYMMDD'), 1) -1 = crs.dat_formdate

    INNER JOIN P_LEW_CORE_AC.v_wawi_ref_client_currency_rate AS cry
    ON bp.client_id = cry.client_id
      AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end

    /* wh und hq-Konditionen */
    LEFT OUTER JOIN
    (
      SELECT
         c.client_id
        ,c.orig_item_nr
        ,c.case_size
        ,c.dat_valid_from_item
        ,c.wh_loc_sid
        ,c.sup_sid
        ,c.include_margin_fg
        ,c.dat_valid_from
        ,c.dat_valid_until
        ,c.val_special_condition
        ,c.sign_fg
        ,c.currency_nr
        ,l.loc_sid AS zero_loc_sid
      FROM P_LEW_CORE_AC.v_wawi_itm_sup_wh_spcondition c

      INNER JOIN P_LEW_CORE_AC.v_location l
      ON l.client_id = c.client_id
        AND l.src_wh_id = 0

      WHERE c.include_margin_fg = 1
    ) sp
    ON a.client_id = sp.client_id
      AND a.orig_item_nr = sp.orig_item_nr
      AND (a.case_size = sp.case_size OR sp.case_size IS NULL )
      AND iia.dat_valid_from = sp.dat_valid_from_item
      AND (bp.wh_loc_sid  = sp.wh_loc_sid OR  sp.wh_loc_sid = sp.zero_loc_sid)
      AND bp.sup_sid  =  sp.sup_sid
      AND sp.include_margin_fg = 1
      AND ADD_MONTHS(TO_DATE(CAST(m.cy_month AS CHAR(6)) || '01', 'YYYYMMDD'), 1) -1 BETWEEN sp.dat_valid_from AND  sp.dat_valid_until

    LEFT OUTER JOIN
    (
      SELECT
         a.client_id
        ,a.currency_nr
        ,a.currency_iso_cd
        ,cal.cal_dt dat_formdate
        ,a.unit_currency_exchange
        ,a.rate_currency_exchange
        ,a.dat_dayend
        ,a.load_id   
      FROM P_LEW_CORE_AC.v_wawi_ref_wawi_currency_rate AS a
      
      INNER JOIN
      (
      SELECT
        cal_dt
      FROM P_LEW_CORE_AC.v_cal_calendarday
      WHERE cy_month_seq <= 0
        AND cal_dt >= TO_DATE('2007-01-01', 'YYYY-MM-DD')
      QUALIFY cal_dt = MAX(cal_dt ) OVER (PARTITION BY cy_month)
      ) cal
      ON cal.cal_dt BETWEEN a.dat_valid_from AND  a.dat_valid_until
    ) crsc
    ON sp.client_id = crsc.client_id
      AND sp.currency_nr = crsc.currency_nr
      AND ADD_MONTHS(TO_DATE(CAST(m.cy_month AS CHAR(6)) || '01', 'YYYYMMDD'), 1) -1 = crsc.dat_formdate

    LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_ref_client_currency_rate AS crys
    ON sp.client_id = crys.client_id
      AND CURRENT_DATE BETWEEN crys.dat_rec_start AND crys.dat_rec_end
      AND cry.currency_iso_cd = crys.currency_iso_cd

  ) ek
  GROUP BY
     ek.client_id
    ,ek.item_id
    ,ek.cy_month
    ,ek.wh_loc_sid
    ,ek.supplier_id
    ,ek.price_buying
    ,ek.currency_iso_cd
) es

LEFT OUTER JOIN
(
  SELECT
     pr.client_id
    ,pr.item_id
    ,m.cy_month
    ,pr.currency_iso_cd
    ,pg.position_article_sales_rep
    ,pg.article_sales_rep_desc
    ,pr.price_retail
    ,pr.price_retail * 100/NULLIFZERO(CAST(100 AS DECIMAL(19,5))+ ref.pct_vat) AS price_retail_net
  FROM P_LEW_MART_MSI.v_itm_price AS pr
  
  INNER JOIN P_LEW_CORE_AC.v_cal_month AS m
  ON ADD_MONTHS(TO_DATE(CAST(m.cy_month AS CHAR(6)) || '01', 'YYYYMMDD'), 1) -1 BETWEEN pr.dat_rec_start AND pr.dat_rec_end
  
  LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_ref_wawi_vat_values AS ref
  ON pr.vat_id = ref.vat_id
    AND pr.client_id = ref.client_id
    AND ADD_MONTHS(TO_DATE(CAST(m.cy_month AS CHAR(6)) || '01', 'YYYYMMDD'), 1) -1 BETWEEN ref.dat_rec_start AND ref.dat_rec_end
  
  INNER JOIN P_LEW_CORE_AC.v_wawi_ref_pricegrp AS pg
  ON pr.client_id = pg.client_id
    AND pr.pricegroup_id = pg.pricegroup_id
    AND ADD_MONTHS(TO_DATE(CAST(m.cy_month AS CHAR(6)) || '01', 'YYYYMMDD'), 1) -1 BETWEEN pg.dat_valid_from AND  pg.dat_valid_until
) vk
ON es.client_id = vk.client_id
  AND es.item_id  =  vk.item_id
  AND es.cy_month = vk.cy_month
  AND es.currency_iso_cd = vk.currency_iso_cd

LEFT OUTER JOIN
(
  SELECT
     s.client_id
    ,s.sup_sid
    ,m.cy_month
    ,s.main_negot_cntry_cd
  FROM P_LEW_CORE_AC.v_wawi_sup_supplier AS s
  
  INNER JOIN P_LEW_CORE_AC.v_cal_month AS m
  ON ADD_MONTHS(TO_DATE(CAST(m.cy_month AS CHAR(6)) || '01', 'YYYYMMDD'), 1) -1 BETWEEN s.dat_rec_start AND s.dat_rec_end
) sp
ON es.client_id = sp.client_id
  AND es.supplier_id  =  sp.sup_sid
  AND es.cy_month = sp.cy_month

INNER JOIN P_LEW_CORE_AC.v_wawi_org_wh_act AS wh
ON es.client_id = wh.client_id
  AND es.wh_loc_sid  =  wh.wh_loc_sid
  AND wh.language_id = 7

INNER JOIN P_LEW_BIL_AC.v_warehouse AS wh2
ON es.client_id = wh2.client_id
  AND  es.wh_loc_sid = wh2.loc_sid_wh
  AND wh2.dwh_actual_fg = 1

INNER JOIN P_LEW_CORE_AC.v_item_map_key itmp
ON itmp.client_id = es.client_id
  AND itmp.item_sid = es.item_id

INNER JOIN P_LEW_CORE_AC.v_supplier_map_key supmap
ON es.client_id = supmap.client_id
  AND es.supplier_id = supmap.sup_sid

GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;


