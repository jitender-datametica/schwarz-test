CREATE OR REPLACE VIEW FE_MSTR_NFMD.MV_FRONTEND_ID30_WB_2 AS (
  SELECT
          jf.MANDANT_ID,
          jf.CALENDAR_YEAR AS YEAR_ID,
          jf.CALENDAR_WEEK AS WEEK_ID,
          jf.CALENDAR_YEAR || to_char(cast(jf.CALENDAR_WEEK as number), 'FM00') as KJWO,
          jf.AKTION_ID,
          jf.AKTION_DAT_VON,
          jf.ART_ID AS SKU_ID,
          td_art.kl_art_id,
          jf.ART_NAME AS SKU_NAME,
          jf.WG_BEZ,
          jf.WUG_BEZ,
          jf.PROMO_STORES,
          jf.VK_AKTION_BRUTTO,
          jf.STOCK_INITIAL,
          jf.SALES_PROMO_WEEK,
          jf.SELL_RATIO_PROMO_WEEK,
          jf.SALES_TOTAL,
          jf.CURRENT_SELL_RATIO,
          jf.REMAINING_STOCK,
          COALESCE (dc.MARKDOWN_DECISION,0) AS markdown_decision,
          -- Wird benoetigt fuer das Dropdown - damit dies labels anzeigt im Excelexport
          concat ( COALESCE (md1.MARKDOWN_DECISION_id,0) , ' - ',  COALESCE (md1.MARKDOWN_DECISION,'Markdown')) AS markdown_decision_bez,
          COALESCE(comm.JF_COMMENT, '') AS manual_comment,

          --COALESCE(md2.MARKDOWN_DECISION_id, -1) AS sumbitted_decision_id,
          --COALESCE(md2.MARKDOWN_DECISION, 'None') AS sumbitted_decision,
          COALESCE(fin.MARKDOWN_DECISION, -1) AS sumbitted_decision_id,
            CAST(NULL AS FLOAT)                                                               AS purchasing_price,          -- this column stays empty until handover with client
            CAST(NULL AS FLOAT)                                                               AS rohertrag,                 -- this column stays empty until handover with client
          /* MODIFY WHEN DATA FROM MODEL IS HERE */
         --jf.WERBEMUTTER_ID        AS WERBEMUTTER,
        td_werbe_art.kl_art_id as WERBEMUTTER,
        jf.WG_ID                          AS WARENGRUPPE_ID,
        MODEL_DATE            AS MODEL_RUN_TIME,
        --DATEDIFF('week',ld.first_day,CURRENT_DATE()) AS promotion_week_x_weeks_ago,
        COALESCE(art_clust.ARTICLE_CLUSTER_ID,0) AS ARTICLE_CLUSTER,
        returns_last_6_months.article_returns
  FROM
          CORE.SRC_HDP_FRONTEND_SCREEN_JF_2 jf
          JOIN CORE.SRC_TERADATA_MASTER_DATA_ART_2 td_art
          on jf.ART_ID = td_art.art_id
          and jf.mandant_id = td_art.mandant_id
  -- wird benoetig fur die KL_ART_ID fuer die Werbemutter
  left JOIN CORE.SRC_TERADATA_MASTER_DATA_ART_2 td_werbe_art
          on jf.WERBEMUTTER_ID = td_werbe_art.art_id
          and jf.mandant_id = td_werbe_art.mandant_id
           

  /*LEFT JOIN FE_MSTR_NFMD.MV_LOOKUP_DATES_2 ld
        ON (jf.CALENDAR_WEEK = ld.week_iso AND jf.CALENDAR_YEAR = ld.year_iso)*/
  LEFT JOIN FE_MSTR_NFMD.MV_ID30_LATEST_WB_2 dc ON
          (jf."CALENDAR_YEAR" = dc.YEAR_ID
          AND jf."CALENDAR_WEEK" = dc.WEEK_ID
          AND jf.AKTION_ID = dc.AKTION_ID
          AND jf.ART_ID = dc.SKU_ID
          AND jf.mandant_id = dc.mandant_id)
  LEFT JOIN FE_MSTR_NFMD.MV_ID30_LATEST_COMM_WB_2 comm ON
          (jf."CALENDAR_YEAR" = comm.YEAR_ID
          AND jf."CALENDAR_WEEK" = comm.WEEK_ID
          AND jf.AKTION_ID = comm.AKTION_ID
          AND jf.ART_ID = comm.SKU_ID
          and jf.mandant_id = comm.mandant_id)
  LEFT JOIN CORE.TS_ID30_MSI_FINAL_SUBMIT_2 fin ON
          (jf."CALENDAR_YEAR" = fin.YEAR_ID
          AND jf."CALENDAR_WEEK" = fin.WEEK_ID
          AND jf.AKTION_ID = fin.AKTION_ID
          AND jf.ART_ID = fin.SKU_ID
          And jf.mandant_id = fin.mandant_id)
  LEFT JOIN (SELECT  MANDANT_ID ,SKU_ID ,count(1) AS article_returns
			FROM CORE.TS_ID30_MSI_FINAL_SUBMIT_2 
			WHERE MARKDOWN_DECISION IN (1,2,3,4,5)
			AND year_id || to_char(cast(week_id AS NUMBER), 'FM00') >= TO_VARCHAR(DATEADD(MONTH, -6, CURRENT_TIMESTAMP),'YYYYMM') 
			GROUP BY 1,2) AS returns_last_6_months
			ON jf.mandant_id = returns_last_6_months.mandant_id 
			AND jf.ART_ID = returns_last_6_months.SKU_ID
  LEFT JOIN CORE.TS_L_MARKDOWN_DECISION_2 md1 ON
          (dc.MARKDOWN_DECISION = md1.MARKDOWN_DECISION_ID and dc.mandant_id = md1.mandant_id)
  /*LEFT JOIN CORE.TS_L_MARKDOWN_DECISION_2 md2 ON
          (fin.MARKDOWN_DECISION = md2.MARKDOWN_DECISION_ID and fin.mandant_id = md2.mandant_id)*/
  LEFT JOIN FE_MSTR_NFMD.MV_LATEST_ARTICE_CLUSTER_WB_2 art_clust
          ON jf."CALENDAR_YEAR" = art_clust.YEAR_ID
          AND jf."CALENDAR_WEEK" = art_clust.WEEK_ID
          AND jf.AKTION_ID = art_clust.AKTION_ID
          AND jf.ART_ID = art_clust.SKU_ID
          and jf.mandant_id = art_clust.mandant_id
          );