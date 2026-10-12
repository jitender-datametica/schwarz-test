CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_wbs_artikel_markt_massenbearbeitung(p_mandant_id FLOAT64, p_dat_von STRING, p_dat_bis STRING, p_art_ids STRING, p_wups STRING, p_angebote STRING, p_adjustment_fg INT64, p_faktor_rest_von_normalbestand NUMERIC, p_nachversorgung_schwellwert_pal_abrundung_proz NUMERIC, p_nachversorgung_schwellwert_pal_aufrundung_proz NUMERIC, OUT return_value STRING)
  BEGIN
  
    DECLARE dummy_1 FLOAT64;
    IF p_adjustment_fg IS NOT NULL THEN
      UPDATE kfl_production_dbp_data.ts_wbs_art_aktion_markt_1 SET adjustment_id = p_adjustment_fg WHERE ts_wbs_art_aktion_markt.mandant_id = p_mandant_id
       AND ts_wbs_art_aktion_markt.dat_von IN(
        SELECT
            CAST(trim(col, ' ') AS DATE)
          FROM
            UNNEST(split(p_dat_von, ',')) AS col WITH OFFSET AS offset
      )
       AND ts_wbs_art_aktion_markt.dat_bis IN(
        SELECT
            CAST(trim(col, ' ') AS DATE)
          FROM
            UNNEST(split(p_dat_bis, ',')) AS col WITH OFFSET AS offset
      )
       AND ts_wbs_art_aktion_markt.art_id IN(
        SELECT
            CAST(trim(col, ' ') AS INT64)
          FROM
            UNNEST(split(p_art_ids, ',')) AS col WITH OFFSET AS offset
          WHERE length(col) > NUMERIC '1'
      )
       AND ts_wbs_art_aktion_markt.wup_id IN(
        SELECT
            CAST(trim(col, ' ') AS INT64)
          FROM
            UNNEST(split(p_wups, ',')) AS col WITH OFFSET AS offset
      )
       AND ts_wbs_art_aktion_markt.angebot_nr IN(
        SELECT
            trim(col, ' ')
          FROM
            UNNEST(split(p_angebote, ',')) AS col WITH OFFSET AS offset
      );
    END IF;
    IF p_faktor_rest_von_normalbestand IS NOT NULL THEN
      UPDATE kfl_production_dbp_data.ts_wbs_art_aktion_markt_1 SET rest_von_normalbestand_proz = p_faktor_rest_von_normalbestand WHERE ts_wbs_art_aktion_markt.mandant_id = p_mandant_id
       AND ts_wbs_art_aktion_markt.dat_von IN(
        SELECT
            CAST(trim(col, ' ') AS DATE)
          FROM
            UNNEST(split(p_dat_von, ',')) AS col WITH OFFSET AS offset
      )
       AND ts_wbs_art_aktion_markt.dat_bis IN(
        SELECT
            CAST(trim(col, ' ') AS DATE)
          FROM
            UNNEST(split(p_dat_bis, ',')) AS col WITH OFFSET AS offset
      )
       AND ts_wbs_art_aktion_markt.art_id IN(
        SELECT
            CAST(trim(col, ' ') AS INT64)
          FROM
            UNNEST(split(p_art_ids, ',')) AS col WITH OFFSET AS offset
          WHERE length(col) > NUMERIC '1'
      )
       AND ts_wbs_art_aktion_markt.wup_id IN(
        SELECT
            CAST(trim(col, ' ') AS INT64)
          FROM
            UNNEST(split(p_wups, ',')) AS col WITH OFFSET AS offset
      )
       AND ts_wbs_art_aktion_markt.angebot_nr IN(
        SELECT
            trim(col, ' ')
          FROM
            UNNEST(split(p_angebote, ',')) AS col WITH OFFSET AS offset
      );
    END IF;
    IF p_nachversorgung_schwellwert_pal_abrundung_proz IS NOT NULL THEN
      UPDATE kfl_production_dbp_data.ts_wbs_art_aktion_markt_1 SET nachversorgung_schwellwert_pal_abrundung_proz = p_nachversorgung_schwellwert_pal_abrundung_proz WHERE ts_wbs_art_aktion_markt.mandant_id = p_mandant_id
       AND ts_wbs_art_aktion_markt.dat_von IN(
        SELECT
            CAST(trim(col, ' ') AS DATE)
          FROM
            UNNEST(split(p_dat_von, ',')) AS col WITH OFFSET AS offset
      )
       AND ts_wbs_art_aktion_markt.dat_bis IN(
        SELECT
            CAST(trim(col, ' ') AS DATE)
          FROM
            UNNEST(split(p_dat_bis, ',')) AS col WITH OFFSET AS offset
      )
       AND ts_wbs_art_aktion_markt.art_id IN(
        SELECT
            CAST(trim(col, ' ') AS INT64)
          FROM
            UNNEST(split(p_art_ids, ',')) AS col WITH OFFSET AS offset
          WHERE length(col) > NUMERIC '1'
      )
       AND ts_wbs_art_aktion_markt.wup_id IN(
        SELECT
            CAST(trim(col, ' ') AS INT64)
          FROM
            UNNEST(split(p_wups, ',')) AS col WITH OFFSET AS offset
      )
       AND ts_wbs_art_aktion_markt.angebot_nr IN(
        SELECT
            trim(col, ' ')
          FROM
            UNNEST(split(p_angebote, ',')) AS col WITH OFFSET AS offset
      );
    END IF;
    IF p_nachversorgung_schwellwert_pal_aufrundung_proz IS NOT NULL THEN
      UPDATE kfl_production_dbp_data.ts_wbs_art_aktion_markt_1 SET nachversorgung_schwellwert_pal_aufrundung_proz = p_nachversorgung_schwellwert_pal_aufrundung_proz WHERE ts_wbs_art_aktion_markt.mandant_id = p_mandant_id
       AND ts_wbs_art_aktion_markt.dat_von IN(
        SELECT
            CAST(trim(col, ' ') AS DATE)
          FROM
            UNNEST(split(p_dat_von, ',')) AS col WITH OFFSET AS offset
      )
       AND ts_wbs_art_aktion_markt.dat_bis IN(
        SELECT
            CAST(trim(col, ' ') AS DATE)
          FROM
            UNNEST(split(p_dat_bis, ',')) AS col WITH OFFSET AS offset
      )
       AND ts_wbs_art_aktion_markt.art_id IN(
        SELECT
            CAST(trim(col, ' ') AS INT64)
          FROM
            UNNEST(split(p_art_ids, ',')) AS col WITH OFFSET AS offset
          WHERE length(col) > NUMERIC '1'
      )
       AND ts_wbs_art_aktion_markt.wup_id IN(
        SELECT
            CAST(trim(col, ' ') AS INT64)
          FROM
            UNNEST(split(p_wups, ',')) AS col WITH OFFSET AS offset
      )
       AND ts_wbs_art_aktion_markt.angebot_nr IN(
        SELECT
            trim(col, ' ')
          FROM
            UNNEST(split(p_angebote, ',')) AS col WITH OFFSET AS offset
      );
    END IF;
    INSERT INTO kfl_production_dbp_data.ts_wbs_art_aktion_markt_1 (mandant_id, wup_id, nb_id, art_id, aktion_id, angebot_nr, dat_von, dat_bis, gk_fg, menge_mindestplatzierung_bme, top_gk_fg, fixmenge_wfl_bme, td_update, td_insert, adjustment_id, max_kapa_fg, dat_letzte_nachversorgung, rest_von_normalbestand_proz, nachversorgung_schwellwert_pal_abrundung_proz, nachversorgung_schwellwert_pal_aufrundung_proz)
      WITH angebot_artikel AS (
        SELECT DISTINCT
            aaw.mandant_id,
            agw.auslieferungsgruppe_id AS ausliefergruppe_id,
            t.kjwo AS kjwo,
            ww.kjwo_ww,
            coalesce(CASE
              WHEN aaw.angebot_nr = '' THEN NULL
              ELSE aaw.angebot_nr
            END, 'n/a') AS angebot_id,
            coalesce(CASE
              WHEN a.aktion_id = '' THEN NULL
              ELSE a.aktion_id
            END, 'n/a') AS aktion_id,
            a.angebot_typ_cd AS bonuskauf_promotionstyp,
            aaw.art_id,
            aaw.wup_id,
            aaw.nb_id AS nb_id,
            agw.mandant_id AS mandant_id_vz,
            CASE
              WHEN length(CAST(abs(agw.gp_id) as STRING)) <= NUMERIC '4' THEN agw.gp_id
              ELSE -NUMERIC '9'
            END AS wup_id_vz,
            SAFE_CAST(aa.gondelkopf_fg AS INTEGER) AS gk_fg,
            CAST(aa.topartikel_fg AS INTEGER) AS top_gk_fg,
            CAST(aa.mindestmenge_bme AS NUMERIC) AS menge_mindestplatzierung_bme,
            -NUMERIC '111' AS nb_id_vz,
            a.dat_angebot_gueltig_von AS dat_von,
            a.dat_angebot_gueltig_bis AS dat_bis,
            datetime_diff(a.dat_angebot_gueltig_bis, a.dat_angebot_gueltig_von, DAY) + NUMERIC '1' AS anz_tage_werbung
          FROM
            kfl_production_dbp_data.angebot_art_wup_zu_1 AS aaw
            INNER JOIN kfl_production_dbp_data.angebot_1 AS a ON aaw.angebot_nr = a.angebot_nr
             AND aaw.mandant_id = a.mandant_id
             AND a.angebot_geloescht_fg = NUMERIC '0'
            INNER JOIN kfl_production_dbp_view.v_werbewoche_kl_1 AS ww ON a.mandant_id = ww.mandant_id
             AND a.dat_angebot_gueltig_von = ww.dat
            INNER JOIN kfl_production_dbp_view.v_tag_1 AS t ON a.dat_angebot_gueltig_von = t.dat
            INNER JOIN kfl_production_dbp_view.v_art_gp_wup_dts_zu_per_1 AS agw ON CASE
              WHEN aaw.mandant_id = NUMERIC '4' THEN NUMERIC '7'
              ELSE aaw.mandant_id
            END = agw.mandant_id
             AND aaw.art_id = agw.art_id
             AND aaw.wup_id = agw.wup_id
             AND aaw.nb_id = coalesce(agw.nb_id, 0)
             AND agw.dat_bis = '9999-12-31'
            LEFT OUTER JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS a_gp ON aaw.art_id = a_gp.art_id
             AND aaw.mandant_id = a_gp.mandant_id
             AND aaw.wup_id = a_gp.wup_id
             AND aaw.nb_id = a_gp.nb_id
             AND a_gp.dat_bis = '9999-12-31'
            LEFT OUTER JOIN (
              SELECT
                  angebot_attribut_zu.mandant_id,
                  angebot_attribut_zu.angebot_nr,
                  max(CASE
                    WHEN angebot_attribut_zu.angebot_attribut_id = NUMERIC '42' THEN angebot_attribut_zu.angebot_attribut_txt
                  END) AS mindestmenge_bme,
                  max(CASE
                    WHEN angebot_attribut_zu.angebot_attribut_id = NUMERIC '49' THEN angebot_attribut_zu.angebot_attribut_txt
                  END) AS gondelkopf_fg,
                  max(CASE
                    WHEN angebot_attribut_zu.angebot_attribut_id = NUMERIC '46' THEN angebot_attribut_zu.angebot_attribut_txt
                  END) AS topartikel_fg
                FROM
                  kfl_production_dbp_data.angebot_attribut_zu_1
                WHERE angebot_attribut_zu.angebot_attribut_id BETWEEN NUMERIC '40' AND NUMERIC '53'
                GROUP BY 1, 2
            ) AS aa ON aaw.angebot_nr = aa.angebot_nr
             AND aaw.mandant_id = aa.mandant_id
          WHERE aaw.art_id NOT IN(
            NUMERIC '0', -NUMERIC '1'
          )
           AND loesch_fg = NUMERIC '0'
           AND a.angebot_geloescht_fg = NUMERIC '0'
           AND a.angebot_status_id IN(
            NUMERIC '4', NUMERIC '6'
          )
           AND a.transfer_status_id IN(
            NUMERIC '0', NUMERIC '3', NUMERIC '5', NUMERIC '6'
          )
           AND CASE
            WHEN a.mandant_id = NUMERIC '7'
             AND a.angebot_typ_cd NOT IN(
              'ZAI', 'ZAIR', 'ZAIM'
            ) THEN NUMERIC '1'
            WHEN a.mandant_id = NUMERIC '1'
             AND a.angebot_typ_cd NOT IN(
              'ZAI', 'ZAIR', 'ZAIM'
            ) THEN NUMERIC '1'
            WHEN a.angebot_typ_cd NOT IN(
              '0009', 'ZAI', 'ZAIR', 'ZAIM', '0010', 'ZB09', 'ZB10'
            ) THEN NUMERIC '1'
            ELSE NUMERIC '0'
          END = NUMERIC '1'
           AND (a.angebot_typ_cd NOT IN(
            '0005', '0006', '0007', '0008'
          )
           AND EXISTS (
            SELECT
                NUMERIC '1'
              FROM
                kfl_production_dbp_view.v_art_list_wup_zu_per_1 AS v_art_list
              WHERE v_art_list.dat_von <= a.dat_angebot_gueltig_von
               AND v_art_list.dat_bis >= a.dat_angebot_gueltig_bis
               AND aaw.mandant_id = v_art_list.mandant_id
               AND aaw.wup_id = v_art_list.wup_id
               AND aaw.art_id = v_art_list.art_id
          )
           OR a.angebot_typ_cd IN(
            '0005', '0006', '0007', '0008'
          ))
      ), art_update AS (
        SELECT
            ts_wbs_art_aktion_markt.*
          FROM
            kfl_production_dbp_data.ts_wbs_art_aktion_markt_1
          WHERE ts_wbs_art_aktion_markt.mandant_id = p_mandant_id
           AND ts_wbs_art_aktion_markt.dat_von IN(
            SELECT
                CAST(trim(col, ' ') AS DATE)
              FROM
                UNNEST(split(p_dat_von, ',')) AS col WITH OFFSET AS offset
          )
           AND ts_wbs_art_aktion_markt.dat_bis IN(
            SELECT
                CAST(trim(col, ' ') AS DATE)
              FROM
                UNNEST(split(p_dat_bis, ',')) AS col WITH OFFSET AS offset
          )
           AND ts_wbs_art_aktion_markt.art_id IN(
            SELECT
                CAST(trim(col, ' ') AS INT64)
              FROM
                UNNEST(split(p_art_ids, ',')) AS col WITH OFFSET AS offset
          )
           AND ts_wbs_art_aktion_markt.wup_id IN(
            SELECT
                CAST(trim(col, ' ') AS INT64)
              FROM
                UNNEST(split(p_wups, ',')) AS col WITH OFFSET AS offset
          )
           AND ts_wbs_art_aktion_markt.angebot_nr IN(
            SELECT
                trim(col, ' ')
              FROM
                UNNEST(split(p_angebote, ',')) AS col WITH OFFSET AS offset
          )
      )
      SELECT DISTINCT
          mandant_id,
          wup_id,
          nb_id,
          art_id,
          aktion_id,
          angebot_id,
          dat_von,
          dat_bis,
          gk_fg,
          menge_mindestplatzierung_bme,
          top_gk_fg,
          NUMERIC '0',
          current_timestamp(),
          current_timestamp(),
          p_adjustment_fg,
          0,
          CAST(NULL AS DATE),
          p_faktor_rest_von_normalbestand,
          p_nachversorgung_schwellwert_pal_abrundung_proz,
          p_nachversorgung_schwellwert_pal_aufrundung_proz
        FROM
          angebot_artikel
        WHERE mandant_id = p_mandant_id
         AND dat_von IN(
          SELECT
              CAST(trim(col, ' ') AS DATE)
            FROM
              UNNEST(split(p_dat_von, ',')) AS col WITH OFFSET AS offset
        )
         AND dat_bis IN(
          SELECT
              CAST(trim(col, ' ') AS DATE)
            FROM
              UNNEST(split(p_dat_bis, ',')) AS col WITH OFFSET AS offset
        )
         AND art_id IN(
          SELECT
              CAST(trim(col, ' ') AS INT64)
            FROM
              UNNEST(split(p_art_ids, ',')) AS col WITH OFFSET AS offset
            WHERE length(col) > NUMERIC '1'
        )
         AND wup_id IN(
          SELECT
              CAST(trim(col, ' ') AS INT64)
            FROM
              UNNEST(split(p_wups, ',')) AS col WITH OFFSET AS offset
        )
         AND angebot_id IN(
          SELECT
              trim(col, ' ')
            FROM
              UNNEST(split(p_angebote, ',')) AS col WITH OFFSET AS offset
        )
         AND NOT (mandant_id, aktion_id, art_id, dat_von, dat_bis, angebot_id, wup_id) IN(
          SELECT AS STRUCT
              art_update.mandant_id,
              aktion_id,
              art_update.art_id,
              art_update.dat_von,
              art_update.dat_bis,
              angebot_nr AS angebot_nr,
              art_update.wup_id
            FROM
              art_update
        )
    ;
    SET return_value = 'Artikel_1 gespeichert';
    RETURN;
  END;


