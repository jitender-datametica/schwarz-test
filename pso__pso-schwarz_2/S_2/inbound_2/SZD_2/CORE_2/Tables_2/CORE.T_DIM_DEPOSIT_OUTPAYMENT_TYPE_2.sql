CREATE TABLE CORE.T_DIM_DEPOSIT_OUTPAYMENT_TYPE_2 (
	DEPOSIT_OUTPAYMENT_TYPE_CD VARCHAR(50) NOT NULL COMMENT 'The code for the way how the deposit amount can be paid back to the customer. (outpayment / donation / QR code / ...',
	DEPOSIT_OUTPAYMENT_TYPE_DESCR VARCHAR(250) NOT NULL COMMENT 'A textual default description for the way how the deposit amount can be paid back to the customer. (outpayment / donation / QR code / ...',
	DEPOSIT_OUTPAYMENT_TYPE_DESCR_EN VARCHAR(250) NOT NULL COMMENT 'A textual description for the way how the deposit amount can be paid back to the customer. (outpayment / donation / QR code / ...',
	DEPOSIT_OUTPAYMENT_TYPE_DESCR_DE VARCHAR(250) NOT NULL COMMENT 'A textual description for the way how the deposit amount can be paid back to the customer. (outpayment / donation / QR code / ...',
	DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
	DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
	CONSTRAINT PK_T_DIM_DEPOSIT_OUTPAYMENT_TYPE PRIMARY KEY (DEPOSIT_OUTPAYMENT_TYPE_CD)
)COMMENT='This minor dimension defines the ways how the deposit amount can be paid back to the customer. (outpayment / donation / QR code / )'
;