create or replace view KFL_PRODUCTION.DBP_VIEW.V_KOSTENSTELLE_LOHNART_ZU_PER(
	MANDANT_ID,
	KOSTENSTELLE_ID,
	LOHNART_ID,
	ZEITART_ID,
	KJMO,
	KOSTENSTELLE_VON_ID,
	KOSTENSTELLE_NACH_ID,
	ABRECHNUNG_FUER_PERIODE,
	ABRECHNUNGSTYP_FUER_PERIODE,
	ZAHLUNG_DAT,
	KRK_ID,
	WRG_ID,
	ABRECHNUNG_IN_PERIODE,
	ANZAHL_LOHNART,
	BETRAG_LOHNART,
	SYSTEM_ID
) as 
    SELECT 
        mandant_id
        ,kostenstelle_id
        ,lohnart_id
        ,zeitart_id
        ,kjmo
        ,kostenstelle_von_id
        ,kostenstelle_nach_id
        ,abrechnung_fuer_periode
        ,abrechnungstyp_fuer_periode
        ,zahlung_dat
        ,krk_id
        ,wrg_id
        ,abrechnung_in_periode
        ,anzahl_lohnart
        ,betrag_lohnart
        ,system_id
FROM DBP_DATA.KOSTENSTELLE_LOHNART_ZU_PER ;