create or replace view SMP_PRODUCTION.FE_MSTR_SMP.V_DOOH_CAMPAIGN_RECEIPT_CNT(
	DIVISION_ID,
	COUNTRY_ID,
	CAMPAIGN_ID,
	GTIN_ID,
	RECEIPT_CNT,
	RECEIPT_SHOPPER_CNT
) as 
SELECT 
   division_id
  ,country_id
  ,campaign_id
  ,gtin_id
  ,receipt_cnt
  ,receipt_shopper_cnt
FROM CORE.T_DOOH_CAMPAIGN_RECEIPT_CNT
;
