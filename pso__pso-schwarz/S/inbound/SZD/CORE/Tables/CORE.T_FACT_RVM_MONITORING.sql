CREATE TABLE CORE.T_FACT_RVM_MONITORING (
RVM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
CAL_DT DATE NOT NULL COMMENT 'The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). ',
DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
FILES_EXP_CNT NUMBER(38,0) COMMENT 'The Counter for expected Files',
FILES_MISS_CNT NUMBER(38,0) COMMENT 'The Counter for missing Files',
CONSTRAINT PK_T_FACT_RVM_MONITORING PRIMARY KEY (RVM_SID, CAL_DT)
)COMMENT='Transactional facts capturing preventive maintenance operations of deposit machines.'
;