CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_NFPO_PREVIOUS_ITEM(
	 nfpo_item_sid
	,nfpo_prev_item_lvl_nr
	,nfpo_prev_item_sid
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS 
(SELECT 
     nfpo_item_sid
	,nfpo_prev_item_lvl_nr
	,nfpo_prev_item_sid
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
FROM CORE_REL.T_NFPO_PREVIOUS_ITEM
);