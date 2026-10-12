CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_in_nfmd_proposed_decision_comments(IN P_KJWO_WW INT64, IN P_MANDANT_ID INT64, IN P_AKTION_ID STRING, IN P_ART_ID FLOAT64, IN P_USER_ID STRING, IN P_MARKDOWN_DECISION_ID INT64, IN P_MARKDOWN_DECISION_ID_AKT INT64, IN P_COMMENT_TEXT STRING, IN P_COMMENT_TEXT_AKT STRING, OUT out_param STRING)
BEGIN
DECLARE var_massenbearbeitung_decision_id INT64;
BEGIN
BEGIN TRANSACTION;
SET var_massenbearbeitung_decision_id  =  (SELECT MIN(markdown_decision_id)
FROM dbp_msi_view_nfmd.ts_nfmd_selected_decision
WHERE user_id = P_USER_ID);

IF P_MARKDOWN_DECISION_ID <> P_MARKDOWN_DECISION_ID_AKT THEN
    BEGIN
    --Decision Insert
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_proposed_decision (mandant_id, aktion_id, art_id, kjwo_ww, dwh_created_tmsp, user_id, markdown_decision_id)
(SELECT P_MANDANT_ID  AS mandant_id, P_AKTION_ID AS aktion_id, CAST(P_ART_ID AS INT64)  AS art_id, P_KJWO_WW  AS kjwo_ww, CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created_tmsp, 'Dummy' AS user_id, P_MARKDOWN_DECISION_ID  AS markdown_decision_id);
    END;
ELSEIF P_MARKDOWN_DECISION_ID = P_MARKDOWN_DECISION_ID_AKT AND var_massenbearbeitung_decision_id IS NOT NULL THEN
    INSERT INTO dbp_msi_view_nfmd.ts_nfmd_proposed_decision (mandant_id, aktion_id, art_id, kjwo_ww, dwh_created_tmsp, user_id, markdown_decision_id)
(SELECT P_MANDANT_ID  AS mandant_id, P_AKTION_ID AS aktion_id, CAST(P_ART_ID AS INT64)  AS art_id, P_KJWO_WW  AS kjwo_ww, CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created_tmsp, 'Dummy' AS user_id, var_massenbearbeitung_decision_id AS markdown_decision_id);
END IF;

-- Nur Kommentar speichern, wenn dieser geaendert wurden ist 

IF P_COMMENT_TEXT <> P_COMMENT_TEXT_AKT THEN
    BEGIN
    --AND target.aktion_id = source.aktion_id
    MERGE INTO dbp_msi_view_nfmd.ts_nfmd_comments AS TARGET
USING (SELECT P_MANDANT_ID AS mandant_id, P_AKTION_ID AS aktion_id, CAST(P_ART_ID AS INT64) AS art_id, P_KJWO_WW AS kjwo_ww, P_COMMENT_TEXT AS comment_txt, 'Dummy' AS user_id) AS source
ON TARGET.mandant_id = source.mandant_id AND TARGET.art_id = source.art_id AND TARGET.kjwo_ww = source.kjwo_ww
WHEN MATCHED THEN UPDATE SET
    comment_txt = source.comment_txt,
    dwh_created_tmsp = CAST(CURRENT_TIMESTAMP() AS DATETIME),
    user_id = source.user_id
WHEN NOT MATCHED THEN INSERT (mandant_id, aktion_id, art_id, kjwo_ww, user_id, comment_txt, dwh_created_tmsp) VALUES(source.mandant_id , source.aktion_id, source.art_id , source.kjwo_ww , source.user_id, source.comment_txt, CAST(CURRENT_TIMESTAMP() AS DATETIME));
    END;
END IF;

COMMIT TRANSACTION;
SET out_param  =  'Verwertungsentscheidung gespeichert';
SELECT out_param;
RETURN;
END;
END;
