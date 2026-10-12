create or replace TABLE BIAID_TOOLS_PROJECTS_PRODUCTION.FE_MSTR_TIMESHEETS.T_DIM_PSP_ELEMENT (
	PSP_ELEMENT_CD VARCHAR(50) NOT NULL COMMENT 'Unique code of the PSP elemenent',
	PSP_ELEMENT_SHORT_NAME VARCHAR(200) COMMENT 'Name of the PSP Element',
	PSP_ELEMENT_LONG_NAME VARCHAR(300) COMMENT 'Display name of the PSP Element as shown in IT4YOY (name + \"[KFL-INT]\"/''[LDL-INT]'' ... )',
	PSP_ELEMENT_STATUS_NAME VARCHAR(20) COMMENT 'Status of the PSP Element ( ex Active, Retired, Work in Progress)',
	SOLUTION_TYPE_NAME VARCHAR(20) COMMENT 'Type indicating if this is \"IT-Solution\" or \"Business Solution\"',
	SOLUTION_EXPERT_FULL_NAME VARCHAR(100) COMMENT 'Full Name (First + Last name ) of the Solution Expert of this PSP element',
	SOLUTION_OWNER_FULL_NAME VARCHAR(100) COMMENT 'Full Name (First + Last name ) of the Solution Owner of this PSP element',
	PSP_OPERATIONS_NR VARCHAR(20) COMMENT 'Number associated with all operations related to this PSP element',
	PSP_REQUIREMENTS_NR VARCHAR(20) COMMENT 'Number associated with all requirements related to this PSP element',
	constraint PK_T_DIM_PSP_ELEMENT primary key (PSP_ELEMENT_CD)
)COMMENT='Dimension that contains unique PSP emenents and their descriptions'
;