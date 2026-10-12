CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_WUP_EK_ZU_PER (
ART_ID INTEGER NOT NULL
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
WUP_ID INTEGER NOT NULL OPTIONS(description='Marktnummer'),
NB_ID INTEGER NOT NULL OPTIONS(description='Nebenbetriebskennziffer hier immer = 0'),
DAT_VON DATE NOT NULL
OPTIONS(description='Die Schnittstelle liefert nur ein von - Datum. Das bis - Datum wird durch den nächsten gelieferten Satz definiert.'),
DAT_BIS DATE NOT NULL
OPTIONS(description='Gültigkeitsende des Datensatzes. Bei der Initialübernahme eines Datensatzes wird dieses Feld mit dem Wert 31.12.9999 belegt.'),
EK_NETTO NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema) Format NUMERIC(9, 4).Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.\n            '),
EK_NETTO_BNK NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten. Enthält den Aktionspreis, wenn vorhanden, sonst den Normalpreis Format NUMERIC(9, 4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.'),
EK_MEP NUMERIC(18,4)
OPTIONS(description='Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema) Format NUMERIC(9, 4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.\n            '),
EINSTANDSPREIS NUMERIC(18,4)
OPTIONS(description='Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema) Format NUMERIC(9, 4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.\n            '),
KOMPONENTENMENGE NUMERIC(9,4) DEFAULT 1 NOT NULL
OPTIONS(description='Menge des Inhalts bei strukturierten Artikeln (Display) - aber nicht Pfandartikeln. Bei nicht strukturierten Artikeln ist der Wert = 1. Die EK-Preise werden mit diesem Wert multipliziert, um zu einem Gesamt-EK pro Artikel zu kommen'),
WRG_ID STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
EK_NETTONETTO NUMERIC(18,4)
OPTIONS(description='Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema) Format NUMERIC(18, 4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.\n            '),
KEIN_ZEKP_FG INTEGER NOT NULL
OPTIONS(description='Kennzeichnet, ob sich in den EK-Spalten ein Einkaufspreis befindet (dann 0) oder eine 1 (wenn kein Einkaufspreis ermittelt werden kann)  (dann 1)'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ART_ID, MANDANT_ID, WUP_ID, NB_ID, DAT_VON) NOT ENFORCED
)
OPTIONS(description='TP2_AIS - In dieser Tabelle werden die jeweils gültigen Einkaufspreise pro Markt gespeichert. Zwischentabelle zur Verbesserung der Performance ');