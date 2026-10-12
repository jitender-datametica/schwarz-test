CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_ELS_LEERGUT_2(
  BARCODE_LEERGUT
 ,MANDANT_ID
 ,WUP_ID
 ,BON_DAT
 ,WRG_ID
 ,BON_TMSP
 ,BON_NR
 ,SYSTEM_BEZ
 ,SYSTEM_TYP_BEZ
 ,SYSTEM_HERSTELLER_BEZ
 ,BON_ZEILE
 ,KL_ART_ID
 ,PLU_GRUPPE
 ,MENGE
 ,BON_ZEILEN_WERT
) AS

-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

 SELECT 
    ek.BARCODE_LEERGUT
  , ek.MANDANT_ID
  , wup.aktuell_wup_id 												AS wup_id
  , ek.BON_DAT
  , krs.nach_wrg_id 												AS WRG_ID
  , ek.BON_TMSP
  , ek.BON_NR
  , ek.SYSTEM_BEZ
  , ek.SYSTEM_TYP_BEZ
  , ek.SYSTEM_HERSTELLER_BEZ
  , ep.BON_ZEILE
  , ep.KL_ART_ID
  , ep.PLU_GRUPPE
  , ep.MENGE
  , ep.BON_ZEILEN_WERT * krs.umrechnungskurs 						AS BON_ZEILEN_WERT
 FROM dbp_v_ods.v_els_leergut_kopf_2 ek
 
 INNER JOIN dbp_v_ods.v_els_leergut_position_2 ep
 ON ek.MANDANT_ID = ep.MANDANT_ID
 AND ek.BARCODE_LEERGUT = ep.BARCODE_LEERGUT
 
 INNER JOIN
   ( 
    SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
    FROM dbp_data.kurs_2 krs1 
    WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
    AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
    UNION ALL 
    SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
    FROM dbp_data.kurs_2 krs2 
    WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
    AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
   ) krs
  ON krs.von_wrg_id = ek.WRG_ID
  
INNER JOIN dbp_view.v_wup_2 wup_2
ON ek.mandant_id = wup.mandant_id AND ek.wup_id = wup.wup_id
;