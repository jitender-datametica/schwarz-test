create or replace TABLE SZD_PRODUCTION.CORE_REL.T_IT_RESOURCE_2 (
	RESOURCE_ITEM_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the resource item. as an IT ressource. Key generation based on META table for party key space.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
	IT_RESOURCE_TYPE_ID NUMBER(38,0) NOT NULL COMMENT 'Natural/Business Key - The unique code identifying the discriminators for task configuration item_2 groups (CI group) in IT4You.',
	OWNER_COUNTRY_BUSINESS_LOCATION_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the location_2 for SCHWARZ business country_2 of the it resource owner. Key generation based on META table for party key space.',
	OWNER_DIVISION_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party. It defines the division of it resource owner. Key generation based on META table for party key space.',
	OWNER_ORG_UNIT_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party. IT defines owner org unit. Key generation based on META table for party key space.',
	NON_SIT_OWNER_LVL2_ORG_UNIT_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party. IT defines the Org Level 2 org unit_2 for NON SIT owner -Temporary solution for non SIT.Key generation based on META table for party key space.\n            It is a mandatory manually maintained  field and  denormalized column in the source.Once there is a regular solution then it can be migrated to owner_org_unit_party_sid. ',
	NON_SIT_OWNER_LVL3_ORG_UNIT_PARTY_SID NUMBER(38,0) COMMENT 'The unique identifier (surrogate key) for the party. IT defines the Org Level 3 org unit_2 for NON SIT owner - Temporary solution for non SIT.Key generation based on META table for party key space.\n            It is a non mandatory manually maintained field and denormalized column in the source.Once there is a regular solution then it can be migrated to owner_org_unit_party_sid. ',
	SOLUTION_BUSINESS_UNIT_PARTY_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a business unit. It defines the business unit_2 of the solution.',
	LOCALIZATION_ID NUMBER(38,0) COMMENT 'Natural Key/Business Key - code identifying the discriminators for localization',
	IT_RESOURCE_NR VARCHAR(250) NOT NULL COMMENT 'Natural/Business Key -  number of CI group (z.B. ITS0012345, BS0012345, APP0001234)',
	IT_RESOURCE_PSP_NR VARCHAR(250) NOT NULL COMMENT 'Natural/Business Key - PSP Element number',
	IT_RESOURCE_NAME VARCHAR(500) NOT NULL COMMENT 'Descriptive Attribute - name of CI group. CI as configuration item_2 is source system term for e.g. applications, databases, solutions & other objects ',
	SOURCE_SYS_NR VARCHAR(100) NOT NULL COMMENT 'Source system payload attribute - Technical Surrogate Key (surves as Natural Key) - additional technical system id for identification of tickets.',
	SOURCE_UPDATED_ON_TMSP TIMESTAMP_TZ(9) COMMENT 'Source system payload attribute - The point in time when this record was last modified in the source system. (In case the record has not been modified since its creation, source_updated_on is identical to creation timestamp)',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	DWH_SRC_FILE_NAME VARCHAR(500) COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
	DWH_SRC_1_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',
	constraint PK_IT_RESOURCE primary key (RESOURCE_ITEM_SID, DWH_VALID_FROM_TMSP)
)COMMENT='Major Entity - This subtype holds information on all IT resources like network, software, hardware and other resources. Source - IT4You Service Now for Solution ITPM'
;