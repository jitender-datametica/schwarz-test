create or replace view KFL_PRODUCTION.DBP_ETL.MV_SAL_ARTBEW_WO_SUM(
	KJWO,
	ART_ID,
	WG_ID,
	BEWART_ID,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	EK_MEP_UMSATZ,
	UMSATZ_NETTO,
	VK_MENGE
) as 
SELECT kjwo
      ,art_id
      ,wg_id
      ,bewart_id
      ,mandant_id
      ,wup_id
      ,nb_id
      ,CAST(ek_mep AS FLOAT)
      ,CAST(umsatz_netto AS FLOAT)
      ,CAST(menge AS FLOAT)
FROM dbp_etl.sal_artbew_wg_art_wo_sum
WHERE mandant_id = 1
;