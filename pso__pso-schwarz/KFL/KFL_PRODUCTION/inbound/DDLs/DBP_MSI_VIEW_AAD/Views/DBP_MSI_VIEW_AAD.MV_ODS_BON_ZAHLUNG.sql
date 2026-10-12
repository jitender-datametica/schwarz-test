CREATE OR REPLACE VIEW DBP_MSI_VIEW_AAD.MV_ODS_BON_ZAHLUNG
(
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
)
AS

--21.06.2023 snik: SPEC0200569 ODS_BON_ZAHLUNG
--26.08.2024 twie: SPEC0266321 Filialumgliederung (P1760) alle Filialen werden in den Views von wup_id auf aktuell_wup_id umgemappt
--							   somit im Frontend nur die neue ID, auch alte Bewegungsdaten werden ab Umgliederungsdatum unter der neuen ID angzeigt 

    SELECT 
      v01.bon_id
    , v01.bon_zeile
    , v01.mandant_id
    , v02.aktuell_wup_id AS wup_id
    , v01.bon_dat
    , v01.zahlung_typ_id
    , v01.start_bon_zeile
    , v01.betrag_zahlung
    , v01.wrg_id
    , v01.kpos_zahlung_typ_id
    , v01.bon_zeile_cashback_referenz
    , v01.kartennummer_maskiert
    , v01.barcode_leergut
    , v01.gutschein_id
	FROM DBP_V_ODS.V_ODS_BON_ZAHLUNG v01
	
INNER JOIN dbp_view.v_wup v02
ON v01.wup_id = v02.wup_id
AND v01.mandant_id = v02.mandant_id
;