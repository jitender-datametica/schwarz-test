create or replace view KFL_PRODUCTION.DBP_VIEW.V_AMX_PRUEFUNG_1(
	PRUEFUNG_ID,
	AMX_SYSTEM_ID,
	PRUEFUNG_NR,
	ZUSTAND_ID,
	PRUEFUNG_BEZ,
	DAT_START,
	DAT_ENDE,
	REVISOR_ID,
	PRUEFUNG_TYP_ID,
	PRUEFUNG_KLASSE_ID,
	PRUEFUNG_ERGEBNIS_WERT,
	BUSINESS_UNIT_ID,
	MANDANT_ID,
	WUP_ID,
	ZEITSPANNE,
	TD_INSERT,
	TD_UPDATE
) as 
    SELECT 
        pruefung_id,
        amx_system_id,
        pruefung_nr,
        zustand_id,
        pruefung_bez,
        dat_start,
        dat_ende,
        revisor_id,
        pruefung_typ_id,
        pruefung_klasse_id,
        pruefung_ergebnis_wert,
        business_unit_id,
        mandant_id,
        wup_id,
        zeitspanne,
		td_insert,
		td_update

FROM DBP_DATA.amx_pruefung_1 ;