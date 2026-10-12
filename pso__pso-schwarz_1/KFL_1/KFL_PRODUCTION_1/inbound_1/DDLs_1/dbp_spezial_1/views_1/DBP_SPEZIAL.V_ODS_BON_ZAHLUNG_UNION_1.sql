create or replace view KFL_PRODUCTION.DBP_SPEZIAL.V_ODS_BON_ZAHLUNG_UNION_1(
	BON_ID,
	BON_ZEILE,
	WUP_ID,
	MANDANT_ID,
	ZAHLUNG_TYP_ID,
	START_BON_ZEILE,
	BETRAG_ZAHLUNG,
	WRG_ID,
	KPOS_ZAHLUNG_TYP_ID,
	BON_DAT,
	BON_ZEILE_CASHBACK_REFERENZ,
	KARTENNUMMER_MASKIERT
) as 
SELECT bon_id
,bon_zeile
,wup_id
,mandant_id
,zahlung_typ_id
,start_bon_zeile
,betrag_zahlung
,wrg_id
,kpos_zahlung_typ_id
,bon_dat
,bon_zeile_cashback_referenz
,kartennummer_maskiert
 FROM dbp_ods.ods_bon_zahlung_1
UNION ALL
SELECT bon_id
,bon_zeile
,wup_id
,mandant_id
,zahlung_typ_id
,start_bon_zeile
,betrag_zahlung
,wrg_id
,kpos_zahlung_typ_id
,bon_dat
,bon_zeile_cashback_referenz
,kartennummer_maskiert
 FROM dbp_ods_archiv.ods_bon_zahlung_1
;
