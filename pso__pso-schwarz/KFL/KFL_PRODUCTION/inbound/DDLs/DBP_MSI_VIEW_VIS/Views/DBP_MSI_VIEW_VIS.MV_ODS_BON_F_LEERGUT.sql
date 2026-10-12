CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_BON_F_LEERGUT(
  BON_ID
 ,BON_ZEILE
 ,MANDANT_ID
 ,WUP_ID
 ,BON_DAT
 ,EAN_KASSE
 ,UMSATZ_BRUTTO
 ,START_BON_ZEILE
 ,BON_NR_EXTERN
 ,KPOS_ERFASSUNG_ID
 ,MENGE
 ,KL_ART_ID
 ,EINH_ID
 ,MWST_ID
 ,BARCODE_LEERGUT
 ,WRG_ID
) AS 

	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT 
 L01.bon_id
 , L01.bon_zeile
 , L01.mandant_id
 , wup.aktuell_wup_id 																AS wup_id
 , L01.bon_dat
 , L01.ean_kasse
 , L01.umsatz_brutto * krs.umrechnungskurs 											AS umsatz_brutto
 , L01.start_bon_zeile
 , L01.bon_nr_extern
 , L01.kpos_erfassung_id
 , L01.menge
 , L01.kl_art_id
 , L01.einh_id
 , L01.mwst_id
 , L01.barcode_leergut
 , krs.nach_wrg_id 																	AS WRG_ID
FROM DBP_V_ODS.V_ODS_BON_LEERGUT L01

INNER JOIN DBP_V_ODS.v_ODS_BON_KOPF	 K01
	ON L01.mandant_id = K01.mandant_id
	AND L01.wup_id = K01.wup_id
	AND L01.bon_dat = K01.bon_dat
	AND L01.bon_id = K01.bon_id

INNER JOIN
   ( 
    SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
    FROM dbp_data.kurs krs1 
    WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
    AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
    UNION ALL 
    SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
    FROM dbp_data.kurs krs2 
    WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
    AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
   ) krs
  ON krs.von_wrg_id = K01.WRG_ID
  
INNER JOIN dbp_view.v_wup wup
ON L01.mandant_id = wup.mandant_id AND L01.wup_id = wup.wup_id
;