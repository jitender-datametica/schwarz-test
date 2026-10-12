CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_wbs_refmarkt_massenbearbeitung(p_mandant_id FLOAT64, p_wups STRING, p_nbs STRING, p_clear_stock_ausschluss_fg FLOAT64, OUT return_value STRING)
  BEGIN
    -- "p_estimation_fg" FLOAT,
    -- "p_adjustment_fg" FLOAT,
    DECLARE dummy_1 FLOAT64;
    IF p_clear_stock_ausschluss_fg IS NOT NULL THEN
      UPDATE kfl_production_dbp_msi_data.ts_wbs_refmarkt_1 SET clear_stock_ausschluss_fg = CAST(p_clear_stock_ausschluss_fg AS INTEGER) WHERE ts_wbs_refmarkt.mandant_id = p_mandant_id
       AND ts_wbs_refmarkt.wup_id IN(
        SELECT
            CAST(trim(col, ' ') AS INTEGER)
          FROM
            UNNEST(split(p_wups, ',')) AS col WITH OFFSET AS offset
      )
       AND ts_wbs_refmarkt.nb_id IN(
        SELECT
            CAST(trim(col, ' ') AS INTEGER)
          FROM
            UNNEST(split(p_nbs, ',')) AS col WITH OFFSET AS offset
      );
    END IF;
    INSERT INTO kfl_production_dbp_msi_data.ts_wbs_refmarkt_1 (mandant_id, wup_id, nb_id, wup_id_ref, nb_id_ref, ref_faktor_fallback, mandant_id_vz_fallback, wup_id_vz_fallback, nb_id_vz_fallback, min_platzierung_markt_cluster_id, clear_stock_ausschluss_fg, td_update, td_insert)
      WITH wup_update AS (
        SELECT
            ts_wbs_refmarkt.*
          FROM
            kfl_production_dbp_msi_data.ts_wbs_refmarkt_1
          WHERE ts_wbs_refmarkt.mandant_id = p_mandant_id
           AND ts_wbs_refmarkt.wup_id IN(
            SELECT
                CAST(trim(col, ' ') AS INTEGER)
              FROM
                UNNEST(split(p_wups, ',')) AS col WITH OFFSET AS offset
          )
           AND ts_wbs_refmarkt.nb_id IN(
            SELECT
                CAST(trim(col, ' ') AS INTEGER)
              FROM
                UNNEST(split(p_nbs, ',')) AS col WITH OFFSET AS offset
          )
      )
      SELECT
          wup.mandant_id,
          wup.wup_id,
          wup.nb_id,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          NULL,
          CAST(p_clear_stock_ausschluss_fg AS INTEGER),
          current_timestamp(),
          current_timestamp()
        FROM
          kfl_production_dbp_view.v_wup_1 AS wup_1
        WHERE wup.mandant_id = p_mandant_id
         AND wup.wup_id IN(
          SELECT
              CAST(trim(col, ' ') AS INTEGER)
            FROM
              UNNEST(split(p_wups, ',')) AS col WITH OFFSET AS offset
        )
         AND wup.nb_id IN(
          SELECT
              CAST(trim(col, ' ') AS INTEGER)
            FROM
              UNNEST(split(p_nbs, ',')) AS col WITH OFFSET AS offset
        )
         AND NOT (wup.mandant_id, wup.wup_id, wup.nb_id) IN(
          SELECT AS STRUCT
              mandant_id,
              wup_id,
              nb_id
            FROM
              wup_update
        )
    ;
    SET return_value = 'WUP_1 gespeichert';
    RETURN;
  END;
