CREATE TABLE ETL_PROCESS.T_WAWI_ITEM_VARIANT_DELETED_DT_1 (
    wawi_item_variant_sid       NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier (surrogate key) of the Wawi item.',
    ctrcode             VARCHAR(2)       NOT NULL COMMENT 'Wawi country_1 code. Canary islands (CS) is converted to Spain (ES).',
    orig_item_nr        NUMBER(38,0)     NOT NULL COMMENT 'Wawi short item_1 number, sourced from ARTIKEL.ARTNRVIER.',
    src_case_size       NUMBER(38,0) NOT NULL  COMMENT 'Wawi case size',
    dwh_valid_from_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the first appearance of the Wawi item_1, sourced from ARTIKEL.GUELTIG_AB.',
    dwh_valid_to_tmsp   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Closure timestamp, set when a new Wawi item_1 with matching number is defined.',
    deleted_dt          DATE                      COMMENT 'Date of deletion of the WAWI item_1, according to T920_DELITEMS. Null if the Wawi item_1 is still existing in Wawi.',
    dwh_created_tmsp    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
	dwh_updated_tmsp    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
	dwh_load_id         NUMBER(38,0)     NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
	dwh_node_cd         VARCHAR(20)      NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.'
);