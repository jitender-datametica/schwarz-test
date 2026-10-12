CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_latest_fe_wb AS SELECT FIN.mandant_id,
 FIN.year_id,
 FIN.week_id,
  CAST(FIN.year_id AS STRING) || TRIM(CAST(CAST(FIN.week_id AS BIGNUMERIC) AS STRING FORMAT '00')) AS kjwo,
 FIN.aktion_id,
 MDW.wup_id,
 FIN.sku_id,
 TD_ART.kl_art_id,
 FIN.sku_id AS sku_name,
 VPS.sap_transfer_date,
 VPS.previous_submitted_valid_from,
 VPS.submitted_date,
  CASE
  WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
  THEN DCA.updated_date
  WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
  THEN DPC.updated_date
  ELSE NULL
  END AS last_manual_updated_date,
  CASE
  WHEN DPC.updated_date IS NULL OR DCA.updated_date > DPC.updated_date
  THEN DCA.manual_markdown_price
  WHEN DCA.updated_date IS NULL OR DCA.updated_date < DPC.updated_date
  THEN DPC.manual_markdown_price
  ELSE NULL
  END AS last_manual_price,
  CASE
  WHEN DDC.updated_date IS NULL OR DCVF.updated_date > DDC.updated_date
  THEN DCVF.manual_markdown_date
  WHEN DCVF.updated_date IS NULL OR DCVF.updated_date < DDC.updated_date
  THEN DDC.manual_markdown_date
  ELSE NULL
  END AS last_manual_valid_from,
 COALESCE(CASE
   WHEN CAST(CASE
      WHEN DDC.updated_date IS NULL OR DCVF.updated_date > DDC.updated_date
      THEN DCVF.manual_markdown_date
      WHEN DCVF.updated_date IS NULL OR DCVF.updated_date < DDC.updated_date
      THEN DDC.manual_markdown_date
      ELSE NULL
      END AS DATE) > CURRENT_DATE
   THEN CASE
    WHEN DDC.updated_date IS NULL OR DCVF.updated_date > DDC.updated_date
    THEN DCVF.manual_markdown_date
    WHEN DCVF.updated_date IS NULL OR DCVF.updated_date < DDC.updated_date
    THEN DDC.manual_markdown_date
    ELSE NULL
    END
   ELSE NULL
   END, SUBSTR(CAST(UDF_SCHEMA.NEXT_DAY_BQ(CURRENT_DATE, PRMS.discount_days) AS STRING), 1, 20)) AS valid_from,
 COALESCE(COMM.jf_comment, '') AS manual_comment,
 FIN.markdown_decision AS jf_submitted,
 VPS.submitted_price AS id40_submitted_price,
 CAST(NULL AS FLOAT64) AS purchasing_price,
 CAST(NULL AS FLOAT64) AS rohertrag,
 VPS.previous_submitted_price,
 COALESCE(VPS.nb_of_markdowns, 0) AS nb_of_markdowns,
 LD.first_day AS first_day_of_cw,
 DATE_DIFF(CURRENT_DATE, LD.first_day, WEEK) AS promotion_week_x_weeks_ago,
 RI.vs_bez AS region,
 TD_WERBE_ART.kl_art_id AS werbemutter,
 CAST(NULL AS TIMESTAMP) AS model_run_time,
 COALESCE(ART_CLUST.article_cluster_id, 0) AS article_cluster
FROM kfl_nfmd_core.ts_id30_msi_final_submit AS FIN
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_hadoop_parameters AS PRMS ON FIN.mandant_id = PRMS.mandant_id
 LEFT JOIN kfl_nfmd_core.src_teradata_master_data_art AS TD_ART ON FIN.mandant_id = TD_ART.mandant_id AND FIN.sku_id =
   TD_ART.art_id
 LEFT JOIN kfl_nfmd_core.src_teradata_master_data_art AS TD_WERBE_ART ON TD_ART.mandant_id = TD_WERBE_ART.mandant_id AND
   TD_ART.mutter_wb_id = TD_WERBE_ART.art_id
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_lookup_dates AS LD ON FIN.week_id = LD.week_iso AND FIN.year_id = LD.year_iso
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_id40_latest_art_price_wb AS DCA ON FIN.year_id = DCA.year_id AND FIN.week_id = DCA.week_id
       AND FIN.aktion_id = DCA.aktion_id AND FIN.sku_id = DCA.sku_id AND FIN.mandant_id = DCA.mandant_id
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_id40_latest_art_valid_from_wb AS DCVF ON FIN.year_id = DCVF.year_id AND FIN.week_id
      = DCVF.week_id AND FIN.aktion_id = DCVF.aktion_id AND FIN.sku_id = DCVF.sku_id AND FIN.mandant_id = DCVF.mandant_id
   
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_id30_latest_comm_wb AS COMM ON FIN.year_id = COMM.year_id AND FIN.week_id = COMM.week_id
       AND FIN.aktion_id = COMM.aktion_id AND FIN.sku_id = COMM.sku_id AND FIN.mandant_id = COMM.mandant_id
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_latest_artice_cluster_wb AS ART_CLUST ON FIN.year_id = ART_CLUST.year_id AND FIN.week_id
       = ART_CLUST.week_id AND FIN.aktion_id = ART_CLUST.aktion_id AND FIN.sku_id = CAST(ART_CLUST.sku_id AS FLOAT64)
  AND FIN.mandant_id = ART_CLUST.mandant_id
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_wup AS MDW ON FIN.mandant_id = MDW.mandant_id
 LEFT JOIN kfl_nfmd_core.l_region_ids AS RI ON MDW.vs_id = RI.vs_id AND MDW.mandant_id = RI.mandant_id
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_id40_latest_price_wb AS DPC ON FIN.mandant_id = DPC.mandant_id AND FIN.year_id = DPC
       .year_id AND FIN.week_id = DPC.week_id AND FIN.aktion_id = DPC.aktion_id AND FIN.sku_id = DPC.sku_id AND MDW.wup_id
    = DPC.wup_id
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_id40_latest_valid_from_wb AS DDC ON FIN.mandant_id = DDC.mandant_id AND FIN.year_id
       = DDC.year_id AND FIN.week_id = DDC.week_id AND FIN.aktion_id = DDC.aktion_id AND FIN.sku_id = DDC.sku_id AND MDW
   .wup_id = DDC.wup_id
 LEFT JOIN kfl_nfmd_fe_mstr_nfmd.mv_product_statistics AS VPS ON FIN.year_id = VPS.year_id AND FIN.week_id = VPS.week_id
        AND FIN.aktion_id = VPS.aktion_id AND FIN.mandant_id = VPS.mandant_id AND FIN.sku_id = VPS.sku_id AND MDW.wup_id
    = VPS.wup_id
WHERE CAST(FIN.markdown_decision AS FLOAT64) = 0;