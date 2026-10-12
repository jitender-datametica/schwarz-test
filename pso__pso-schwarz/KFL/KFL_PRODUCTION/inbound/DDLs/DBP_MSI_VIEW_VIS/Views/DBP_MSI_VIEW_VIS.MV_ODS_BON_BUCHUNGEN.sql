CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.mv_ods_bon_buchungen(
	BON_ID,
	BON_ZEILE,
	WUP_ID,
	MANDANT_ID,
	BUCHUNGSSCHLUESSEL_ID,
	WRG_ID,
	KPOS_ZAHLUNG_TYP_ID,
	DAT_BOOKING,
	BON_DAT,
	START_BON_ZEILE,
	KASSE_NR,
	BON_NR,
	BETRAG_BUCHUNG,
	KOMMENTAR_BUCHUNG
) AS
	
	-- snik1809-AP0041812-SPEC0056256--05-2020
	-- 2020-11-26 ssch0611 : removed filter turnover_fg + finetuning. added join bon_storno (INC2455654) 
	-- 2021-05-19 snik1809 : removed set kpos_zahlung_typ_id as wrg_id, added kpos_zahlung_typ_id in ods_bon_buchungen, removed mandant=1 from 2nd part of union
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]

SELECT
 t0.bon_id
 , t0.bon_zeile
 , wup.aktuell_wup_id 														AS wup_id
 , t0.mandant_id
 , t0.buchungsschluessel_id
 , t0.kpos_zahlung_typ_id :: CHAR(3)										AS wrg_id
 , t0.kpos_zahlung_typ_id
 , t0.dat_booking
 , t0.bon_dat
 , t0.start_bon_zeile
 , t0.kasse_nr
 , t0.bon_nr
 , t0.betrag_buchung
 , t0.kommentar_buchung
FROM DBP_V_ODS.v_ods_bon_buchungen t0

INNER JOIN dbp_view.v_wup wup
ON t0.mandant_id = wup.mandant_id AND t0.wup_id = wup.wup_id

WHERE (t0.bon_id, t0.wup_id, t0.mandant_id) NOT IN (SELECT
 bon_id
 , wup_id
 , mandant_id
FROM DBP_V_ODS.v_ods_bon_storno)


UNION ALL
SELECT
 t1.bon_id
 , 0 																		AS bon_zeile
 , wup.aktuell_wup_id 														AS wup_id
 , t1.mandant_id
 , 11 																		AS buchungsschluessel_id
 , t2.wrg_id
 , t2.kpos_zahlung_typ_id
 , t1.dat_booking
 , t1.bon_dat
 , t1.bon_dat 																AS start_bon_zeile
 , t1.kasse_nr
 , t1.bon_nr
 , SUM(t2.betrag_zahlung) 													AS betrag_buchung
 , '' 																		AS kommentar_buchung
FROM DBP_V_ODS.v_ods_bon_kopf t1

JOIN DBP_V_ODS.v_ods_bon_zahlung t2
ON t1.mandant_id = t2.mandant_id
AND t1.wup_id = t2.wup_id
AND t1.bon_dat = t2.bon_dat
AND t1.bon_id = t2.bon_id

INNER JOIN dbp_view.v_wup wup
ON t1.mandant_id = wup.mandant_id AND t1.wup_id = wup.wup_id

WHERE
t1.mandant_id <> 1

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,14
;