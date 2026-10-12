CREATE OR REPLACE VIEW DBP_V_ODS.V_ODS_BON_ZAHLUNG AS 
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