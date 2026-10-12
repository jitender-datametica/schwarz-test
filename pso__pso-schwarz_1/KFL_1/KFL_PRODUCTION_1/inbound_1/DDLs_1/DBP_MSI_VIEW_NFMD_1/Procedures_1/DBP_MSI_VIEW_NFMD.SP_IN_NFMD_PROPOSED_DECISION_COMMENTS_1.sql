CREATE OR REPLACE PROCEDURE DBP_MSI_VIEW_NFMD.SP_IN_NFMD_PROPOSED_DECISION_COMMENTS(
    P_KJWO_WW NUMBER,
    P_MANDANT_ID NUMBER,
    P_AKTION_ID VARCHAR(255), 
    P_ART_ID FLOAT, 
    P_USER_ID VARCHAR(255), 
    P_MARKDOWN_DECISION_ID NUMBER, 
    P_MARKDOWN_DECISION_ID_AKT NUMBER,
    P_COMMENT_TEXT VARCHAR(255),
    P_COMMENT_TEXT_AKT VARCHAR(255))
RETURNS STRING
LANGUAGE SQL
COMMENT='Verwertungsentscheidung speichern/abaendern'
EXECUTE AS OWNER
AS $$
DECLARE
    var_massenbearbeitung_decision_id NUMBER(3,0);

BEGIN

SELECT MIN(markdown_decision_id) INTO :var_massenbearbeitung_decision_id FROM DBP_MSI_VIEW_NFMD.TS_NFMD_SELECTED_DECISION_1 
    WHERE user_id = :P_USER_ID ; 

IF (:P_MARKDOWN_DECISION_ID != :P_MARKDOWN_DECISION_ID_AKT ) THEN 
--Decision Insert
INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_PROPOSED_DECISION_1(MANDANT_ID, 
                                                        AKTION_ID, 
                                                        ART_ID, 
                                                        KJWO_WW,
                                                        DWH_CREATED_TMSP,
                                                        USER_ID,
                                                        MARKDOWN_DECISION_ID)
VALUES (:P_MANDANT_ID, :P_AKTION_ID, :P_ART_ID, :P_KJWO_WW, CURRENT_TIMESTAMP::TIMESTAMP_NTZ, 'Dummy_1',:P_MARKDOWN_DECISION_ID)
;
ELSEIF  (:P_MARKDOWN_DECISION_ID = :P_MARKDOWN_DECISION_ID_AKT AND :var_massenbearbeitung_decision_id IS NOT NULL ) THEN 

INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_PROPOSED_DECISION_1(MANDANT_ID, 
                                                        AKTION_ID, 
                                                        ART_ID, 
                                                        KJWO_WW,
                                                        DWH_CREATED_TMSP,
                                                        USER_ID,
                                                        MARKDOWN_DECISION_ID)
VALUES (
    :P_MANDANT_ID, :P_AKTION_ID, :P_ART_ID, :P_KJWO_WW, CURRENT_TIMESTAMP::TIMESTAMP_NTZ, 'Dummy_1',:var_massenbearbeitung_decision_id
    )
;
END IF;

-- Nur Kommentar speichern, wenn dieser geaendert wurden ist 

IF (:P_COMMENT_TEXT != :P_COMMENT_TEXT_AKT) THEN
MERGE INTO DBP_MSI_VIEW_NFMD.TS_NFMD_COMMENTS_1  target
USING ( SELECT 
        :P_MANDANT_ID AS MANDANT_ID,
        :P_AKTION_ID AS AKTION_ID, 
        :P_ART_ID AS ART_ID, 
        :P_KJWO_WW AS KJWO_WW,
        :P_COMMENT_TEXT AS COMMENT_TXT,
        'Dummy_1' AS USER_ID
    ) source 
ON target.mandant_id = source.mandant_id
    --AND target.aktion_id = source.aktion_id
    AND target.art_id = source.art_id
    AND target.kjwo_ww = source.kjwo_ww
 
WHEN MATCHED THEN
    UPDATE
        SET target.COMMENT_TXT = source.COMMENT_TXT,
        target.DWH_CREATED_TMSP =CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
        target.user_id = source.user_id
WHEN NOT MATCHED THEN
    INSERT (MANDANT_ID,
            AKTION_ID, 
            ART_ID, 
            KJWO_WW,
            DWH_CREATED_TMSP, 
            USER_ID, 
            COMMENT_TXT )
    VALUES (source.mandant_id,
            source.aktion_id,
            source.art_id,
            source.kjwo_ww,
            CURRENT_TIMESTAMP::TIMESTAMP_NTZ,
            source.user_id,
            source.COMMENT_TXT
            )
;
END IF;

COMMIT;
RETURN 'Verwertungsentscheidung gespeichert';
END;

$$;