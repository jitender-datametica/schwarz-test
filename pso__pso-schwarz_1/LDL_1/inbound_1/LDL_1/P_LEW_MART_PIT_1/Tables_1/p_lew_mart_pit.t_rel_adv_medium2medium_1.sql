/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for REL_ADV_MEDIUM2MEDIUM
#-------------------------------------------------------------------------------
# Description: Create DDL for pseudo dimension holding static medium to main medium mappings.
#              It maps all media found in ADP having a similar name to one main medium (to the one with the min. MEDIUM_SID).
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-09-10 Dirk Hering      Initial version
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
MEDIUM_MSTR_SID
MAIN_MEDIUM_MSTR_SID


*/

CREATE TABLE P_LEW_MART_PIT.T_REL_ADV_MEDIUM2MEDIUM_1 CLUSTER BY (CLIENT_ID)(
    CLIENT_ID               INTEGER         NOT NULL    DEFAULT -1                                              COMMENT 'Client ID e.g. 1=>AT',
    
    MEDIUM_SID              INTEGER         NOT NULL    DEFAULT -1                                              COMMENT 'Unique system ID, sid, for the medium (ADP Channel SID).',

	MEDIUM_NAME				VARCHAR			NOT NULL	DEFAULT 'Sonstige' 							            COMMENT '(short) medium name in local language: first version to be found in ADP, case insensitive (trimmed) - the one displayed',
    MEDIUM_REJECT_FG        SMALLINT        NOT NULL    DEFAULT 0                                               COMMENT 'For the medium: Flag indicates if the record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
    MEDIUM_REJECT_REASON_ID INTEGER         NOT NULL    DEFAULT -1                                              COMMENT 'For the medium: Link to DQ Reject Reason Codes',
    
    MAIN_MEDIUM_SID         INTEGER         NOT NULL    DEFAULT -1                                              COMMENT 'Unique system ID, sid, for the main medium (ADP Channel SID).',
 
    -- Versioning
    VALID_FROM_DT           DATE            NOT NULL    DEFAULT TO_DATE('1900-01-01', 'YYYY-MM_1-DD')             COMMENT 'Technical field Data Historization Valid from ',
    VALID_TO_DT             DATE            NOT NULL    DEFAULT TO_DATE('9999-12-31', 'YYYY-MM_1-DD')             COMMENT 'Technical field Data Historization Valid to',
    VERSION_NR              INTEGER         NOT NULL    DEFAULT 0                                               COMMENT 'Technical Field: Version           NUMBER of record ; Sequence starting from 0',
    CURRENT_FG              SMALLINT        NOT NULL    DEFAULT 1                                               COMMENT 'Technical Field 1 indicates the current record in case of several version',
    
    -- TECHNICAL FIELDS 
    REJECT_FG               SMALLINT        NOT NULL    DEFAULT 0                                               COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
    REJECT_REASON_ID        INTEGER         NOT NULL    DEFAULT -1                                              COMMENT 'Link to DQ Reject Reason Codes',
    SOURCE_SYSTEM_ID        INTEGER         NOT NULL    DEFAULT -1                                              COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
    DELETED_FG              SMALLINT        NOT NULL    DEFAULT 0                                               COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
    DWH_CREATED_TS          TIMESTAMP       NOT NULL    DEFAULT CURRENT_TIMESTAMP()                             COMMENT 'Timestamp when record was created',
    DWH_UPDATED_TS          TIMESTAMP                                                                           COMMENT 'Technical field timestamp when record was updated',
    LOAD_ID                 INTEGER         NOT NULL    DEFAULT 0                                               COMMENT 'Technical Field ELT / ABInitio Process ID',
    PRIMARY KEY (CLIENT_ID, MEDIUM_SID, MAIN_MEDIUM_SID, VALID_FROM_DT, DELETED_FG)
)   
COMMENT='Intially loaded with Medium Static Data and then added with new Media from ADP by daily load'
;
