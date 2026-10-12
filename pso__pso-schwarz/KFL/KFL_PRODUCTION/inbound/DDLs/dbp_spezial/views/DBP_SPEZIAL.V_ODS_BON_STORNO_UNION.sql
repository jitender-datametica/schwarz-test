create or replace view KFL_PRODUCTION.DBP_SPEZIAL.V_ODS_BON_STORNO_UNION(
	BON_ID,
	BON_DAT,
	MANDANT_ID,
	WUP_ID,
	BON_NR,
	KASSE_NR,
	DATEI_NAME
) as 
SELECT bon_id
,bon_dat
,mandant_id
,wup_id
,bon_nr
,kasse_nr
,datei_name
 FROM dbp_ods.ods_bon_storno
UNION ALL
SELECT bon_id
,bon_dat
,mandant_id
,wup_id
,bon_nr
,kasse_nr
,datei_name
 FROM dbp_ods_archiv.ods_bon_storno
;
