CREATE TABLE META.T_PARTY_KEY (
   PARTY_SID                           NUMBER           NOT NULL COMMENT 'The unique identifier (surrogate key) for the Party.',
   PARTY_TYPE_CD                       VARCHAR(100)     NOT NULL COMMENT 'The code for the type of natural key which identifies the Party.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL DEFAULT CAST('1900-01-01 00:00:00' AS TIMESTAMP_LTZ(9)) COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL DEFAULT CAST('9999-12-31 23:59:59' AS TIMESTAMP_LTZ(9)) COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN          NOT NULL DEFAULT TRUE COMMENT 'An indicator showing the current record in history.',
   NAT_KEY_COMP_1_NR                   VARCHAR(100)     NOT NULL DEFAULT '@' COMMENT 'The natural key which identifies the Party.In case the natural key consist of several columns, all components get concatenated.',
   NAT_KEY_COMP_2_NR                   VARCHAR(100)     NOT NULL DEFAULT '@' COMMENT 'The natural key which identifies the Party.In case the natural key consist of several columns, all components get concatenated.',
   NAT_KEY_COMP_3_NR                   VARCHAR(100)     NOT NULL DEFAULT '@' COMMENT 'The natural key which identifies the Party.In case the natural key consist of several columns, all components get concatenated.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'The point in time when this record was created or last updated.',   
  CONSTRAINT PK_T_PARTY_KEY PRIMARY KEY (PARTY_TYPE_CD, DWH_VALID_FROM_TMSP, NAT_KEY_COMP_1_NR, NAT_KEY_COMP_2_NR, NAT_KEY_COMP_3_NR) NOT ENFORCED 
)  COMMENT = 'Key table for the Party key space. A surrogate key is identified by one or several natural keys. The kind of natural key is defined by the key type code. In case the natural key consists of several columns, all components get concatenated using a separator character. The association between a natural key and its surrogate key can change over time, e.g. because of a re-numbering in the source. That is why the key table is historized.';
