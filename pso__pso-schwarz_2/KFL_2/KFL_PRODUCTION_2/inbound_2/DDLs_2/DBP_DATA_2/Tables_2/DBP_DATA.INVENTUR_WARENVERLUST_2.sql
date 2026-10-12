create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.INVENTUR_WARENVERLUST_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH.',
	INVENTUR_ID NUMBER(38,0) NOT NULL COMMENT 'Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads.',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Der \""WUP_2\"" beinhaltet Märkte und Lager. WUP_2 = WarenUmschlagsPlatz. Mutter WUP_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
	INVENTURART_ID NUMBER(38,0) NOT NULL COMMENT 'Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.',
	DAT_INVENTUR_VON DATE NOT NULL COMMENT 'Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_2 unterscheiden.',
	DAT_INVENTUR_BIS DATE NOT NULL COMMENT 'Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land_2 unterscheiden.',
	DAT_INVENTUR_BUCHUNG_VON DATE COMMENT 'Start des betrachteten Inventurzeitraums nach Verbuchung der Inventur_2 in SAP.',
	DAT_INVENTUR_BUCHUNG_BIS DATE COMMENT 'Ende des betrachteten Inventurzeitraums nach Verbuchung der Inventur_2 in SAP.',
	GJ NUMBER(38,0) COMMENT 'Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.',
	ART_ID NUMBER(38,0) COMMENT 'Artikelnummer im DWH. Input: Artikel_2-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
	WG_ID NUMBER(38,0) COMMENT 'ID der Warengruppe',
	OWG_ID NUMBER(38,0) COMMENT 'ID der Oberwarengruppe',
	HWG_ID NUMBER(38,0) COMMENT 'ID der Hauptwarengruppe',
	ABT_ID NUMBER(38,0) COMMENT 'Abteilungs-ID, negative Werte: im DWH generierte IDs; positive Werte: aus Stammdatensystem übernommen.',
	LOESCH_FG NUMBER(38,0) COMMENT 'Löschkennzeichen, das nachträglich durch VT Orga in den Ländern gesetzt werden kann, falls Zeitraum oder Inventurart aus der Betrachtung herausgenommen werden soll.',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_INVENTUR_WARENVERLUST primary key (INVENTUR_ID, MANDANT_ID)
)COMMENT='Die Tabelle basiert auf Excel und dient als Steuertabelle für die Berechnung von Warenverlusten. Sie enthält die spezifischen Inventurarten, Länder, Filialen und Zeiträume, für die die Verlustberechnungen durchgeführt werden sollen.'
;
