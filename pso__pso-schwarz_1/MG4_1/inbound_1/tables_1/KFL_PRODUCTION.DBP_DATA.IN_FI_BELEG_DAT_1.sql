create or replace TABLE KFL_PRODUCTION.DBP_DATA.IN_FI_BELEG_DAT_1 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_1',
	BUCHUNGSKREIS_ID NUMBER(38,0) NOT NULL COMMENT 'Zuordnung des Buchungskreises zu dem WUP_1 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
	IN_FI_BELEG_ID NUMBER(18,0) NOT NULL COMMENT 'Belegnummer eines Buchhaltungsbelegs. Aus SAP Industrie belnr',
	IN_FI_BELEG_POS_ID NUMBER(38,0) NOT NULL COMMENT 'Belegposition eines Buchhaltungsbelegs. Aus SAP Industrie buzei',
	GJ NUMBER(38,0) NOT NULL COMMENT 'Geschäftsjahr, Format JJJJ',
	DAT_BUCH DATE NOT NULL COMMENT 'Buchungsdatum der Rechnung.',
	DAT_BELEG DATE NOT NULL COMMENT 'Belegdatum der Rechnung.',
	DAT_BASIS DATE NOT NULL COMMENT 'Basisdatum für Fälligkeitsberechnung',
	IN_LIEF_ID NUMBER(38,0) COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
	SONDER_HAUPTBUCH_KZ VARCHAR(1) COLLATE 'en-ci' COMMENT 'Kennzeichen für die Zuordnung zu Sonderhauptbuch, z.Bsp. A = Auszahlung, P = Zahlungsaufforderung. Aus umskz',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_IN_FI_BELEG_DAT primary key (MANDANT_ID, BUCHUNGSKREIS_ID, IN_FI_BELEG_ID, IN_FI_BELEG_POS_ID, GJ)
)COMMENT='IMMO - Buchhaltung: Sekundärindex für Kreditoren aus der SAP-Quelle bsik'
;