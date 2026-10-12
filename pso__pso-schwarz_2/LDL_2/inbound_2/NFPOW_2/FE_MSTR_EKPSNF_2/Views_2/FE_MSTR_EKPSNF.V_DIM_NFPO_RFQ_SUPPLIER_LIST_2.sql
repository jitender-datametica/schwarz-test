CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_RFQ_SUPPLIER_LIST_2(
	 nfpo_rfq_sup_list_txt
	,nfpo_rfq_sup_name_list_txt
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS
(SELECT 
	 nfpo_rfq_sup_list_txt
	,nfpo_rfq_sup_name_list_txt
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_RFQ_SUPPLIER_LIST_2
);