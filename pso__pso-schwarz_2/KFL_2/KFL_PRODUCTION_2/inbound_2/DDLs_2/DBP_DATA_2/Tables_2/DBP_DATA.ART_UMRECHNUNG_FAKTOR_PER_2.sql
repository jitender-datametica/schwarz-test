create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.ART_UMRECHNUNG_FAKTOR_PER_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	ALTNV_MENGE_EINH_ID VARCHAR(3) NOT NULL COMMENT 'Id der alternativen Mengeneinheit. Anhand dieser ID wird pro Mandant_2 und Artikel_2 eine_2 alternative Mengeneinheit eindeutig identifiziert.Aus meinh',
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
	DAT_VON DATE NOT NULL COMMENT 'Gültigkeitbeginn für diesen Datensatz. Es wird dazu das Datum aus dem Dateinamen der Schnittstelle herangezogen.',
	BRUTTOGEW NUMBER(18,3) NOT NULL COMMENT 'Das Feld  enthält das Bruttogewicht in der in dem Attribut gew_einh_id aufgeführten Einheit. Aus brgew',
	UMRECH_FAKTOR NUMBER(38,22) NOT NULL COMMENT 'Umrechnungsfaktor für eine_2 alternative Mengenheinheit zur Umrechnung einer Basismenge in diese Mengeneinheit.',
	GEW_EINH_ID VARCHAR(3) NOT NULL COMMENT 'Dieses Feld enthält die Einheit für das Bruttogewicht.Aus gewei',
	DAT_BIS DATE NOT NULL COMMENT 'Gültigkeitsende des Datensatzes. Wenn dieser Datensatz die momentan gültige Version darstellt besitzt dieses Attribut den Wert 31.12.9999.',
	LAENGE NUMBER(18,3) NOT NULL DEFAULT 0 COMMENT 'Länge (Tiefe) in cm aus laeng',
	BREITE NUMBER(18,3) NOT NULL DEFAULT 0 COMMENT 'Breite in cm aus breit',
	HOEHE NUMBER(18,3) NOT NULL DEFAULT 0 COMMENT 'Höhe in cm aus hoehe',
	UMRECH_ZAEHLER NUMBER(38,0) COMMENT 'Zähler für die Umrechnung in Basismengeneinheiten',
	UMRECH_NENNER NUMBER(38,0) COMMENT 'Nenner für die Umrechnung in Basismengeneinheiten',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_UMRECHNUNG_FAKTOR_PER primary key (MANDANT_ID, ALTNV_MENGE_EINH_ID, ART_ID, DAT_VON)
)COMMENT='TP408_LVS - In dieser Tabelle sind die Umrechnungsfaktoren in die alternative Lagereinheit für die einzelnen Artikel_2 hinterlegt - MULTISET'
;
