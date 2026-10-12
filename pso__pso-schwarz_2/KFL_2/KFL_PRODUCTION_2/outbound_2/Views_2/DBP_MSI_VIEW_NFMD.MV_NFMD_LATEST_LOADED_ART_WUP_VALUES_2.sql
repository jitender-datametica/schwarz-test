-- letzter übermittelter Preis


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_nfmd_latest_loaded_art_wup_values_2 AS WITH BASE AS (SELECT
   kjwo_ww,
   mandant_id,
   aktion_id,
   art_id,
   wup_id,
   wrg_id,
   dwh_created_tmsp,
   manual_promo_price_gross_local_val AS submitted_price,
   manual_promo_price_dt,
   COALESCE(last_transfer_tmsp, CAST('1900-01-01 00:00:00' AS DATETIME)) AS last_transfer_tmsp
  FROM kfl_production_dbp_msi_view_nfmd.ts_nfmd_manual_price_release_2), LAGGED AS (SELECT kjwo_ww,
   mandant_id,
   aktion_id,
   art_id,
   wup_id,
   wrg_id,
   submitted_price,
   manual_promo_price_dt,
   dwh_created_tmsp,
   LAG(submitted_price) OVER (PARTITION BY CAST(kjwo_ww AS STRING), aktion_id, CAST(art_id AS STRING), CAST(wup_id AS STRING)
      , wrg_id, CAST(mandant_id AS STRING) ORDER BY last_transfer_tmsp IS NULL, last_transfer_tmsp) AS
   previous_submitted_price,
   LAG(manual_promo_price_dt) OVER (PARTITION BY CAST(kjwo_ww AS STRING), aktion_id, CAST(art_id AS STRING), CAST(wup_id AS STRING)
      , wrg_id, CAST(mandant_id AS STRING) ORDER BY last_transfer_tmsp IS NULL, last_transfer_tmsp) AS
   previous_submitted_valid_from,
   ROW_NUMBER() OVER (PARTITION BY CAST(kjwo_ww AS STRING), aktion_id, CAST(art_id AS STRING), CAST(wup_id AS STRING),
      wrg_id, CAST(mandant_id AS STRING) ORDER BY last_transfer_tmsp IS NULL, last_transfer_tmsp) AS nb_of_markdowns,
   last_transfer_tmsp
  FROM BASE
  ORDER BY last_transfer_tmsp NULLS LAST), LATEST AS (SELECT kjwo_ww,
   aktion_id,
   art_id,
   wup_id,
   wrg_id,
   mandant_id,
   MAX(nb_of_markdowns) AS nb_of_markdowns
  FROM LAGGED
  GROUP BY kjwo_ww,
   mandant_id,
   aktion_id,
   art_id,
   wup_id,
   wrg_id), LAST_SAP_TRANSFER AS (SELECT V1.mandant_id,
   MAX(COALESCE(V2.execution_tmsp, CAST('1900-01-01 00:00:00' AS DATETIME))) AS last_sap_transper_tmsp
  FROM kfl_production_dbp_view.v_mandant_2 AS V1
   LEFT JOIN kfl_production_dbp_view.v_nfmd_pipeline_export_log_2 AS V2 ON V1.mandant_id = V2.mandant_id
  GROUP BY V1.mandant_id) (SELECT t18.kjwo_ww,
   t18.mandant_id,
   t18.aktion_id,
   t18.art_id,
   t18.wup_id,
   t18.wrg_id,
   t18.submitted_price,
   t18.manual_promo_price_dt,
   t18.last_sap_transfer_date,
   t18.submitted_date,
   t18.previous_submitted_price,
   t18.previous_submitted_valid_from,
   t18.nb_of_markdowns0 AS nb_of_markdowns,
   t18.loaded
  FROM (SELECT lg.kjwo_ww,
     lg.mandant_id,
     lg.aktion_id,
     lg.art_id,
     lg.wup_id,
     lg.wrg_id,
     lg.submitted_price,
     lg.manual_promo_price_dt,
     lg.last_transfer_tmsp AS last_sap_transfer_date,
     lg.dwh_created_tmsp AS submitted_date,
      CASE
      WHEN lg.dwh_created_tmsp >= sap.last_sap_transper_tmsp
      THEN lg.previous_submitted_price
      ELSE lg.submitted_price
      END AS previous_submitted_price,
      CASE
      WHEN lg.dwh_created_tmsp >= sap.last_sap_transper_tmsp
      THEN lg.previous_submitted_valid_from
      ELSE lg.manual_promo_price_dt
      END AS previous_submitted_valid_from,
      CASE
      WHEN lg.dwh_created_tmsp >= sap.last_sap_transper_tmsp
      THEN lg.nb_of_markdowns - 1
      ELSE lg.nb_of_markdowns
      END AS nb_of_markdowns0,
      CASE
      WHEN lg.dwh_created_tmsp >= sap.last_sap_transper_tmsp
      THEN 'Not yet Loaded'
      ELSE 'Loaded'
      END AS loaded,
     lg.nb_of_markdowns
    FROM LAGGED AS lg
     INNER JOIN LATEST AS lst ON lg.kjwo_ww = lst.kjwo_ww AND lg.aktion_id = lst.aktion_id AND lg.art_id = lst.art_id
        AND lg.wup_id = lst.wup_id AND lg.mandant_id = lst.mandant_id AND lg.nb_of_markdowns = lst.nb_of_markdowns
     INNER JOIN LAST_SAP_TRANSFER AS sap ON lst.mandant_id = sap.mandant_id
    ORDER BY lg.nb_of_markdowns DESC NULLS FIRST) AS t18);