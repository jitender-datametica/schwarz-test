create or replace view DBP_DATA_CENTER.TV_ARTBEW_WO_SUM_1(
	MANDANT_ID,
	ART_ID,
	WUP_ID,
	KJWO,
	MENGE1,
	UMSATZ_NETTO1
) as
SELECT mandant_id
      ,kl_art_id
      ,wup_id
      ,kjwo
      ,absatz as menge1
      ,umsatz_netto as umsatz_netto1
FROM dbp_data_center.wasa_artbew_woche_1;