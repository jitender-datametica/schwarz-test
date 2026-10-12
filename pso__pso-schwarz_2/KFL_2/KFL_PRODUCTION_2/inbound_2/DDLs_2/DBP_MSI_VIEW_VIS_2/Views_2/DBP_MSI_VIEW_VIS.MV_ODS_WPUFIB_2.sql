CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_WPUFIB_2(
  WUP_ID
 ,MANDANT_ID
 ,DAT_BOOKING
 ,ZAHLUNGSMITTEL_ID
 ,BUCHUNGSSCHLUESSEL_ID
 ,AGGR_NR
 ,GROUP_NR
 ,RECORD_NR
 ,WRG_ID
 ,BETRAG
) AS
 
	-- 31.08.2022, snik: WRG_2 updated with latest changes - PRJTASK0013908
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
 
SELECT
 wup.aktuell_wup_id 														AS wup_id
 , w.mandant_id
 , w.dat_booking
 , w.zahlungsmittel_id
 , w.buchungsschluessel_id
 , w.aggr_nr
 , w.group_nr
 , w.record_nr
 , krs.nach_wrg_id                											AS wrg_id 
 , w.betrag * krs.umrechnungskurs									 		AS betrag
FROM dbp_v_ods.v_ods_wpufib_2 w
 
INNER JOIN ( 
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
ON krs.von_wrg_id = w.WRG_ID

INNER JOIN dbp_view.v_wup_2 wup_2
ON w.mandant_id = wup.mandant_id AND w.wup_id = wup.wup_id
;