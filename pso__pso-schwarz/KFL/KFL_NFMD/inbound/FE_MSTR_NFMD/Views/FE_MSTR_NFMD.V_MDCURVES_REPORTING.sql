CREATE OR REPLACE VIEW FE_MSTR_NFMD.V_MDCURVES_REPORTING AS
-- Reporting fuer Christian - Nur Artikel WUP Kombinationen, die als Test- & Controllfialien definiert wurden
-- und die in den Markdown geschickt wurden sind. 
(

SELECT CTR.CTRL_V_TREATMENT,
       COALESCE(md2.markdown_decision, 'None')      AS submitted_decesion,
       curv.ART_ID,
       curv.WUP_ID,
       curv.KL_ART_BEZ                  AS SKU_NAME,
       curv.WUP_NAME_E                  AS WUP_NAME,
       curv.WUP_CLUSTER_ID              AS WUP_CLUSTER,
       curv.WUP_REGION                  AS WUP_REGION,
       ri.VS_BEZ                        AS REGION,
       curv.CURVE_WEEK,
       fs.SUBMITTED_PRICE,
       CASE
           WHEN fs.CREATED_AT <= (SELECT MAX("TIMESTAMP") FROM CORE.SAP_PIPELINE_WRITEBACK)
               THEN fs.SUBMITTED_PRICE END                                               AS SUBMITTED_AND_LOADED_PRICE,
       fs.VALID_FROM_DATE,
       ROUND(fs.SUBMITTED_PRICE / CURV.VK_AKTION_BRUTTO, 4)                              AS discount,
       ps.NB_OF_MARKDOWNS,
       CASE
           WHEN fs.SRC_MD_PRICE_OPT <> fs.SUBMITTED_PRICE THEN 'Overwritten'
           WHEN fs.SRC_MD_PRICE_OPT = fs.SUBMITTED_PRICE THEN 'Model recommendation' END AS overwritten,
       curv.AKTION_ID,
       curv.AKTION_DAT_VON,
       curv.CALENDAR_YEAR,
       curv.CALENDAR_WEEK,
       PROMO_WEEK,
       curv.VK_AKTION_BRUTTO,
       curv.CURRENCY,
       curv.HWG_BEZ                                             AS HWG_BEZ,
       curv.OWG_BEZ                                             AS OWG_BEZ,
       curv.WG_BEZ                                              AS WG_BEZ,
       curv.WUG_BEZ                                             AS WUG_BEZ,
       curv.STOCK_INITIAL,
       SALES,
       CUMULATED_SALES,
       REVENUE,
       SELL_RATIO,
       PRICE_RATIO,
       curv.WERBEMUTTER_ID,
       curv.MANDANT_ID,
       curv.MODEL_DATE,
       to_Date(substr(curv.MODEL_DATE,1,8),'yyyymmdd') as model_date_format,
       curv.MODEL_ID
FROM CORE.SRC_HDP_MD_CURVES_MASTER_REPORTING curv
-- damit nur die Test und Controlmaerkte vorhanden sind 
JOIN CORE.CONTROL_VS_TREATMENT_CSV ctr ON CURV.WUP_ID = ctr.WUP_ID

         -- wird fuer die Anzahl der Markdowns benoetigt
		LEFT JOIN FE_MSTR_NFMD.MV_PRODUCT_STATISTICS ps
                   ON curv.CALENDAR_YEAR = ps.YEAR_ID AND
                      curv.CALENDAR_WEEK = ps.WEEK_ID AND
                      curv.MANDANT_ID = ps.MANDANT_ID AND
                     -- CURV.AKTION_ID = ps.AKTION_ID AND
                      curv.ART_ID = ps.SKU_ID AND
                      CURV.WUP_ID = ps.WUP_ID
         
         -- fuer die Entscheidung, ob Artikel mit Markdown oder nicht 
         LEFT JOIN CORE.TS_ID30_MSI_FINAL_SUBMIT id30
                   ON curv.CALENDAR_YEAR = id30.YEAR_ID AND
                      curv.CALENDAR_WEEK = id30.WEEK_ID AND
                      curv.MANDANT_ID = id30.MANDANT_ID AND
                      CURV.AKTION_ID = id30.AKTION_ID AND
                      curv.ART_ID = id30.SKU_ID
          LEFT JOIN CORE.TS_L_MARKDOWN_DECISION md2 ON
               (id30.MARKDOWN_DECISION = md2.markdown_decision_ID)

    -- fuer die Zuordnung zu den Curves aus dem Reporting 
     LEFT JOIN FE_MSTR_NFMD.MV_LOOKUP_DATES ld
                   ON curv.CALENDAR_WEEK = ld.week_iso
                       AND curv.CALENDAR_YEAR = ld.year_iso
         LEFT JOIN CORE.TS_ID40_FINAL_SUBMIT fs
                   ON curv.CALENDAR_WEEK = fs.week_id
                       AND curv.CALENDAR_YEAR = fs.year_id
                       AND curv.MANDANT_ID = fs.MANDANT_ID
                       AND curv.AKTION_ID = fs.AKTION_ID
                       AND CURV.ART_ID = fs.SKU_ID
                       AND CURV.WUP_ID = fs.WUP_ID
                       AND CASE
                               WHEN DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) < 7 THEN 1
                               WHEN DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) >= 7 AND
                                    DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) < 14 THEN 2
                               WHEN DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) >= 14 AND
                                    DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) < 21 THEN 3
                               WHEN DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) >= 21 AND
                                    DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) < 28 THEN 4
                               WHEN DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) >= 28 AND
                                    DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) < 35 THEN 5
                               WHEN DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) >= 35 AND
                                    DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) < 42 THEN 6
                               WHEN DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) >= 42 AND
                                    DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) < 49 THEN 7
                               WHEN DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) >= 49 AND
                                    DATEDIFF('day', ld.thursday_of_week, fs.VALID_FROM_DATE) < 56 THEN 8
                               END = curv.curve_week
         
         LEFT JOIN CORE.SRC_TERADATA_MASTER_DATA_WUP mdw
                   ON curv.WUP_ID = mdw.WUP_ID
                       AND curv.MANDANT_ID = mdw.MANDANT_ID
         LEFT JOIN CORE.L_REGION_IDS ri
                   ON mdw.VS_ID = ri.VS_ID
                       AND mdw.MANDANT_ID = ri.MANDANT_ID
WHERE PROMO_WEEK >= 202129
  AND md2.markdown_decision_ID = 0);