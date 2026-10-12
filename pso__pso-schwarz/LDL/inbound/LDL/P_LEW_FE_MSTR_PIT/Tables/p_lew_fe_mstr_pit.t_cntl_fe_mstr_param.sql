/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025 
#-------------------------------------------------------------------------------
# Interface : DDL for P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_PARAM
#-------------------------------------------------------------------------------
# Description: Create DDL for frontend MSTR parameter control table,
#              i.e. contains attribute IDs, HTML tags to build the URLs for report drilling links.
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz     Initial version
#  1.1  2021-08-30 Mike Davis       Checks, formatting
#  1.2  2021-09-16 Massimo Morelli  Fixed SCHEMA
#  1.3  2022-01-24 Andreas Kurz     Reworked the structure after DM review
#  1.4  2022-07-13 Dirk Hering      Added schema prefix P_LEW_FE_MSTR_PIT, comments, changing the script for DevOps
#  2.0	2022-07-14 Nikolai Toknov  Changing the script for DevOps
#-------------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_PARAM (

    FE_MSTR_PARAM_ID      INTEGER                   IDENTITY(1,1)                                     COMMENT 'Surrogate Key. IDENTTY COLUMN (1,1)',
    FE_MSTR_PARAM_NAME    VARCHAR                                                                     COMMENT 'Frontend Param Name',
    FE_MSTR_PARAM_VALUE   VARCHAR(2500)                                                               COMMENT 'Frontend Param Value e.g. HTTP CSS Strings',
                                                                                                              
    -- Versioning                                                                                             
    VALID_FROM_DT         DATE            NOT NULL  DEFAULT TO_DATE('1900-01-01','YYYY-MM-DD')        COMMENT 'Technical field Data Historization Valid from ',
    VALID_TO_DT           DATE            NOT NULL  DEFAULT TO_DATE('9999-12-31','YYYY-MM-DD')        COMMENT 'Technical field Data Historization Valid to',
    VERSION_NR            INTEGER         NOT NULL  DEFAULT 0                                         COMMENT 'Technical Field: Version Number of record; Sequence starting from 0',
    CURRENT_FG            SMALLINT        NOT NULL  DEFAULT 1                                         COMMENT 'Technical Field Flag::=1 indicates the current record in case of several version',
                                                                                                              
    -- Technical fields                                                                                       
    REJECT_FG             SMALLINT        NOT NULL  DEFAULT 0                                         COMMENT 'Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues',
    REJECT_REASON_ID      INTEGER         NOT NULL  DEFAULT -1                                        COMMENT 'Link to DQ Reject Reason Codes',
    SOURCE_SYSTEM_ID      INTEGER         NOT NULL  DEFAULT 0                                         COMMENT 'Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP',
    DELETED_FG            SMALLINT        NOT NULL  DEFAULT 0                                         COMMENT 'Logical Deleted Flag; indicates if the record was logically deleted',
    DWH_CREATED_TS        TIMESTAMP       NOT NULL  DEFAULT CURRENT_TIMESTAMP()                       COMMENT 'Timestamp when record was created',
    DWH_UPDATED_TS        TIMESTAMP                                                                   COMMENT 'Technical field timestamp when record was updated',
    LOAD_ID               INTEGER         NOT NULL  DEFAULT 0                                         COMMENT 'Technical Field ELT / ABInitio Process ID',

    PRIMARY KEY (FE_MSTR_PARAM_ID, VALID_FROM_DT, DELETED_FG)   
)   COMMENT='Frontend MSTR parameter control table, i.e. contains attribute IDs, HTML tags to build the URLs for report drilling links.'
;