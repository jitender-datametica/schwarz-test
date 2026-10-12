create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_UMLAGERUNG_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH',
	WA_LAGERBEW_BELEG_ID COMMENT 'Materialbelegnummer des Warenausgangs in der abgebenden Filiale, Hochzählende Nummer pro Land_1 und Jahr.',
	WA_LAGERBEW_BELEG_KJ COMMENT 'Kalenderjahr des Belegs im Warenausgang der abgebenden Filiale.',
	WA_WUP_ID COMMENT 'ID des Warenumschlagsplatz der abgebenden Filiale.',
	WA_NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP.',
	DAT_BUCHUNG_WA COMMENT 'Datum der Verarbeitung der Umlagerung_1 bei der abgebenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen,',
	WE_LAGERBEW_BELEG_ID COMMENT 'Materialbelegnummer im Wareneingang der empfangenden Filiale, Hochzählende Nummer pro Land_1 und Jahr.',
	WE_LAGERBEW_BELEG_KJ COMMENT 'Kalenderjahr des Belegs im Wareneingang der abgebenden Filiale.',
	WE_WUP_ID COMMENT 'ID des Warenumschlagsplatz der empfangenden Filiale.',
	WE_NB_ID COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des empfangenden WUP.',
	DAT_BUCHUNG_WE COMMENT 'Datum der Verarbeitung der Umlagerung_1 bei der empfangenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen.',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	UMLAGERUNG_STATUS_KZ COMMENT 'Kennzeichen für den Status_1 der Umlagerung_1: W = Wareneingang gebucht, S = Storniert, O = Offen.',
	ANZ_BELEG_POS COMMENT 'Anzahl der Buchungspositionen im Materialbeleg.',
	VK_BRUTTO COMMENT 'Brutto Verkaufswert der Positionen der Umlagerung.'
) as 
    SELECT 
        mandant_id,
        wa_lagerbew_beleg_id,
        wa_lagerbew_beleg_kj,
        wa_wup_id,
        wa_nb_id,
        dat_buchung_wa,
        we_lagerbew_beleg_id,
        we_lagerbew_beleg_kj,
        we_wup_id,
        we_nb_id,
        dat_buchung_we,
        wrg_id,
        umlagerung_status_kz,
        anz_beleg_pos,
        vk_brutto

FROM DBP_DATA.UMLAGERUNG_1 ;
