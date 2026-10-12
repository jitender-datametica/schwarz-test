CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_SUPPLIER_2(
	 nfpo_sup_sid
	,nfpo_sup_nr
	,nfpo_sup_name
	,nfpo_gtin_ownership_cd
	,nfpo_gtin_ownership_descr
	,nfpo_country_sid
	,nfpo_country_cd
	,nfpo_country_name
	,street_name
	,city_name
	,zip
	,eks_sup_nr
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS
(SELECT 
     nfpo_sup_sid
	,nfpo_sup_nr
	,nfpo_sup_name
	,nfpo_gtin_ownership_cd
	,nfpo_gtin_ownership_descr
	,nfpo_country_sid
	,nfpo_country_cd
	,nfpo_country_name
	,street_name
	,city_name
	,zip
	,eks_sup_nr
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_SUPPLIER_2
);
