CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_stock_massenbearbeitung_promotage_harmonisieren(
  p_art_ids STRING, 
  p_wup_ids STRING, 
  p_nb_ids STRING, 
  p_mandant_ids STRING, 
  p_dat_von_list STRING, 
  p_dat_bis_list STRING, 
  p_order_proposal STRING, 
  p_confirm_fg FLOAT64, 
  OUT return_value STRING
)
BEGIN
  DECLARE dummy_2 FLOAT64;

  IF p_confirm_fg = NUMERIC '1' THEN
    
    -- ------------------------------------------------------------------
    -- STEP 1: UPDATE
    -- ------------------------------------------------------------------
    UPDATE kfl_production_dbp_msi_data.ts_wbs_bestellvorschlag_in_promo_2 AS t 
    SET menge_bestellvorschlag_in_promo_ame = CAST(COALESCE(m.order_proposal, t.menge_bestellvorschlag_in_promo_ame) AS NUMERIC), 
        td_update = CURRENT_TIMESTAMP() 
    FROM (
      WITH art_list AS (
        SELECT
            offset AS rn,
            ROUND(CAST(TRIM(col, ' ')  AS BIGNUMERIC), 0) AS art_id
          FROM UNNEST(SPLIT(p_art_ids, ',')) AS col WITH OFFSET AS offset
      ), wup_list AS (
        SELECT
            offset AS rn,
            ROUND(CAST(TRIM(col, ' ') AS BIGNUMERIC), 0) AS wup_id
          FROM UNNEST(SPLIT(p_wup_ids, ',')) AS col WITH OFFSET AS offset
      ), dat_von_list AS (
        SELECT
            offset AS rn,
            CAST(TRIM(col, ' ')  AS DATE) AS dat_von
          FROM UNNEST(SPLIT(p_dat_von_list, ',')) AS col WITH OFFSET AS offset
      ), dat_bis_list AS (
        SELECT
            offset AS rn,
            CAST(TRIM(col, ' ')  AS DATE) AS dat_bis
          FROM UNNEST(SPLIT(p_dat_bis_list, ',')) AS col WITH OFFSET AS offset
      ), ord_list AS (
        SELECT
            offset AS rn,
            CAST(TRIM(CAST(COALESCE(CAST(col AS BIGNUMERIC), NUMERIC '0') AS STRING), ' ') AS FLOAT64) AS order_proposal_raw
          FROM UNNEST(SPLIT(p_order_proposal, ',')) AS col WITH OFFSET AS offset
      ), pos_map AS (
        SELECT
            a.art_id,
            w.wup_id,
            v.dat_von,
            b.dat_bis,
            o.order_proposal_raw
          FROM
            art_list AS a
            INNER JOIN wup_list AS w ON a.rn = w.rn
            INNER JOIN dat_von_list AS v ON a.rn = v.rn
            INNER JOIN dat_bis_list AS b ON a.rn = b.rn
            INNER JOIN ord_list AS o ON a.rn = o.rn
      ), comb_map AS (
        SELECT
            pos_map.art_id,
            pos_map.wup_id,
            pos_map.dat_von,
            pos_map.dat_bis,
            MAX(order_proposal_raw) AS order_proposal
          FROM
            pos_map
          GROUP BY 1, 2, 3, 4
      )
      SELECT comb_map.* FROM comb_map
    ) AS m 
    WHERE t.art_id = m.art_id
     AND t.wup_id = m.wup_id
     AND t.dat_aktion_von = m.dat_von
     AND t.dat_aktion_bis = m.dat_bis
     AND t.mandant_id IN (
      SELECT CAST(TRIM(col, ' ') AS INTEGER) FROM UNNEST(SPLIT(p_mandant_ids, ',')) AS col WITH OFFSET AS offset
    )
     AND t.nb_id IN (
      SELECT CAST(TRIM(col, ' ') AS INTEGER) FROM UNNEST(SPLIT(p_nb_ids, ',')) AS col WITH OFFSET AS offset
    );

    -- ------------------------------------------------------------------
    -- STEP 2: MERGE
    -- ------------------------------------------------------------------
    MERGE INTO kfl_production_dbp_msi_data.ts_wbs_bestellvorschlag_in_promo_2 AS t 
    USING (
      WITH base_data AS (
        SELECT DISTINCT
            a_art_wup.mandant_id,
            a_art_wup.wup_id,
            a_art_wup.angebot_nr,
            a_art_wup.art_id,
            a_art_wup.nb_id,
            a.dat_angebot_gueltig_von,
            a.dat_angebot_gueltig_bis
          FROM
            dbp_view.v_angebot_art_wup_zu_2 AS a_art_wup
            INNER JOIN dbp_view.v_angebot_2 AS a ON a.angebot_nr = a_art_wup.angebot_nr
             AND a.mandant_id = a_art_wup.mandant_id
             AND a.angebot_geloescht_fg = NUMERIC '0'
            INNER JOIN dbp_view.v_tag_2 AS t_0 ON a.dat_angebot_gueltig_von = t_0.dat
          WHERE a_art_wup.art_id NOT IN (NUMERIC '0', -NUMERIC '1')
           AND a.angebot_status_id IN (NUMERIC '4', NUMERIC '6')
           AND a.transfer_status_id IN (NUMERIC '0', NUMERIC '3', NUMERIC '5', NUMERIC '6')
           AND a.angebot_geloescht_fg = NUMERIC '0'
           AND CASE
            WHEN a_art_wup.mandant_id = NUMERIC '7' AND a.angebot_typ_cd NOT IN ('ZAI', 'ZAIR', 'ZAIM') THEN NUMERIC '1'
            WHEN a_art_wup.mandant_id = NUMERIC '1' AND a.angebot_typ_cd NOT IN ('ZAI', 'ZAIR', 'ZAIM') THEN NUMERIC '1'
            WHEN a.angebot_typ_cd NOT IN ('0009', 'ZAI', 'ZAIR', 'ZAIM', '0010', 'ZB09', 'ZB10') THEN NUMERIC '1'
            ELSE NUMERIC '0'
          END = NUMERIC '1'
           AND (a.angebot_typ_cd NOT IN ('0005', '0006', '0007', '0008')
           AND EXISTS (
            SELECT
                NUMERIC '1'
              FROM
                dbp_view.v_art_list_wup_zu_per_2 AS v_art_list
              WHERE v_art_list.dat_von <= a.dat_angebot_gueltig_von
               AND v_art_list.dat_bis >= a.dat_angebot_gueltig_bis
               AND a_art_wup.mandant_id = v_art_list.mandant_id
               AND a_art_wup.wup_id = v_art_list.wup_id
               AND a_art_wup.art_id = v_art_list.art_id
          )
           OR a.angebot_typ_cd IN ('0005', '0006', '0007', '0008'))
           AND akt_wo IN (NUMERIC '0', -NUMERIC '1')
           AND t_0.akt_kj = NUMERIC '0'
      ), art_list AS (
        SELECT
            offset AS rn,
            ROUND(CAST(CAST(TRIM(col, ' ') AS INTEGER) AS BIGNUMERIC), 0) AS art_id
          FROM UNNEST(SPLIT(p_art_ids, ',')) AS col WITH OFFSET AS offset
      ), wup_list AS (
        SELECT
            offset AS rn,
            ROUND(CAST(CAST(TRIM(col, ' ') AS INTEGER) AS BIGNUMERIC), 0) AS wup_id
          FROM UNNEST(SPLIT(p_wup_ids, ',')) AS col WITH OFFSET AS offset
      ), dat_von_list AS (
        SELECT
            offset AS rn,
            CAST(TRIM(col, ' ') AS DATE) AS dat_von
          FROM UNNEST(SPLIT(p_dat_von_list, ',')) AS col WITH OFFSET AS offset
      ), dat_bis_list AS (
        SELECT
            offset AS rn,
            CAST(TRIM(col, ' ') AS DATE) AS dat_bis
          FROM UNNEST(SPLIT(p_dat_bis_list, ',')) AS col WITH OFFSET AS offset
      ), ord_list AS (
        SELECT
            offset AS rn,
            CAST(TRIM(CAST(COALESCE(CAST(col AS BIGNUMERIC), NUMERIC '0') AS STRING), ' ') AS FLOAT64) AS order_proposal_raw
          FROM UNNEST(SPLIT(p_order_proposal, ',')) AS col WITH OFFSET AS offset
      ), pos_map AS (
        SELECT
            a.art_id,
            w.wup_id,
            v.dat_von,
            b.dat_bis,
            o.order_proposal_raw
          FROM
            art_list AS a
            INNER JOIN wup_list AS w ON a.rn = w.rn
            INNER JOIN dat_von_list AS v ON a.rn = v.rn
            INNER JOIN dat_bis_list AS b ON a.rn = b.rn
            INNER JOIN ord_list AS o ON a.rn = o.rn
      ), comb_map AS (
        SELECT
            pos_map.art_id,
            pos_map.wup_id,
            dat_von,
            dat_bis,
            MAX(order_proposal_raw) AS order_proposal
          FROM
            pos_map
          GROUP BY 1, 2, 3, 4
      ), mandant_list AS (
        SELECT CAST(TRIM(col, ' ') AS INTEGER) AS mandant_id FROM UNNEST(SPLIT(p_mandant_ids, ',')) AS col WITH OFFSET AS offset
      ), nb_list AS (
        SELECT CAST(TRIM(col, ' ') AS INTEGER) AS nb_id FROM UNNEST(SPLIT(p_nb_ids, ',')) AS col WITH OFFSET AS offset
      )
      SELECT DISTINCT
          base.art_id,
          base.wup_id,
          base.nb_id,
          base.mandant_id,
          base.dat_angebot_gueltig_von AS dat_von,
          base.dat_angebot_gueltig_bis AS dat_bis,
          c.order_proposal
        FROM
          base_data AS base
          INNER JOIN comb_map AS c ON base.art_id = c.art_id
           AND base.wup_id = c.wup_id
           AND base.dat_angebot_gueltig_von = c.dat_von
           AND base.dat_angebot_gueltig_bis = c.dat_bis
        WHERE base.mandant_id IN (SELECT mandant_list.mandant_id FROM mandant_list)
         AND base.nb_id IN (SELECT nb_list.nb_id FROM nb_list)
    ) AS src
    ON t.mandant_id = src.mandant_id
     AND t.art_id = src.art_id
     AND t.wup_id = src.wup_id
     AND t.nb_id = src.nb_id
     AND t.dat_aktion_von = src.dat_von
     AND t.dat_aktion_bis = src.dat_bis
       WHEN NOT MATCHED BY TARGET THEN
        INSERT (art_id, wup_id, nb_id, mandant_id, dat_aktion_von, dat_aktion_bis, menge_bestellvorschlag_in_promo_ame, td_insert, td_update)
        VALUES (src.art_id, src.wup_id, src.nb_id, src.mandant_id, src.dat_von, src.dat_bis, CAST(src.order_proposal AS NUMERIC), CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP())
    ;

    SET return_value = 'Artikel_2 abgespeichert';
    RETURN;
  ELSE
    SET return_value = 'Keine Aktion_2 (P_CONFIRM_FG <> 1)';
    RETURN;
  END IF;
END;