-- '_dmP_AUSLIEFERGRUPPEN'_dm STRING ,



CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_wbs_artikel_vz_massenbearbeitung(IN P_MANDANT_ID FLOAT64, IN P_KJWO STRING, IN P_ART_IDS STRING, IN P_GPS STRING, IN P_ANGEBOTE STRING, IN P_CLEAR_STOCK_FG FLOAT64, IN P_ADJUSTMENT_FG FLOAT64, IN P_MAX_KAPA_FG FLOAT64, IN P_ESTIMATION_FG FLOAT64, IN P_DAT_LETZTE_NACHVERSORGUNG DATE, IN P_DATE_CLEAR BOOL, IN P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ FLOAT64, IN P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ FLOAT64, OUT out_param STRING)
BEGIN
DECLARE dummy_1 FLOAT64;
BEGIN
BEGIN TRANSACTION;
------ STEP 1 UPDATE ------

IF P_CLEAR_STOCK_FG IS NOT NULL THEN
    UPDATE dbp_data.ts_wbs_artikel_vz_1 SET
    clear_stock_id = CAST(P_CLEAR_STOCK_FG AS INTEGER),
    td_update = CURRENT_TIMESTAMP()
WHERE mandant_id = P_MANDANT_ID AND kjwo IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                        FROM (SELECT 1 AS seq) AS t
                            INNER JOIN UNNEST(SPLIT(P_KJWO, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND art_id IN (SELECT CAST(TRIM(value) AS INTEGER) AS a180718717
                    FROM (SELECT t3.seq, ORDINALITY + 1 AS index, VALUE AS value
                            FROM (SELECT 1 AS seq) AS t3
                                INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t4
                    WHERE LENGTH(t4.value) > 1) AND gp_id IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                FROM (SELECT 1 AS seq) AS t7
                    INNER JOIN UNNEST(SPLIT(P_GPS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND angebot_nr IN (SELECT TRIM(VALUE) AS a180718717
            FROM (SELECT 1 AS seq) AS t10
                INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE);
END IF;


IF P_MAX_KAPA_FG IS NOT NULL THEN
    UPDATE dbp_data.ts_wbs_artikel_vz_1 SET
    max_kapa_fg = CAST(P_MAX_KAPA_FG AS INTEGER),
    td_update = CURRENT_TIMESTAMP()
WHERE mandant_id = P_MANDANT_ID AND kjwo IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                        FROM (SELECT 1 AS seq) AS t
                            INNER JOIN UNNEST(SPLIT(P_KJWO, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND art_id IN (SELECT CAST(TRIM(value) AS INTEGER) AS a180718717
                    FROM (SELECT t3.seq, ORDINALITY + 1 AS index, VALUE AS value
                            FROM (SELECT 1 AS seq) AS t3
                                INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t4
                    WHERE LENGTH(t4.value) > 1) AND gp_id IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                FROM (SELECT 1 AS seq) AS t7
                    INNER JOIN UNNEST(SPLIT(P_GPS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND angebot_nr IN (SELECT TRIM(VALUE) AS a180718717
            FROM (SELECT 1 AS seq) AS t10
                INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE);
END IF;


IF P_ADJUSTMENT_FG IS NOT NULL THEN
    UPDATE dbp_data.ts_wbs_artikel_vz_1 SET
    adjustment_id = CAST(P_ADJUSTMENT_FG AS INTEGER),
    td_update = CURRENT_TIMESTAMP()
WHERE mandant_id = P_MANDANT_ID AND kjwo IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                        FROM (SELECT 1 AS seq) AS t
                            INNER JOIN UNNEST(SPLIT(P_KJWO, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND art_id IN (SELECT CAST(TRIM(value) AS INTEGER) AS a180718717
                    FROM (SELECT t3.seq, ORDINALITY + 1 AS index, VALUE AS value
                            FROM (SELECT 1 AS seq) AS t3
                                INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t4
                    WHERE LENGTH(t4.value) > 1) AND gp_id IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                FROM (SELECT 1 AS seq) AS t7
                    INNER JOIN UNNEST(SPLIT(P_GPS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND angebot_nr IN (SELECT TRIM(VALUE) AS a180718717
            FROM (SELECT 1 AS seq) AS t10
                INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE);
END IF;


IF P_DAT_LETZTE_NACHVERSORGUNG IS NOT NULL THEN
    UPDATE dbp_data.ts_wbs_artikel_vz_1 SET
    dat_letzte_nachversorgung = P_DAT_LETZTE_NACHVERSORGUNG,
    td_update = CURRENT_TIMESTAMP()
WHERE mandant_id = P_MANDANT_ID AND kjwo IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                        FROM (SELECT 1 AS seq) AS t
                            INNER JOIN UNNEST(SPLIT(P_KJWO, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND art_id IN (SELECT CAST(TRIM(value) AS INTEGER) AS a180718717
                    FROM (SELECT t3.seq, ORDINALITY + 1 AS index, VALUE AS value
                            FROM (SELECT 1 AS seq) AS t3
                                INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t4
                    WHERE LENGTH(t4.value) > 1) AND gp_id IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                FROM (SELECT 1 AS seq) AS t7
                    INNER JOIN UNNEST(SPLIT(P_GPS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND angebot_nr IN (SELECT TRIM(VALUE) AS a180718717
            FROM (SELECT 1 AS seq) AS t10
                INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE);
END IF;


IF P_DAT_LETZTE_NACHVERSORGUNG IS NOT NULL AND NOT P_DATE_CLEAR THEN
    UPDATE dbp_data.ts_wbs_artikel_vz_1 SET
    dat_letzte_nachversorgung = P_DAT_LETZTE_NACHVERSORGUNG,
    td_update = CURRENT_TIMESTAMP()
WHERE mandant_id = P_MANDANT_ID AND kjwo IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                        FROM (SELECT 1 AS seq) AS t
                            INNER JOIN UNNEST(SPLIT(P_KJWO, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND art_id IN (SELECT CAST(TRIM(value) AS INTEGER) AS a180718717
                    FROM (SELECT t3.seq, ORDINALITY + 1 AS index, VALUE AS value
                            FROM (SELECT 1 AS seq) AS t3
                                INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t4
                    WHERE LENGTH(t4.value) > 1) AND gp_id IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                FROM (SELECT 1 AS seq) AS t7
                    INNER JOIN UNNEST(SPLIT(P_GPS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND angebot_nr IN (SELECT TRIM(VALUE) AS a180718717
            FROM (SELECT 1 AS seq) AS t10
                INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE);
END IF;


IF P_DATE_CLEAR THEN
    UPDATE dbp_data.ts_wbs_artikel_vz_1 SET
    dat_letzte_nachversorgung = NULL,
    td_update = CURRENT_TIMESTAMP()
WHERE mandant_id = P_MANDANT_ID AND kjwo IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                        FROM (SELECT 1 AS seq) AS t
                            INNER JOIN UNNEST(SPLIT(P_KJWO, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND art_id IN (SELECT CAST(TRIM(value) AS INTEGER) AS a180718717
                    FROM (SELECT t3.seq, ORDINALITY + 1 AS index, VALUE AS value
                            FROM (SELECT 1 AS seq) AS t3
                                INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t4
                    WHERE LENGTH(t4.value) > 1) AND gp_id IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                FROM (SELECT 1 AS seq) AS t7
                    INNER JOIN UNNEST(SPLIT(P_GPS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND angebot_nr IN (SELECT TRIM(VALUE) AS a180718717
            FROM (SELECT 1 AS seq) AS t10
                INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE);
END IF;


IF P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ IS NOT NULL THEN
    UPDATE dbp_data.ts_wbs_artikel_vz_1 SET
    nachversorgung_schwellwert_pal_abrundung_proz = ROUND(CAST(P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ AS NUMERIC), 3),
    td_update = CURRENT_TIMESTAMP()
WHERE mandant_id = P_MANDANT_ID AND kjwo IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                        FROM (SELECT 1 AS seq) AS t
                            INNER JOIN UNNEST(SPLIT(P_KJWO, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND art_id IN (SELECT CAST(TRIM(value) AS INTEGER) AS a180718717
                    FROM (SELECT t3.seq, ORDINALITY + 1 AS index, VALUE AS value
                            FROM (SELECT 1 AS seq) AS t3
                                INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t4
                    WHERE LENGTH(t4.value) > 1) AND gp_id IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                FROM (SELECT 1 AS seq) AS t7
                    INNER JOIN UNNEST(SPLIT(P_GPS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND angebot_nr IN (SELECT TRIM(VALUE) AS a180718717
            FROM (SELECT 1 AS seq) AS t10
                INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE);
END IF;


IF P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ IS NOT NULL THEN
    UPDATE dbp_data.ts_wbs_artikel_vz_1 SET
    nachversorgung_schwellwert_pal_aufrundung_proz = ROUND(CAST(P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ AS NUMERIC), 3),
    td_update = CURRENT_TIMESTAMP()
WHERE mandant_id = P_MANDANT_ID AND kjwo IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                        FROM (SELECT 1 AS seq) AS t
                            INNER JOIN UNNEST(SPLIT(P_KJWO, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND art_id IN (SELECT CAST(TRIM(value) AS INTEGER) AS a180718717
                    FROM (SELECT t3.seq, ORDINALITY + 1 AS index, VALUE AS value
                            FROM (SELECT 1 AS seq) AS t3
                                INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t4
                    WHERE LENGTH(t4.value) > 1) AND gp_id IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                FROM (SELECT 1 AS seq) AS t7
                    INNER JOIN UNNEST(SPLIT(P_GPS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND angebot_nr IN (SELECT TRIM(VALUE) AS a180718717
            FROM (SELECT 1 AS seq) AS t10
                INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE);
END IF;

------ STEP 2 INSERT ------
INSERT INTO dbp_data.ts_wbs_artikel_vz_1 (mandant_id, kjwo, angebot_nr, aktion_id, ausliefergruppe_id, art_id, wup_id_vz, nb_id_vz, mandant_id_vz, bezugsweg_id, gp_id, clear_stock_id, lieferung_tag_offset, estimation_fg, adjustment_id, max_kapa_fg, dat_letzte_nachversorgung, nachversorgung_schwellwert_pal_abrundung_proz, nachversorgung_schwellwert_pal_aufrundung_proz, td_update, td_insert)
WITH ANGEBOT_ARTIKEL AS (SELECT DISTINCT AW.mandant_id, AGW.mandant_id AS mandant_id_vz, CASE WHEN LENGTH(CAST(ABS(AGW.gp_id) AS STRING)) <= 4 THEN AGW.gp_id ELSE CAST(-9 AS BIGNUMERIC) END AS wup_id_vz, CASE WHEN AGW.auslieferungsgruppe_id = 'VEN' THEN A_GP.gp_id ELSE AGW.gp_id END AS gp_id, -111 AS nb_id_vz, AGW.auslieferungsgruppe_id AS ausliefergruppe_id, T.kjwo, WW.kjwo_ww, COALESCE(CASE WHEN AW.angebot_nr = '' THEN NULL ELSE AW.angebot_nr END, 'n/a') AS angebot_id, COALESCE(CASE WHEN A.aktion_id = '' THEN NULL ELSE A.aktion_id END, 'n/a') AS aktion_id, A.aktion_typ_id AS bonuskauf_promotionstyp, AW.art_id, A.dat_angebot_gueltig_von AS dat_von, A.dat_angebot_gueltig_bis AS dat_bis, DATE_DIFF(A.dat_angebot_gueltig_bis, A.dat_angebot_gueltig_von, DAY) + 1 AS anz_tage_werbung
            FROM dbp_data.angebot_art_wup_zu_1 AS AW
                INNER JOIN dbp_data.angebot_1 AS A ON AW.angebot_nr = A.angebot_nr AND AW.mandant_id = A.mandant_id AND A.angebot_geloescht_fg = 0
                INNER JOIN dbp_view.v_werbewoche_kl_1 AS WW ON A.mandant_id = WW.mandant_id AND A.dat_angebot_gueltig_von = WW.dat
                INNER JOIN dbp_view.v_tag_1 AS T ON A.dat_angebot_gueltig_von = T.dat
                INNER JOIN dbp_view.v_art_gp_wup_dts_zu_per_1 AS AGW ON CASE WHEN AW.mandant_id = 4 THEN 7 ELSE AW.mandant_id END = AGW.mandant_id AND AW.art_id = AGW.art_id AND AW.wup_id = AGW.wup_id AND AW.nb_id = COALESCE(AGW.nb_id, 0) AND AGW.dat_bis = DATE '9999-12-31'
                LEFT JOIN dbp_view.v_art_gp_nm_zu_per_1 AS A_GP ON AW.art_id = A_GP.art_id AND AW.mandant_id = A_GP.mandant_id AND AW.wup_id = A_GP.wup_id AND AW.nb_id = A_GP.nb_id AND A_GP.dat_bis = DATE '9999-12-31'
            WHERE AGW.loesch_fg = 0 AND EXISTS (SELECT 1
                    FROM dbp_view.v_art_list_wup_zu_per_1 AS V02
                    WHERE DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY) BETWEEN DATE_SUB(dat_von, INTERVAL 7 DAY) AND dat_bis AND AW.mandant_id = mandant_id AND AW.wup_id = wup_id AND AW.art_id = art_id) AND A.angebot_status_id IN (4, 6) AND A.transfer_status_id IN (0, 3, 5, 6) AND A.angebot_geloescht_fg IN (0) AND CASE WHEN AW.mandant_id = 7 AND A.angebot_typ_cd NOT IN ('ZAI', 'ZAIR', 'ZAIM') OR AW.mandant_id = 1 AND A.angebot_typ_cd NOT IN ('ZAI', 'ZAIR', 'ZAIM') OR A.angebot_typ_cd NOT IN ('0009', 'ZAI', 'ZAIR', 'ZAIM', '0010', 'ZB09', 'ZB10') THEN 1 ELSE 0 END = 1 AND AW.art_id NOT IN (0, -1)) (SELECT DISTINCT mandant_id, CAST(kjwo AS INTEGER) AS kjwo, angebot_id, aktion_id, ausliefergruppe_id, art_id, CAST(wup_id_vz AS INTEGER) AS wup_id_vz, nb_id_vz, CAST(mandant_id_vz AS INTEGER) AS mandant_id_vz, -9, CAST(COALESCE(gp_id, -9) AS INTEGER) AS gp_id, CAST(P_CLEAR_STOCK_FG AS INTEGER), CAST(NULL AS INTEGER), CAST(P_ESTIMATION_FG AS INTEGER), CAST(P_ADJUSTMENT_FG AS INTEGER), CAST(P_MAX_KAPA_FG AS INTEGER), P_DAT_LETZTE_NACHVERSORGUNG, ROUND(CAST(P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ AS NUMERIC), 3), ROUND(CAST(P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ AS NUMERIC), 3), CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()
            FROM ANGEBOT_ARTIKEL
            WHERE mandant_id = P_MANDANT_ID AND kjwo IN (SELECT ROUND(CAST(TRIM(VALUE) AS BIGNUMERIC), 0) AS a180718717
                        FROM (SELECT 1 AS seq) AS t6
                            INNER JOIN UNNEST(SPLIT(P_KJWO, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND art_id IN (SELECT CAST(TRIM(value) AS INTEGER) AS a180718717
                        FROM (SELECT t9.seq, ORDINALITY + 1 AS index, VALUE AS value
                                FROM (SELECT 1 AS seq) AS t9
                                    INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t10
                        WHERE LENGTH(t10.value) > 1) AND gp_id IN (SELECT ROUND(CAST(TRIM(VALUE) AS BIGNUMERIC), 0) AS a180718717
                        FROM (SELECT 1 AS seq) AS t13
                            INNER JOIN UNNEST(SPLIT(P_GPS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND angebot_id IN (SELECT TRIM(VALUE) AS a180718717
                        FROM (SELECT 1 AS seq) AS t16
                            INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND (kjwo, art_id, gp_id, angebot_id) NOT IN (SELECT (kjwo, art_id, gp_id, angebot_nr)
                        FROM dbp_data.ts_wbs_artikel_vz_1
                        WHERE mandant_id = P_MANDANT_ID AND kjwo IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                                    FROM (SELECT 1 AS seq) AS t19
                                        INNER JOIN UNNEST(SPLIT(P_KJWO, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND art_id IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                                    FROM (SELECT 1 AS seq) AS t22
                                        INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND gp_id IN (SELECT CAST(TRIM(VALUE) AS INTEGER) AS a180718717
                                    FROM (SELECT 1 AS seq) AS t25
                                        INNER JOIN UNNEST(SPLIT(P_GPS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND angebot_nr IN (SELECT TRIM(VALUE) AS a180718717
                                    FROM (SELECT 1 AS seq) AS t28
                                        INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE)));
COMMIT TRANSACTION;
SET out_param  =  'Artikel_1 abgespeichert';
SELECT out_param;
RETURN;
END;
END;

