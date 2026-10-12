CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_BON_KUNDE_PROGNOSE_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DAT,
	ZEIT_STUNDE,
	ZEIT_MINUTE,
	DATZEIT_PROGNOSE,
	ANZ_KUNDEN,
	ANZ_KUNDEN_PROGNOSE,
	ANZ_KUNDEN_PROGNOSE_DYN,
	ANZ_KASSEN_OFFEN,
	ANZ_KASSEN_PROGNOSE,
	ANZ_KASSEN_PROGNOSE_DYN,
	DATZEIT_UPDATE
) AS

	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
	
SELECT
 bkp.mandant_id
 , wup.aktuell_wup_id 																			                        AS wup_id
 , bkp.nb_id
 , bkp.dat
 , bkp.zeit_stunde
 , bkp.zeit_minute
 , (dat) ||' '|| to_varchar(bkp.zeit_stunde, 'FM00') || to_varchar(bkp.zeit_minute,':99') ||':00' 		AS datzeit_prognose
 , bkp.anz_kunden
 , bkp.anz_kunden_prognose
 , bkp.anz_kunden_prognose_dyn
 , bkp.anz_kassen_offen
 , bkp.anz_kassen_prognose
 , bkp.anz_kassen_prognose_dyn
 , bkp.datzeit_update
FROM dbp_v_ods.v_ods_bon_kunde_prognose_1 bkp

INNER JOIN dbp_view.v_wup_1 wup_1
ON bkp.mandant_id = wup.mandant_id AND bkp.wup_id = wup.wup_id
;