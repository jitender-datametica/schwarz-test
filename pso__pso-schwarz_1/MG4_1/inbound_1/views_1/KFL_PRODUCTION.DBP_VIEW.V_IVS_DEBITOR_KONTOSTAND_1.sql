create or replace view KFL_PRODUCTION.DBP_VIEW.V_IVS_DEBITOR_KONTOSTAND_1(
	DEBITOR_ID,
	ABZUG_ID,
	MANDANT_ID,
	KJMO,
	MIETVERTRAG_ID,
	WUP_ID,
	BUCHUNGSKREIS_ID,
	WRG_ID,
	SONDERHAUPTBUCH_ID,
	SUMME_SOLL,
	SUMME_HABEN,
	SALDO_VORTRAG,
	SALDO_SOLL,
	SALDO_HABEN,
	SALDO_KONTO
) as 
    SELECT 
        debitor_id,
        abzug_id,
        mandant_id,
        kjmo,
        mietvertrag_id,
        wup_id,
        buchungskreis_id,
        wrg_id,
        sonderhauptbuch_id,
        summe_soll,
        summe_haben,
        saldo_vortrag,
        saldo_soll,
        saldo_haben,
        saldo_konto
FROM DBP_DATA.ivs_debitor_kontostand_1 ;