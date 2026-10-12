create or replace view KFL_PRODUCTION.DBP_SPEZIAL.V_ODS_BON_VERKAUF_UNION_2(
	BON_ID,
	BON_ZEILE,
	KL_ART_ID,
	EAN_KASSE,
	WG_ID,
	MENGE,
	EINH_ID,
	UMSATZ_BRUTTO,
	MWST_ID,
	ERFASSUNG_ID,
	AKTION_ID,
	MANDANT_ID,
	WUP_ID,
	TALON_ID,
	START_BON_ZEILE,
	BON_NR_EXTERN,
	KPOS_ERFASSUNG_ID,
	UMSATZ_BRUTTO_NORM,
	VK_BRUTTO_OBB,
	BON_VORGANG_ID,
	BARCODE_STRING,
	BON_DAT
) as 
SELECT bon_id
,bon_zeile
,kl_art_id
,ean_kasse
,wg_id
,menge
,einh_id
,umsatz_brutto
,mwst_id
,erfassung_id
,aktion_id
,mandant_id
,wup_id
,talon_id
,start_bon_zeile
,bon_nr_extern
,kpos_erfassung_id
,umsatz_brutto_norm
,vk_brutto_obb
,bon_vorgang_id
,barcode_string
,bon_dat
 FROM dbp_ods.ods_bon_verkauf_2
UNION ALL
SELECT bon_id
,bon_zeile
,kl_art_id
,ean_kasse
,wg_id
,menge
,einh_id
,umsatz_brutto
,mwst_id
,erfassung_id
,aktion_id
,mandant_id
,wup_id
,talon_id
,start_bon_zeile
,bon_nr_extern
,kpos_erfassung_id
,umsatz_brutto_norm
,vk_brutto_obb
,bon_vorgang_id
,barcode_string
,bon_dat
 FROM dbp_ods_archiv.ods_bon_verkauf_2;