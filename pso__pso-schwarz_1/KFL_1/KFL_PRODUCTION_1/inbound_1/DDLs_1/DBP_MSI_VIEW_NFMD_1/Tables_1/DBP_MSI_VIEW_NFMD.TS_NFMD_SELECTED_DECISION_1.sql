CREATE TABLE DBP_MSI_VIEW_NFMD.TS_NFMD_SELECTED_DECISION_1 (
    MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
    MARKDOWN_DECISION_ID NUMBER(38,0) NOT NULL COMMENT 'Unique identifier of price reduction (markdown) decision',
    USER_ID VARCHAR(255) NOT NULL COMMENT 'AD name of the user who created the record'
)COMMENT='When user selects a decision in the fronted for Massenbarbeitung - JF Verwertung, the decision_id is inserted here.';
