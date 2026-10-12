CREATE OR REPLACE PROCEDURE dbp_macro.m_ups_ts_mengenaenderungen_writeback_massenbearbeitung(IN P_MANDANT_ID INT64,
IN P_DAT_BELADUNG STRING,
IN P_ART_IDS STRING,
IN P_ANGEBOTE STRING,
IN P_AKTIONEN STRING,
IN P_MENGE_OHNE_BESTAND_GENEHMIGT_FG INT64,
IN P_MENGE_MIT_BESTAND_GENEHMIGT_FG INT64,
IN P_WFL_MENGE_GEPRUEFT_FG INT64,
IN P_ESTIMATION_ID INT64,
IN P_ADJUSTMENT_ID INT64,
OUT out_param STRING)
BEGIN
BEGIN TRANSACTION;
---------------------------
------ STEP 1 UPDATE ------

IF P_MENGE_OHNE_BESTAND_GENEHMIGT_FG IS NOT NULL THEN
    BEGIN
    -- Wenn wir alles hier setzen dann könnten wir dies so machen 
    UPDATE dbp_data.ts_mengenaenderungen_writeback_1 
    SET  menge_ohne_bestand_genehmigt_fg = P_MENGE_OHNE_BESTAND_GENEHMIGT_FG,
    td_update = CURRENT_TIMESTAMP()
