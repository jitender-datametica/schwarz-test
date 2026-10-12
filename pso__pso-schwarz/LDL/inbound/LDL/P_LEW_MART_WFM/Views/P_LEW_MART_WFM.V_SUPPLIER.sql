CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_SUPPLIER
(
      country_lidl_cd
    , supplier_nr
    , supplier_name
)
AS
   SELECT
       country_lidl_cd,
   supplier_nr,
   supplier_name
   FROM
   (
      /* Basically the SAP and WAWI data is merged by using a LEFT OUTER JOIN for WAWI data.
         It is important that in COALESCE terms the ELWIS or SAP part is placed at first position
      because the WAWI part also contains SAP data.
      */
      SELECT clnt.src_country_lidl_cd AS country_lidl_cd,
   COALESCE(TRY_CAST(supl.src_lifnr AS BIGINT), TRY_CAST(supl.src_orig_supplier_nr AS BIGINT)) AS supplier_nr,
   TRIM(COALESCE(supl.sup_name, wawi_supl.supplier_name)) AS supplier_name
        /* DWH2.0 supplier base view */
     FROM
   p_lew_core_ac.v_supplier supl
   INNER JOIN p_lew_core_ac.v_client clnt
   ON supl.client_id = clnt.client_id
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_sup_supplier wawi_supl
   ON supl.client_id = wawi_supl.client_id
   AND supl.sup_sid = wawi_supl.sup_sid
   AND Current_Date BETWEEN wawi_supl.dat_rec_start AND wawi_supl.dat_rec_end
   INNER JOIN p_lew_core_ac.v_client_migration_per  AS migration_client
   ON supl.client_id = migration_client.client_id

/* The respective supplier_nr has to numerical */
   WHERE COALESCE(TRY_CAST(supl.src_lifnr AS BIGINT), TRY_CAST(supl.src_orig_supplier_nr AS BIGINT)) IS NOT NULL

   ) all_supplier_data
;