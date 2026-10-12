CREATE OR REPLACE VIEW FE_MSTR_NFMD.MV_LATEST_FE_WB_2 AS (
SELECT fin.MANDANT_ID,
       fin.YEAR_ID ,                                                                         
       fin.WEEK_ID,  
       fin.YEAR_ID || TO_CHAR(CAST(fin.WEEK_ID AS number), 'FM00')                     AS KJWO,
       fin.AKTION_ID,
       mdw.WUP_ID,
       fin.SKU_ID,                                                                           
       td_art.kl_art_id,
       fin.SKU_ID                                                                               AS SKU_NAME,
       vps.SAP_TRANSFER_DATE                                                                     AS SAP_TRANSFER_DATE,
       vps.PREVIOUS_SUBMITTED_VALID_FROM,
       vps.SUBMITTED_DATE,

       --- Check if Manual price on Article or Article-Wup_2  the newest updated date
       CASE
           WHEN dpc.UPDATED_DATE IS NULL OR dca.UPDATED_DATE > dpc.UPDATED_DATE THEN dca.UPDATED_DATE
           WHEN dca.UPDATED_DATE IS NULL OR dca.UPDATED_DATE < dpc.UPDATED_DATE THEN dpc.UPDATED_DATE
           ELSE NULL
           END                                                                                   AS last_manual_updated_date,

       --- Check if Manual price on Article or Article-Wup_2  the newest updated date
                  --- Check if Manual price on Article or Article-Wup_2  the newest updated date
       case WHEN dpc.UPDATED_DATE is null or dca.UPDATED_DATE > dpc.UPDATED_DATE then dca.MANUAL_MARKDOWN_PRICE
            WHEN dca.UPDATED_DATE is null or dca.UPDATED_DATE < dpc.UPDATED_DATE then dpc.MANUAL_MARKDOWN_PRICE
            ELSE NULL
        end as last_manual_price,

       --- Check if Manual price on Article or Article-Wup_2  the newest updated date
       CASE
           WHEN ddc.UPDATED_DATE IS NULL OR dcvf.UPDATED_DATE > ddc.UPDATED_DATE THEN dcvf.MANUAL_MARKDOWN_DATE
           WHEN dcvf.UPDATED_DATE IS NULL OR dcvf.UPDATED_DATE < ddc.UPDATED_DATE THEN ddc.MANUAL_MARKDOWN_DATE
           ELSE NULL
           END                                                                                   AS last_manual_valid_from,
       COALESCE(CASE WHEN last_manual_valid_from > CURRENT_DATE() THEN last_manual_valid_from END,
                NEXT_DAY(CURRENT_DATE(), prms.DISCOUNT_DAYS)) AS valid_from,
       COALESCE(comm.JF_COMMENT, '')                                                             AS manual_comment,
       fin.MARKDOWN_DECISION                                                                     AS jf_submitted,
       vps.submitted_price                                                                       AS id40_submitted_price,
       CAST(NULL AS FLOAT)                                                                       AS purchasing_price,
       -- this column stays empty until handover with client
       CAST(NULL AS FLOAT)                                                                       AS rohertrag,
       -- this column stays empty until handover with client
       vps.previous_submitted_price,
       COALESCE(vps.NB_OF_MARKDOWNS, 0)                                                          AS NB_OF_MARKDOWNS,
       ld.first_day                                                                              AS first_day_of_cw,
       DATEDIFF('week',
                ld.first_day,
                CURRENT_DATE())                                                                  AS promotion_week_x_weeks_ago,
       ri.VS_BEZ                                                                                 AS region_2,
       td_werbe_art.kl_art_id                                                                        AS WERBEMUTTER,
       CAST(NULL AS TIMESTAMP)                                                                   AS MODEL_RUN_TIME,
       COALESCE (art_clust.ARTICLE_CLUSTER_ID,0) AS ARTICLE_CLUSTER
FROM CORE.TS_ID30_MSI_FINAL_SUBMIT_2 fin
        LEFT JOIN FE_MSTR_NFMD.MV_HADOOP_PARAMETERS_2 prms 
              ON fin.mandant_id = prms.mandant_id
       -- wird benoetig fur die KL_ART_ID fuer die Werbemutter
       LEFT JOIN CORE.SRC_TERADATA_MASTER_DATA_ART_2 td_art
              ON td_art.mandant_id = fin.mandant_id AND
               fin.SKU_ID = td_art.art_id
        LEFT JOIN CORE.SRC_TERADATA_MASTER_DATA_ART_2 td_werbe_art
               ON td_art.mandant_id = td_werbe_art.mandant_id AND
                  td_art.MUTTER_WB_ID = td_werbe_art.art_id

        LEFT JOIN FE_MSTR_NFMD.MV_LOOKUP_DATES_2 ld
                   ON fin.WEEK_ID = ld.week_iso
                      AND fin.YEAR_ID = ld.year_iso
        LEFT JOIN FE_MSTR_NFMD.MV_ID40_LATEST_ART_PRICE_WB_2 dca
                   ON fin.YEAR_ID = dca.YEAR_ID
                       AND fin.WEEK_ID = dca.WEEK_ID
                       AND fin.AKTION_ID = dca.AKTION_ID
                       AND fin.SKU_ID = dca.SKU_ID
                       AND fin.mandant_id = dca.mandant_id
         LEFT JOIN FE_MSTR_NFMD.MV_ID40_LATEST_ART_VALID_FROM_WB_2 dcvf
                   ON fin.YEAR_ID = dcvf.YEAR_ID
                       AND fin.WEEK_ID = dcvf.WEEK_ID
                       AND fin.AKTION_ID = dcvf.AKTION_ID
                       AND fin.SKU_ID = dcvf.SKU_ID
                       AND fin.mandant_id = dcvf.mandant_id
         LEFT JOIN FE_MSTR_NFMD.MV_ID30_LATEST_COMM_WB_2 comm
                   ON fin.YEAR_ID = comm.YEAR_ID
                       AND fin.WEEK_ID = comm.WEEK_ID
                       AND fin.AKTION_ID = comm.AKTION_ID
                       AND fin.SKU_ID = comm.SKU_ID
                       AND fin.mandant_id = comm.mandant_id
         LEFT JOIN FE_MSTR_NFMD.MV_LATEST_ARTICE_CLUSTER_WB_2 art_clust
          ON (fin.YEAR_ID = art_clust.YEAR_ID
          AND fin.WEEK_ID = art_clust.WEEK_ID
          AND fin.AKTION_ID = art_clust.AKTION_ID
          AND fin.SKU_ID = art_clust.SKU_ID
          and fin.mandant_id = art_clust.mandant_id)                       
        LEFT JOIN FE_MSTR_NFMD.MV_WUP_2 mdw
                   ON fin.MANDANT_ID = mdw.MANDANT_ID
        LEFT JOIN CORE.L_REGION_IDS_2 ri
                   ON mdw.VS_ID = ri.VS_ID
                       AND mdw.MANDANT_ID = ri.MANDANT_ID
        LEFT JOIN FE_MSTR_NFMD.MV_ID40_LATEST_PRICE_WB_2 dpc
                   ON fin.mandant_id = dpc.mandant_id
                       AND fin.YEAR_ID = dpc.YEAR_ID
                       AND fin.WEEK_ID = dpc.WEEK_ID
                       AND fin.AKTION_ID = dpc.AKTION_ID
                       AND fin.SKU_ID = dpc.SKU_ID
                       AND mdw.WUP_ID = dpc.WUP_ID 
        LEFT JOIN FE_MSTR_NFMD.MV_ID40_LATEST_VALID_FROM_WB_2 ddc
                   ON fin.mandant_id = ddc.mandant_id
                       AND fin.YEAR_ID = ddc.YEAR_ID
                       AND fin.WEEK_ID = ddc.WEEK_ID
                       AND fin.AKTION_ID = ddc.AKTION_ID
                       AND fin.SKU_ID = ddc.SKU_ID
                       AND mdw.WUP_ID = ddc.WUP_ID 
         LEFT JOIN FE_MSTR_NFMD.MV_PRODUCT_STATISTICS_2 vps
                   ON  fin.YEAR_ID = vps.year_id
                       AND fin.WEEK_ID = vps.week_id
                       AND fin.AKTION_ID = vps.AKTION_ID
                       AND fin.MANDANT_ID = vps.MANDANT_ID
                       AND fin.SKU_ID = vps.SKU_id
                       AND mdw.WUP_ID = vps.WUP_ID                            
WHERE fin.MARKDOWN_DECISION = 0

    );