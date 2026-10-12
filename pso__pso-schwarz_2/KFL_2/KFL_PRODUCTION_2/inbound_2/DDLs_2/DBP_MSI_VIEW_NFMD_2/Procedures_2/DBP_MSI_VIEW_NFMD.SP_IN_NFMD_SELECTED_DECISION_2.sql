CREATE OR REPLACE PROCEDURE DBP_MSI_VIEW_NFMD.SP_IN_NFMD_SELECTED_DECISION(
    P_MANDANT_ID NUMBER, 
    P_MARKDOWN_DECISION_ID NUMBER, 
    P_USER_ID VARCHAR(255))
RETURNS STRING
LANGUAGE SQL
COMMENT='Selected Markdown Decision'
EXECUTE AS OWNER
AS  $$
BEGIN
-- User Selection abspeichern 
-- Benoetigen kein Merge, da im Frontend bei Aufruf des Berichtes der User aus der Tabelle geloescht wird. 
INSERT INTO DBP_MSI_VIEW_NFMD.TS_NFMD_SELECTED_DECISION_2 (MANDANT_ID, MARKDOWN_DECISION_ID,  USER_ID) 
VALUES (  
    :P_MANDANT_ID,
    :P_MARKDOWN_DECISION_ID,
    :P_USER_ID 
    )
;

COMMIT;
RETURN 'Verwertungsentscheidung ausgewaehlt';
END;
$$
;