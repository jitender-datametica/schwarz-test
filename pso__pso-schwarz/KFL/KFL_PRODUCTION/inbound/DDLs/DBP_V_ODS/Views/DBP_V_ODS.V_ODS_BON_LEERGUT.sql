create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_V_ODS.V_ODS_BON_LEERGUT(
	BON_ID,
	BON_ZEILE,
	MANDANT_ID,
	WUP_ID,
	BON_DAT,
	EAN_KASSE,
	UMSATZ_BRUTTO,
	START_BON_ZEILE,
	BON_NR_EXTERN,
	KPOS_ERFASSUNG_ID,
	MENGE,
	KL_ART_ID,
	EINH_ID,
	MWST_ID,
	BARCODE_LEERGUT
) as 
    SELECT 
        bon_id
        ,bon_zeile
        ,mandant_id
        ,wup_id
        ,bon_dat
        ,ean_kasse
        ,umsatz_brutto
        ,start_bon_zeile
        ,bon_nr_extern
        ,kpos_erfassung_id
        ,menge
        ,kl_art_id
        ,einh_id
        ,mwst_id
        ,barcode_leergut
FROM DBP_ODS.ods_bon_leergut ;
