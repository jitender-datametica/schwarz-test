create or replace view KFL_PRODUCTION.DBP_SPEZIAL.V_ODS_FINANZ01_UNION_2(
	MANDANT_ID,
	WUP_ID,
	FIN_BOOKING,
	BUCHUNGSART_ID,
	BUCHUNGSSCHLUESSEL_ID,
	ZAHLUNGSMITTEL_ID,
	BELEG_LFD_NR,
	DAT_BOOKING,
	BETRAG,
	BEMERKUNG2
) as 
SELECT mandant_id
,wup_id
,fin_booking
,buchungsart_id
,buchungsschluessel_id
,zahlungsmittel_id
,beleg_lfd_nr
,dat_booking
,betrag
,bemerkung2
 FROM dbp_ods.ods_finanz01_2
UNION ALL
SELECT mandant_id
,wup_id
,fin_booking
,buchungsart_id
,buchungsschluessel_id
,zahlungsmittel_id
,beleg_lfd_nr
,dat_booking
,betrag
,bemerkung2
 FROM dbp_ods_archiv.ods_finanz01_2
;