WHERE mandant_id = P_MANDANT_ID 
AND art_id IN (SELECT CAST(value AS INTEGER) AS value
                        FROM (SELECT t.seq, ORDINALITY + 1 AS index, VALUE AS value
                                FROM (SELECT 1 AS seq) AS t
                                    INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t1_1
                        WHERE LENGTH(t1.value) > 1) AND angebot_id IN (SELECT CAST(VALUE AS INTEGER) AS value
                    FROM (SELECT 1 AS seq) AS t4
                        INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND aktion_id IN (SELECT LPAD(VALUE, 10, '0') AS a1453165860
                FROM (SELECT 1 AS seq) AS t7
                    INNER JOIN UNNEST(SPLIT(P_AKTIONEN, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND dat_beladung = CAST(P_DAT_BELADUNG AS DATE);
    END;
END IF;


IF P_MENGE_MIT_BESTAND_GENEHMIGT_FG IS NOT NULL THEN
    BEGIN
    -- Wenn wir alles hier setzen dann könnten wir dies so machen 
    UPDATE dbp_data.ts_mengenaenderungen_writeback_1 
    SET menge_mit_bestand_genehmigt_fg = P_MENGE_MIT_BESTAND_GENEHMIGT_FG,
    td_update = CURRENT_TIMESTAMP()
WHERE mandant_id = P_MANDANT_ID 
AND art_id IN (SELECT CAST(value AS INTEGER) AS value
                        FROM (SELECT t.seq, ORDINALITY + 1 AS index, VALUE AS value
                                FROM (SELECT 1 AS seq) AS t
                                    INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t1_1
                        WHERE LENGTH(t1.value) > 1) AND angebot_id IN (SELECT CAST(VALUE AS INTEGER) AS value
                    FROM (SELECT 1 AS seq) AS t4
                        INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND aktion_id IN (SELECT LPAD(VALUE, 10, '0') AS a1453165860
                FROM (SELECT 1 AS seq) AS t7
                    INNER JOIN UNNEST(SPLIT(P_AKTIONEN, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND dat_beladung = CAST(P_DAT_BELADUNG AS DATE);
    END;
END IF;


IF P_WFL_MENGE_GEPRUEFT_FG IS NOT NULL THEN
    UPDATE dbp_data.ts_mengenaenderungen_writeback_1 
    SET  wfl_menge_geprueft_fg = P_WFL_MENGE_GEPRUEFT_FG,
    td_update = CURRENT_TIMESTAMP()
WHERE mandant_id = P_MANDANT_ID 
AND art_id IN (SELECT CAST(value AS INTEGER) AS value
                        FROM (SELECT t.seq, ORDINALITY + 1 AS index, VALUE AS value
                                FROM (SELECT 1 AS seq) AS t
                                    INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t1_1
                        WHERE LENGTH(t1.value) > 1) AND angebot_id IN (SELECT CAST(VALUE AS INTEGER) AS value
                    FROM (SELECT 1 AS seq) AS t4
                        INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND aktion_id IN (SELECT LPAD(VALUE, 10, '0') AS a1453165860
                FROM (SELECT 1 AS seq) AS t7
                    INNER JOIN UNNEST(SPLIT(P_AKTIONEN, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND dat_beladung = CAST(P_DAT_BELADUNG AS DATE);
END IF;


IF P_ESTIMATION_ID IS NOT NULL THEN
    UPDATE dbp_data.ts_mengenaenderungen_writeback_1 
    SET estimation_id = P_ESTIMATION_ID,
    td_update = CURRENT_TIMESTAMP()
WHERE mandant_id = P_MANDANT_ID 
AND art_id IN (SELECT CAST(value AS INTEGER) AS value
                        FROM (SELECT t.seq, ORDINALITY + 1 AS index, VALUE AS value
                                FROM (SELECT 1 AS seq) AS t
                                    INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t1_1
                        WHERE LENGTH(t1.value) > 1) AND angebot_id IN (SELECT CAST(VALUE AS INTEGER) AS value
                    FROM (SELECT 1 AS seq) AS t4
                        INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND aktion_id IN (SELECT LPAD(VALUE, 10, '0') AS a1453165860
                FROM (SELECT 1 AS seq) AS t7
                    INNER JOIN UNNEST(SPLIT(P_AKTIONEN, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND dat_beladung = CAST(P_DAT_BELADUNG AS DATE);
END IF;


IF P_ADJUSTMENT_ID IS NOT NULL THEN
    UPDATE dbp_data.ts_mengenaenderungen_writeback_1 
    SET adjustment_id = P_ADJUSTMENT_ID,
    td_update = CURRENT_TIMESTAMP()
WHERE mandant_id = P_MANDANT_ID 
AND art_id IN (SELECT CAST(value AS INTEGER) AS value
                        FROM (SELECT t.seq, ORDINALITY + 1 AS index, VALUE AS value
                                FROM (SELECT 1 AS seq) AS t
                                    INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t1_1
                        WHERE LENGTH(t1.value) > 1) AND angebot_id IN (SELECT CAST(VALUE AS INTEGER) AS value
                    FROM (SELECT 1 AS seq) AS t4
                        INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND aktion_id IN (SELECT LPAD(VALUE, 10, '0') AS a1453165860
                FROM (SELECT 1 AS seq) AS t7
                    INNER JOIN UNNEST(SPLIT(P_AKTIONEN, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND dat_beladung = CAST(P_DAT_BELADUNG AS DATE);
END IF;

---------------------------
------ STEP 2 INSERT ------
--- Alle Artikel_1 die vorhanden sind 
--AND KJWO IN ( SELECT table1.value FROM TABLE(split_to_table(:P_KJWO, '','')) AS table1 )
--, :P_ESTIMATION_ID
INSERT INTO dbp_data.ts_mengenaenderungen_writeback_1 (mandant_id,
 aktion_id,
 art_id,
 dat_von,
 dat_bis,
 angebot_id,
 dat_beladung,
 menge_ohne_bestand_genehmigt_fg,
 menge_mit_bestand_genehmigt_fg,
 wfl_menge_geprueft_fg,
 estimation_id,
 adjustment_id,
 td_update,
 td_insert)
WITH ART_UPDATE AS (SELECT DISTINCT mandant_id, aktion_id, art_id, dat_von, dat_bis, angebot_id, dat_beladung
            FROM dbp_data.ts_mengenaenderungen_writeback_1
            WHERE mandant_id = P_MANDANT_ID AND art_id IN (SELECT CAST(VALUE AS INTEGER) AS value
                        FROM (SELECT 1 AS seq) AS t10
                            INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND angebot_id IN (SELECT CAST(VALUE AS INTEGER) AS value
                        FROM (SELECT 1 AS seq) AS t13
                            INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND aktion_id IN (SELECT LPAD(VALUE, 10, '0') AS a1453165860
                        FROM (SELECT 1 AS seq) AS t16
                            INNER JOIN UNNEST(SPLIT(P_AKTIONEN, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND dat_beladung = CAST(P_DAT_BELADUNG AS DATE)) (SELECT DISTINCT CAST(mandant_id AS INTEGER) AS mandant_id,
                            aktion_id,
                            CAST(art_id AS INTEGER) AS art_id,
                            dat_ab,
                            dat_bis,
                            CAST(offer_id AS INTEGER) AS offer_id,
                            dat_beladung,
                            P_MENGE_OHNE_BESTAND_GENEHMIGT_FG,
                            P_MENGE_MIT_BESTAND_GENEHMIGT_FG,
                            P_WFL_MENGE_GEPRUEFT_FG,
                            CASE WHEN P_ESTIMATION_ID = COALESCE(estimation_id,0) THEN NULL ELSE P_ESTIMATION_ID END,
                            CASE WHEN P_ADJUSTMENT_ID = COALESCE(adjustment_id,0) THEN NULL ELSE P_ADJUSTMENT_ID END,
                            CURRENT_TIMESTAMP(),
                            CURRENT_TIMESTAMP()
            FROM dbp_view.v_wbs_werbeaenderungen_1
            WHERE mandant_id = P_MANDANT_ID AND art_id IN (SELECT ROUND(CAST(value AS INTEGER), 0) AS value
                        FROM (SELECT t.seq, ORDINALITY + 1 AS index, VALUE AS value
                                FROM (SELECT 1 AS seq) AS t
                                    INNER JOIN UNNEST(SPLIT(P_ART_IDS, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AS t1_1
                        WHERE LENGTH(t1.value) > 1) AND offer_id IN (SELECT ROUND(CAST(VALUE AS INTEGER), 0) AS value
                        FROM (SELECT 1 AS seq) AS t4
                            INNER JOIN UNNEST(SPLIT(P_ANGEBOTE, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND aktion_id IN (SELECT LPAD(VALUE, 10, '0') AS a1453165860
                        FROM (SELECT 1 AS seq) AS t7
                            INNER JOIN UNNEST(SPLIT(P_AKTIONEN, ',')) AS VALUE WITH OFFSET AS ORDINALITY ON TRUE) AND dat_beladung = CAST(P_DAT_BELADUNG AS DATE) AND (mandant_id, aktion_id, art_id, dat_ab, dat_bis, offer_id) NOT IN (SELECT (CAST(mandant_id AS INTEGER), aktion_id, CAST(art_id AS INTEGER), dat_von, dat_bis, CAST(angebot_id AS INTEGER))
                        FROM ART_UPDATE));
COMMIT TRANSACTION;
SET out_param  =  'gefreezt';
SELECT out_param;
RETURN;
END;