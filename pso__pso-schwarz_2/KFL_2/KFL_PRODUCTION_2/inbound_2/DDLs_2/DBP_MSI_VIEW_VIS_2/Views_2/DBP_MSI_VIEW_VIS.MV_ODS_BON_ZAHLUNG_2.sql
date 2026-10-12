CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_BON_ZAHLUNG_2(
  BON_ID
 ,BON_ZEILE
 ,WUP_ID
 ,MANDANT_ID
 ,ZAHLUNG_TYP_ID
 ,START_BON_ZEILE
 ,BETRAG_ZAHLUNG
 ,WRG_ID
 ,KPOS_ZAHLUNG_TYP_ID
 ,BON_DAT
 ,BON_ZEILE_CASHBACK_REFERENZ
 ,KARTENNUMMER_MASKIERT
 ,BARCODE_LEERGUT
) AS

	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 bz.bon_id
 , bz.bon_zeile
 , wup.aktuell_wup_id 														AS wup_id
 , bz.mandant_id
 , bz.zahlung_typ_id
 , bz.start_bon_zeile
 , bz.betrag_zahlung
 , bz.wrg_id
 , bz.kpos_zahlung_typ_id
 , bz.bon_dat
 , bz.bon_zeile_cashback_referenz
 , bz.kartennummer_maskiert
 , bz.barcode_leergut
FROM dbp_v_ods.v_ods_bon_zahlung_2 bz

INNER JOIN dbp_view.v_wup_2 wup_2
ON bz.mandant_id = wup.mandant_id AND bz.wup_id = wup.wup_id
;