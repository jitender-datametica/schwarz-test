create or replace TABLE KFL_PRODUCTION.DBP_DATA.ART_WUP_EK_ZU_PER (
	ART_ID NUMBER(38,0) NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant im DWH',
	WUP_ID NUMBER(38,0) NOT NULL COMMENT 'Marktnummer',
	NB_ID NUMBER(38,0) NOT NULL COMMENT 'Nebenbetriebskennziffer hier immer = 0',
	DAT_VON DATE NOT NULL COMMENT 'Die Schnittstelle liefert nur ein von - Datum. Das bis - Datum wird durch den nächsten gelieferten Satz definiert.',
	DAT_BIS DATE NOT NULL COMMENT 'Gültigkeitsende des Datensatzes. Bei der Initialübernahme eines Datensatzes wird dieses Feld mit dem Wert 31.12.9999 belegt.',
	EK_NETTO NUMBER(18,4) WITH MASKING POLICY #unknown_policy COMMENT 'Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema) Format decimal(9,4).Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.\n            ',
	EK_NETTO_BNK NUMBER(18,4) WITH MASKING POLICY #unknown_policy COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten. Enthält den Aktionspreis, wenn vorhanden, sonst den Normalpreis Format decimal(9,4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.',
	EK_MEP NUMBER(18,4) WITH MASKING POLICY #unknown_policy COMMENT 'Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema) Format decimal(9,4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.\n            ',
	EINSTANDSPREIS NUMBER(18,4) WITH MASKING POLICY #unknown_policy COMMENT 'Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema) Format decimal(9,4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.\n            ',
	KOMPONENTENMENGE NUMBER(9,4) NOT NULL DEFAULT 1 COMMENT 'Menge des Inhalts bei strukturierten Artikeln (Display) - aber nicht Pfandartikeln. Bei nicht strukturierten Artikeln ist der Wert = 1. Die EK-Preise werden mit diesem Wert multipliziert, um zu einem Gesamt-EK pro Artikel zu kommen',
	WRG_ID VARCHAR(3) NOT NULL COLLATE 'en-ci' DEFAULT 'EUR' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
	EK_NETTONETTO NUMBER(18,4) WITH MASKING POLICY #unknown_policy COMMENT 'Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema) Format decimal(18,4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.\n            ',
	KEIN_ZEKP_FG NUMBER(38,0) NOT NULL COMMENT 'Kennzeichnet, ob sich in den EK-Spalten ein Einkaufspreis befindet (dann 0) oder eine 1 (wenn kein Einkaufspreis ermittelt werden kann)  (dann 1)',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_ART_WUP_EK_ZU_PER primary key (ART_ID, MANDANT_ID, WUP_ID, NB_ID, DAT_VON)
)COMMENT='TP2_AIS - In dieser Tabelle werden die jeweils gültigen Einkaufspreise pro Markt gespeichert. Zwischentabelle zur Verbesserung der Performance '
;