CREATE TABLE CORE.T_DIM_LINE_OF_BUSINESS (
	LOB_CD VARCHAR(50) NOT NULL COMMENT 'The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland
lob=line os business',
	LOB_NAME VARCHAR(100) NOT NULL COMMENT 'The name for the line of business within the Schwarz Group, i.e.Lidl or Kaufland
lob=line os business',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_LINE_OF_BUSINESS PRIMARY KEY (LOB_CD)
)COMMENT='Lines of business within the Schwarz Group, i.e. Lidl and Kaufland'
;