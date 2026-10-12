create or replace view KFL_PRODUCTION.DBP_V_ODS.V_ODS_BON_ZAHLUNG(
	BON_ID,
	BON_ZEILE,
	MANDANT_ID,
	WUP_ID,
	BON_DAT,
	ZAHLUNG_TYP_ID,
	START_BON_ZEILE,
	BETRAG_ZAHLUNG,
	WRG_ID,
	KPOS_ZAHLUNG_TYP_ID,
	BON_ZEILE_CASHBACK_REFERENZ,
	KARTENNUMMER_MASKIERT,
	BARCODE_LEERGUT,
	GUTSCHEIN_ID
) as 
    SELECT 
        bon_id
        ,bon_zeile
        ,mandant_id
        ,wup_id
        ,bon_dat
        ,zahlung_typ_id
        ,start_bon_zeile
        ,betrag_zahlung
        ,wrg_id
        ,kpos_zahlung_typ_id
        ,bon_zeile_cashback_referenz
        ,kartennummer_maskiert
        ,barcode_leergut
        ,gutschein_id


FROM DBP_ODS.ODS_BON_ZAHLUNG ;