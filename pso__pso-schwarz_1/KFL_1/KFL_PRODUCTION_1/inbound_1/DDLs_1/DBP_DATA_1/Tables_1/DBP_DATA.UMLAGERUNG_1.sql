create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.UMLAGERUNG_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1 im DWH',
	WA_LAGERBEW_BELEG_ID NUMBER(38,0) NOT NULL COMMENT 'Materialbelegnummer des Warenausgangs in der abgebenden Filiale, Hochzählende Nummer pro Land_1 und Jahr.',
	WA_LAGERBEW_BELEG_KJ NUMBER(38,0) NOT NULL COMMENT 'Kalenderjahr des Belegs im Warenausgang der abgebenden Filiale.',
	WA_WUP_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Warenumschlagsplatz der abgebenden Filiale.',
	WA_NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP.',
	DAT_BUCHUNG_WA DATE NOT NULL COMMENT 'Datum der Verarbeitung der Umlagerung_1 bei der abgebenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen,',
	WE_LAGERBEW_BELEG_ID NUMBER(38,0) COMMENT 'Materialbelegnummer im Wareneingang der empfangenden Filiale, Hochzählende Nummer pro Land_1 und Jahr.',
	WE_LAGERBEW_BELEG_KJ NUMBER(38,0) COMMENT 'Kalenderjahr des Belegs im Wareneingang der abgebenden Filiale.',
	WE_WUP_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Warenumschlagsplatz der empfangenden Filiale.',
	WE_NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des empfangenden WUP.',
	DAT_BUCHUNG_WE DATE COMMENT 'Datum der Verarbeitung der Umlagerung_1 bei der empfangenden Filiale. Kann bei verzögerter Verarbeitung in wenigen Fällen vom Kalenderjahr des Beleges abweichen.',
	WRG_ID VARCHAR(3) NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	UMLAGERUNG_STATUS_KZ VARCHAR(1) NOT NULL COMMENT 'Kennzeichen für den Status_1 der Umlagerung_1: W = Wareneingang gebucht, S = Storniert, O = Offen.',
	ANZ_BELEG_POS NUMBER(38,0) NOT NULL COMMENT 'Anzahl der Buchungspositionen im Materialbeleg.',
	VK_BRUTTO NUMBER(38,4) NOT NULL COMMENT 'Brutto Verkaufswert der Positionen der Umlagerung.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_UMLAGERUNG primary key (MANDANT_ID, WA_LAGERBEW_BELEG_ID, WA_LAGERBEW_BELEG_KJ)
)COMMENT='Tabelle beinhaltet Informationen zu Umlagerungen. Eine_1 Umlagerung_1 ist der Transport von Artikeln zwischen zwei Filialen.'
;
