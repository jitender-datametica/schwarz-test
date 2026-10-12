create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_AAD.MV_ODS_BON_RETOURE_1(
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
	REKLAMATIONSGRUND_ID,
	REKLAMATIONSTYP_ID,
	MENGE_FG,
	MANDANT_ID,
	MHD,
	LOS_CHARGE,
	KUNDEN_TEXT,
	WUP_ID,
	ART_ID_REF,
	GP_ID,
	START_BON_ZEILE,
	TALON_ID,
	KPOS_ERFASSUNG_ID,
	UMSATZ_BRUTTO_NORM,
	VK_BRUTTO_OBB,
	BON_VORGANG_ID,
	BARCODE_STRING,
	BON_DAT,
	BARCODE_LEERGUT
) as





    SELECT 
     v01.bon_id
    ,v01.bon_zeile
    ,v01.kl_art_id
    ,v01.ean_kasse
    ,v01.wg_id
    ,v01.menge
    ,v01.einh_id
    ,v01.umsatz_brutto
    ,v01.mwst_id
    ,v01.erfassung_id
    ,v01.aktion_id
    ,v01.reklamationsgrund_id
    ,v01.reklamationstyp_id
    ,v01.menge_fg
    ,v01.mandant_id
    ,v01.mhd
    ,v01.los_charge
    ,v01.kunden_text
    ,v02.aktuell_wup_id AS wup_id
    ,v01.art_id_ref
    ,v01.gp_id
    ,v01.start_bon_zeile
    ,v01.talon_id
    ,v01.kpos_erfassung_id
    ,v01.umsatz_brutto_norm
    ,v01.vk_brutto_obb
    ,v01.bon_vorgang_id
    ,v01.barcode_string
    ,v01.bon_dat
    ,v01.barcode_leergut
FROM DBP_V_ODS.v_ods_bon_retoure_1 v01

INNER JOIN dbp_view.v_wup_1 v02
ON v01.wup_id = v02.wup_id
AND v01.mandant_id = v02.mandant_id
;