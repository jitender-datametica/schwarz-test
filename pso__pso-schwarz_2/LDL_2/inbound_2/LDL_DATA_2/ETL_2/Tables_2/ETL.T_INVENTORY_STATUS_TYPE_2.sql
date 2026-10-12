CREATE TABLE ETL.T_INVENTORY_STATUS_TYPE_2 (
	INV_STATUS_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the lifecycle status_2 for inventory events.',
	LANG_CD VARCHAR(2) NOT NULL COMMENT 'The code identifying the language.',
	INV_STATUS_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual description for the lifecycle status_2 for inventory events.'
)COMMENT='This minor entity defines the lifecycle statuses for inventory events. E.g. an inventory may be in progress, ready for booking or booked.'
;