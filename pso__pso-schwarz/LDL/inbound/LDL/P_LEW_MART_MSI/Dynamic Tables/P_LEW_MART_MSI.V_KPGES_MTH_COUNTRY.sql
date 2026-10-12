create or replace dynamic table LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_MART_MSI.V_KPGES_MTH_COUNTRY(
	CLIENT_ID,
	INDICATOR_ID,
	CY_MONTH,
	VAL_INDICATOR,
	CURRENCY_ISO_CD,
	DAT_DAYEND
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_LDL_D_DYNAMIC_TABLE_P_LEW_MART_MSI
 as  
   (  
             SELECT      wh.client_id          AS client_id 
  , wh.indicator_id       AS indicator_id 
  , wh.cy_month           AS cy_month 
  , CASE WHEN wh.indicator_id = '117' AND wh.indicator_type_id = 1 AND wh.mig_fg = 0 THEN 
                                               CASE WHEN alt_mwst.mwst IS NOT NULL  
                                                         THEN wh.val_indicator / alt_mwst.mwst  
   ELSE wh.val_indicator  
END 
WHEN wh.indicator_id = '117' AND wh.indicator_type_id = 1 AND wh.mig_fg = 1 AND wh.client_id = 1  
THEN 0
WHEN wh.indicator_id = 338 THEN (SELECT ROUND(SUM(val_indicator) / COALESCE((CASE WHEN SUM(CASE WHEN val_indicator != 0 THEN 1 ELSE 0 END) != 0 THEN SUM(CASE WHEN val_indicator != 0 THEN 1 ELSE 0 END) ELSE 1 END), 1), 2) 
                           FROM P_LEW_BIL_AC.v_kpi_month AS subqry 
                           INNER JOIN P_LEW_CORE_AC.v_cal_month submon
                           ON subqry.cy * 100 + subqry.month_id = submon.cy_month
                           AND submon.cy_month_seq BETWEEN mon.cy_month_seq - 11 AND mon.cy_month_seq
                           WHERE wh.client_id = subqry.client_id 
                           AND subqry.indicator_id = 236 
                           AND subqry.indicator_type_id = 1   
                           AND subqry.org_type_id = 20)
WHEN wh.indicator_id = 340 THEN (SELECT ROUND(SUM(val_indicator), 2)
                           FROM P_LEW_BIL_AC.v_kpi_month AS subqry 
                           INNER JOIN P_LEW_CORE_AC.v_cal_month submon
                           ON subqry.cy * 100 + subqry.month_id = submon.cy_month
                           AND submon.cy_month_seq BETWEEN mon.cy_month_seq - 11 AND mon.cy_month_seq
                           WHERE wh.client_id = subqry.client_id 
                           AND subqry.indicator_id = 191
                           AND subqry.indicator_type_id = 1   
                           AND subqry.org_type_id = 20)
WHEN wh.indicator_id = 341 THEN (SELECT ROUND(SUM(val_indicator), 2)
                           FROM P_LEW_BIL_AC.v_kpi_month AS subqry 
                           INNER JOIN P_LEW_CORE_AC.v_cal_month submon
                           ON subqry.cy * 100 + subqry.month_id = submon.cy_month
                           AND submon.cy_month_seq BETWEEN mon.cy_month_seq - 11 AND mon.cy_month_seq
                           WHERE wh.client_id = subqry.client_id 
                           AND subqry.indicator_id = 239
                           AND subqry.indicator_type_id = 1   
                           AND subqry.org_type_id = 20)
ELSE           wh.val_indicator 
END            AS val_indicator 
,wh.currency_iso_cd                                                    AS currency_iso_cd 
   ,CASE WHEN wh.indicator_id = '117' AND wh.indicator_type_id = 1 AND wh.mig_fg = 1 AND wh.client_id = 1 
                                              THEN NULL 
                                         ELSE      wh.dat_dayend  
                                     END                                                                 AS dat_dayend  
                        FROM         (  
                                      SELECT      imth.client_id                                       AS client_id 
   , imth.org_unit_nr                                     AS wh_id  
   , CASE WHEN imth.org_type_id = 50 THEN 1 ELSE 2 END    AS aspect_id  
   , imth.indicator_id                                    AS indicator_id
   , imth.cy                                              AS cy 
   , imth.cy * 100 + imth.month_id                        AS cy_month 
   , CASE 
          WHEN  imth.indicator_id IN (117,120,125,126,133,135,136,155,156,157,163,168 
                ,169,170,172,174,177,179,203,204,209,210,212,216,228,229,230,238,240,242,250  
                ,251,255,256,257,258,259,260,261,270,271,272,273,280,281,282,283,284,286,373,374,375,376,377) 
          THEN imth.val_indicator / cry.rate_currency_exchange  
   ELSE imth.val_indicator  
 END                                                  AS val_indicator  
   , cry.currency_iso_cd                                  AS currency_iso_cd  
   , imth.dat_dayend                                      AS dat_dayend
   , CASE WHEN (imth.cy * 100) + imth.month_id BETWEEN TO_NUMBER(TO_CHAR(mig.migration_dat_valid_from, 'YYYYMM')) AND TO_NUMBER(TO_CHAR(mig.migration_dat_valid_to, 'YYYYMM'))  
                                                             THEN 1 
                                                             ELSE 0 
                                                    END                                                 AS mig_fg
   , imth.indicator_type_id
   , cry.to_currency_iso_cd
   , cry.rate_currency_exchange
   , imth.val_indicator                                   AS kpi_val_indicator  
  
  FROM p_lew_bil_ac.v_kpi_month                           AS imth 
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry  
   ON    imth.client_id         =  cry.client_id  
   AND    CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end  
   INNER JOIN p_lew_core_ac.v_client_migration_per                 AS mig 
   ON    imth.client_id  = mig.client_id  
  
   WHERE imth.indicator_type_id   = 1 
     AND imth.org_type_id         = 20  
   ) AS wh  
   LEFT OUTER JOIN (  
   SELECT   ww.client_id
   , TO_CHAR(ww.inv_end_date,'YYYYMM')           AS cy_month  
   , SUM(ww.val_retail) / SUM(ww.val_retail_net) AS mwst  
   FROM p_lew_mart_msi.v_inv_wh_ejr_txj_ww                          AS ww  
   GROUP BY ww.client_id , TO_CHAR(ww.inv_end_date,'YYYYMM')  
) alt_mwst  
   ON alt_mwst.cy_month  = wh.cy_month  
   AND alt_mwst.client_id = wh.client_id  
   INNER JOIN P_LEW_CORE_AC.v_cal_month AS mon
   ON wh.cy_month = mon.cy_month
) 
;
