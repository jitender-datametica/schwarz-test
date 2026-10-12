create or replace view KFL_PRODUCTION.DBP_SPEZIAL.V_ODS_BON_FINANCIAL_UNION_2(
	BON_ID,
	BON_ZEILE,
	MANDANT_ID,
	UMSATZ_BRUTTO,
	FINANCIAL_GRUND_ID,
	FINANCIAL_KOMMENTAR,
	AUSZAHLUNG_FG,
	WUP_ID,
	START_BON_ZEILE,
	BON_DAT
) as 
SELECT bon_id
,bon_zeile
,mandant_id
,umsatz_brutto
,financial_grund_id
,financial_kommentar
,auszahlung_fg
,wup_id
,start_bon_zeile
,bon_dat
 FROM dbp_ods.ods_bon_financial_2
UNION ALL
SELECT bon_id
,bon_zeile
,mandant_id
,umsatz_brutto
,financial_grund_id
,financial_kommentar
,auszahlung_fg
,wup_id
,start_bon_zeile
,bon_dat
 FROM dbp_ods_archiv.ods_bon_financial_2
;
