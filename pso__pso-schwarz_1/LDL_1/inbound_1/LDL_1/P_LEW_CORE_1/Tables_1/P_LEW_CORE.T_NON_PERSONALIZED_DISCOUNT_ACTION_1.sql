create or replace TABLE LDL_PRODUCTION.P_LEW_CORE.T_NON_PERSONALIZED_DISCOUNT_ACTION_1 (
	CLIENT_ID NUMBER(38,0) NOT NULL COMMENT 'unique identifier of the DWH client / slice',
	NP_DISCOUNT_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key of the non personalized discount.',
	NP_DISCOUNT_ACTION_NR NUMBER(38,0) NOT NULL COMMENT 'Unique Identifier of the action for a non-personalized discount.',
	NP_DISCOUNT_ACTION_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'Code of the action type for the non personalized discount.',
	NP_DISCOUNT_BENEFIT_TYPE_CD VARCHAR(100) NOT NULL COMMENT 'Code of the benefit type for the non personalized discount.',
	NP_DISCOUNT_ACTION_ORDER_SEQ NUMBER(38,0) COMMENT 'It determines the non personalized discount action application order (in ascending order starting from 0).',
	NP_DISCOUNT_ACTION_PRIO_SEQ NUMBER(38,0) NOT NULL COMMENT 'It determines the priority of non personalized discount action with identical sequences.',
	RECEIPT_CALC_METHOD_CD VARCHAR(100) NOT NULL COMMENT 'Code of receipt calculation method for a non personalized discount.',
	ITEM_TO_BE_PAID_CNT NUMBER(38,0) COMMENT 'The minimun quantity of  item_1 or item_1 group  to buy to get the discount. e.g: For an action 10+2 gratis, then the quantity of item_1 to buy is 10.( For action_type_cd = ''TO_BE_PAID_QUANTITY'').',
	MAX_ITEM_TO_BE_DISCOUNTED_CNT NUMBER(38,0) COMMENT 'It is the maximum number of items from the assigned product list ( MatchingItems) that are eligible to receive the discount, once the non personalized discount conditions are met..( For action_type_cd = ''MIX_AND_MATCH'').',
	NP_DISCOUNT_TRIGGER_LOGICAL_OPERATOR_CD VARCHAR(100) COMMENT 'Code of  item_1/itemgroup_1 combination type for a non personalized discount.( For action_type_cd = ''MIX_AND_MATCH'').',
	NP_DISCOUNT_METHOD_CD VARCHAR(100) COMMENT 'Code of the calculation method of a non personalized discount for the new price.(For action_type_cd = ''SIMPLE''),',
	DISCOUNT_PCT NUMBER(38,5) COMMENT 'The percentage discount is deducted from the valid retail price of the item.(For action_type_cd = ''SIMPLE'' and discount_method_cd = ''RP'').',
	DISCOUNT_VAL NUMBER(38,5) COMMENT 'Depending on the discount method type, the value is either deducted from the item_1''s current retail price (RS_1) or distributed pro-rata across all line items, ensuring a proportional discount for every position on the receipt(RT).(For action_type_cd = ''SIMPLE'').',
	DISCOUNT_PRICE NUMBER(38,5) COMMENT 'The promotional price, which varies by action type. For SET actions, it is the bundle price. For SIMPLE actions, it represents depending on the discount method type either the new unit_1 price (PS) or the total price of an interval (PT) defined by the minimum quantity.',
	CURR_SID NUMBER(38,0) NOT NULL COMMENT 'Surrogate Key CURRENCY',
	CURR_CD VARCHAR(100) NOT NULL COMMENT 'Iso-Code Wahrung; SAP-Retail: tcurc.isocd; SAP-BW: t_bw_z_ds_tcurc.isocd',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',
	constraint PK_T_NON_PERSONALIZED_DISCOUNT_ACTION primary key (NP_DISCOUNT_SID, NP_DISCOUNT_ACTION_NR)
)COMMENT='This table is about the price adjustment mechanisms associated with a non-personalized discount, which is applied when the trigger condition in a specified defined time period are met.'
;
