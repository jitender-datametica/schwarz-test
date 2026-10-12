CREATE TABLE CORE.T_ORACLE_V_DIM_ITEM_STATUS_1 (
	COUNTRY_1 VARCHAR(2) NOT NULL COMMENT 'Country_1; sourcefield: country_1',
	DIS_WH NUMBER(38,0) NOT NULL COMMENT 'Number of a Warehouse; sourcefield: dis_wh',
	DIS_ITEM_NR VARCHAR(20) NOT NULL COMMENT 'Global item_1 number, dis_item_nr is equal to other xx_item_nr from other tables; sourcefield: dis_item_nr.',
	DIS_PACKAGECAPACITY NUMBER(38,0) NOT NULL COMMENT 'Amount of salesitems that can be placed in one case. Sourcefield: DIS_PACKAGECAPACITY',
	DIS_STATUS NUMBER(38,0) NOT NULL COMMENT 'Status_1 of an item_1 in system NIS. Status_1 = 5 or 6 item_1 ordered from warehouse; status_1=7 item_1 ordered from warehouse but locked for store delivery; status_1=8 item_1 ordered from warehouse and available for store delivery. Sourcefield DIS_STATUS',
	DIS_STATUS_DATE NUMBER(38,0) NOT NULL COMMENT 'Date when the status_1 for a warehouse item_1 combination got changed. Sourcefield: DIS_STATUS_DATE',
	ACTIVE_FG NUMBER(38,0) NOT NULL COMMENT 'Status_1 of the combination of dis_item_nr, dis_status and dis_packagecapacity in ADF system. Can differ on that level when an item_1 has promotion- Then another status_1 or packagecapacity is valid. Active=1 inactive=0; sourcefield: DIS_ACTIVE',
	MOD_DATE TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of altering entries inside the table, is usually null. Sourcefield; mod_date',
	SOURCE_EXTRACTION_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time Combination of the extraction from the source. Added in the Snowflake loading process.',
	DWH_VALID_FROM_TMSP TIMESTAMP_LTZ(9) NOT NULL  COMMENT 'Start date from when a dis_item_nr with a specific dis_status is valid; created in loading process (timestamp of the mod_date when information got changed in source).',
	DWH_VALID_TO_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'End date from when a dis_item_nr with a specific dis_status is valid; created in loading process (timestamp of the mod_date when status_1 got changed in source).',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time combination added in the Snowflake loading process.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Date/Time combination added in the Snowflake table update process.',
	CONSTRAINT PK_T_ORACLE_V_DIM_ITEM_STATUS_TMP PRIMARY KEY (COUNTRY_1, DIS_WH, DIS_ITEM_NR, DIS_PACKAGECAPACITY, DWH_VALID_TO_TMSP)
)COMMENT='The table shows the status_1 of an item_1 assigned to a specific warehouse in ADF system. Combination of item_1, item_1 status_1 and item_1 packagecapacity can be active or inactive wether an item_1 is in promotion or regular assortment.Source: Parin/Parin1 table DIM_ITEM_STATUS.'
;