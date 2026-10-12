CREATE TABLE DBP_MSI_VIEW_NFMD.TS_NFMD_SELECTED_DECISION (
    MANDANT_ID INTEGER NOT NULL COMMENT 'Mandant im DWH',
    MARKDOWN_DECISION_ID INTEGER NOT NULL COMMENT 'Unique identifier of price reduction (markdown) decision',
    USER_ID VARCHAR(255) NOT NULL COMMENT 'AD name of the user who created the record'
)COMMENT='When user selects a decision in the fronted for Massenbarbeitung - JF Verwertung, the decision_id is inserted here.';
