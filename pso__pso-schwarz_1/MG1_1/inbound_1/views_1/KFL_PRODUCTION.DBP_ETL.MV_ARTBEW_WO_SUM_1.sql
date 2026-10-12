create or replace view KFL_PRODUCTION.DBP_ETL.MV_ARTBEW_WO_SUM_1(
	KJWO,
	ART_ID,
	WG_ID,
	BEWART_ID,
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	EK_MEP_UMSATZ,
	UMSATZ_NETTO,
	MENGE
) as (
SELECT kjwo
      ,art_id
      ,wg_id
      ,bewart_id
      ,mandant_id
      ,wup_id
      ,nb_id
      ,CAST(ek_mep AS FLOAT) AS ek_mep_umsatz
      ,CAST(umsatz_netto AS FLOAT) AS umsatz_netto
      ,CAST(menge AS FLOAT) AS menge
FROM dbp_etl.bf_artbew_wg_art_wo_sum_stp_de_1
WHERE mandant_id = 1
);