CREATE OR REPLACE VIEW DBP_MSI_VIEW_NFMD.MV_NFMD_ART_PROMOTION  AS 
WITH return_last6months AS (
    SELECT  approve.MANDANT_ID ,approve.ART_ID ,COUNT(1) AS article_returns
    FROM DBP_MSI_VIEW_NFMD.TS_NFMD_APPROVED_DECISION approve
    JOIN DBP_MSI_VIEW_NFMD.TS_NFMD_MARKDOWN_DECISION decision
    ON approve.mandant_id = decision.mandant_id
    AND approve.markdown_decision_id = decision.markdown_decision_id
    AND decision.retoure_fg = 1
    WHERE KJWO_WW >= TO_VARCHAR(DATEADD(MONTH, -6, CURRENT_DATE),'YYYYMM') 
    GROUP BY approve.MANDANT_ID ,approve.ART_ID
)
  SELECT
          jf.MANDANT_ID,
          jf.KJWO_WW,
         --jf.AKTION_ID,
          jf.PROMO_START_DT,
          jf.ART_ID,
          --td_art.kl_art_id,
          --jf.ART_NAME AS SKU_NAME,
          --jf.WG_BEZ,
          --jf.WUG_BEZ,
          jf.PROMO_STORES_CNT,
          jf.SELLING_PRICE_GROSS_LOCAL_VAL,
          jf.STOCK_INITIAL_CNT,
          jf.SALES_PROMO_WEEK_CNT,
          jf.PROMO_WEEK_SELL_RATE,
          jf.sell_ratio_wk12,
          jf.sell_ratio_wk123,
          jf.SALES_TOTAL_CNT,
          jf.CURRENT_SELL_RATE,
          jf.REMAINING_STOCK_CNT,
          --Zweimal Coalesce, um zu pruefen, wenn nichts abgespeichert ist ob schon etwas freigeben wurden ist 
          -- diesen Fall haben wir gehabt, wo wir auf P sind weil frueher nicht -1 war sondern 0 und dann hätte es gepasst nun nicht mehr 
          -- kann später wieder raus 
          COALESCE(COALESCE(dc.MARKDOWN_DECISION_ID,fin.MARKDOWN_DECISION_ID),-1) AS markdown_decision,
          -- Wird benoetigt fuer das Dropdown - damit dies labels anzeigt im Excelexport
          concat ( COALESCE (md1.MARKDOWN_DECISION_id,0) , ' - ',  COALESCE (md1.MARKDOWN_DECISION_DESCR,'Markdown')) AS markdown_decision_bez,
          COALESCE(comm.COMMENT_TXT, '') AS manual_comment,
          
          COALESCE(fin.MARKDOWN_DECISION_ID, -1) AS sumbitted_decision_id,
            CAST(NULL AS FLOAT)                                                               AS purchasing_price,          -- this column stays empty until handover with client
            CAST(NULL AS FLOAT)                                                               AS rohertrag,                 -- this column stays empty until handover with client
          /* MODIFY WHEN DATA FROM MODEL IS HERE */
         --jf.WERBEMUTTER_ID        AS WERBEMUTTER,
        --td_werbe_art.kl_art_id AS WERBEMUTTER,
        jf.WG_ID                          AS WG_ID,
        jf.WRG_ID,
        MODEL_EXECUTION_TMSP,
        COALESCE(art_clust.ARTICLE_CLUSTER_ID,0) AS ARTICLE_CLUSTER,
        return_last6months.article_returns,
        jf.next_promo_start_dt,
        jf.display_art_id,
        jf.SELLING_PRICE_GROSS_LOCAL_VAL / (1+(mwst_per.mwst/100)) AS VK_netto,
        CASE WHEN  jf.NEXT_PROMO_START_DT IS NOT NULL AND markdown_decision = 0 AND sumbitted_decision_id != 0 THEN 1 ELSE 0 END AS NEXT_PROMO_MARKDOWN_FG
  FROM
          DBP_VIEW.V_NFMD_ART_PROMOTION jf  
  ----
  --- MWST 
    JOIN dbp_view.v_art art
   ON jf.art_id = art.art_id
   AND jf.mandant_id = art.mandant_id

   JOIN dbp_view.v_mwst_per mwst_per
   ON mwst_per.mwst_id = art.mwst_id
   AND mwst_per.mandant_id = art.mandant_id
   AND mwst_per.dat_bis = '9999-12-31'
  -- letzte gespeicherte Entscheidung 
  -- Ist notwendig, da hier sonst kein Default auf 0 gesetzt werden kann... Zu prüfen 
  LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_PROPOSED_DECISION dc ON
          (jf.KJWO_WW = dc.KJWO_WW
          --AND jf.AKTION_ID = dc.AKTION_ID
          AND jf.ART_ID = dc.ART_ID
          AND jf.MANDANT_ID = dc.MANDANT_ID)
  -- letzter Kommentar 
  LEFT JOIN DBP_MSI_VIEW_NFMD.TS_NFMD_COMMENTS comm ON
          (jf.KJWO_WW = comm.KJWO_WW
         -- AND jf.AKTION_ID = comm.AKTION_ID
          AND jf.ART_ID = comm.ART_ID
          AND jf.MANDANT_ID = comm.MANDANT_ID)
  -- letzte freigegeben Entscheidung 
  LEFT JOIN DBP_MSI_VIEW_NFMD.TS_NFMD_APPROVED_DECISION fin ON
          (jf.KJWO_WW = fin.KJWO_WW
          --AND jf.AKTION_ID = fin.AKTION_ID
          AND jf.ART_ID = fin.ART_ID
          AND jf.MANDANT_ID = fin.MANDANT_ID)
  -- Retoure als Entscheidung in den letzten 6 Monaten 
   LEFT JOIN return_last6months
    ON jf.mandant_id = return_last6months.mandant_id
    AND jf.art_id = return_last6months.art_id
  -- Entscheidung 
  -- prüfen, ob wir dies hier benötigen
  LEFT JOIN DBP_MSI_VIEW_NFMD.TS_NFMD_MARKDOWN_DECISION md1 ON
          (dc.MARKDOWN_DECISION_ID = md1.MARKDOWN_DECISION_ID AND dc.mandant_id = md1.mandant_id)
  -- Artikelcluster 
  LEFT JOIN DBP_MSI_VIEW_NFMD.MV_NFMD_LATEST_ARTICLE_ARTICLE_CLUSTER_REL art_clust
          ON jf.KJWO_WW = art_clust.KJWO_WW
          --AND jf.AKTION_ID = art_clust.AKTION_ID
          AND jf.ART_ID = art_clust.ART_ID
          AND jf.MANDANT_ID = art_clust.MANDANT_ID
          ;