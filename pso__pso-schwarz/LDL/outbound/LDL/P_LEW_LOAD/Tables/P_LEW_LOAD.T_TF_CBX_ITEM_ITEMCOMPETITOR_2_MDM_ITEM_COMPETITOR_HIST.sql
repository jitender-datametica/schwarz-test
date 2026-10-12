CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_cbx_item_itemcompetitor_2_mdm_item_competitor_hist (
client_id BIGNUMERIC(38),
lidl_country STRING(40) NOT NULL,
cbx_item_itemcompetitor_cbxitem_documentref STRING(250),
cbx_item_itemcompetitor_cbxitem_competitor_code STRING(250),
cbx_item_itemcompetitor_cbxitem_competitor_competitorseq STRING(250),
src_item_doc_ref STRING(40),
src_competitor_cd STRING(40),
competitor_nr BIGNUMERIC(38),
sale_price NUMERIC(18,5),
sell_from_dt DATE,
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);