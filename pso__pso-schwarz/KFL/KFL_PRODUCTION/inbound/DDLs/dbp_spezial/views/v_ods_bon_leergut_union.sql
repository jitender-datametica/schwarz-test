create or replace view KFL_PRODUCTION.DBP_SPEZIAL.V_ODS_BON_LEERGUT_UNION(
	BON_ID,
	BON_ZEILE,
	EAN_KASSE,
	UMSATZ_BRUTTO,
	MANDANT_ID,
	WUP_ID,
	START_BON_ZEILE,
	BON_NR_EXTERN,
	BON_DAT
) as 
SELECT bon_id
,bon_zeile
,ean_kasse
,umsatz_brutto
,mandant_id
,wup_id
,start_bon_zeile
,bon_nr_extern
,bon_dat
 FROM dbp_ods.ods_bon_leergut
UNION ALL
SELECT bon_id
,bon_zeile
,ean_kasse
,umsatz_brutto
,mandant_id
,wup_id
,start_bon_zeile
,bon_nr_extern
,bon_dat
 FROM dbp_ods_archiv.ods_bon_leergut;