--==============================================================
-- Table: art_wup_ek_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_ek_zu_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_wup_ek_zu_per_1 (
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer'),
nb_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nebenbetriebskennziffer hier immer = 0'),
dat_von DATE NOT NULL
OPTIONS(description='Die Schnittstelle liefert nur ein von - Datum. Das bis - Datum wird durch den nächsten gelieferten Satz definiert.'),
dat_bis DATE NOT NULL
OPTIONS(description='Gültigkeitsende des Datensatzes. Bei der Initialübernahme eines Datensatzes wird dieses Feld mit dem Wert 31.12.9999 belegt.'),
ek_netto NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema) Format NUMERIC(9,4).Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.            '),
ek_netto_bnk NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto plus Bezugsnebenkosten. Enthält den Aktionspreis, wenn vorhanden, sonst den Normalpreis Format NUMERIC(9,4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.'),
ek_mep NUMERIC(18,4)
OPTIONS(description='Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema) Format NUMERIC(9,4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.            '),
einstandspreis NUMERIC(18,4)
OPTIONS(description='Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema) Format NUMERIC(9,4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.            '),
komponentenmenge NUMERIC(9,4) DEFAULT 1 NOT NULL
OPTIONS(description='Menge des Inhalts bei strukturierten Artikeln (Display) - aber nicht Pfandartikeln. Bei nicht strukturierten Artikeln ist der Wert = 1. Die EK-Preise werden mit diesem Wert multipliziert, um zu einem Gesamt-EK pro Artikel_1 zu kommen'),
wrg_id STRING(3) COLLATE 'und:ci' DEFAULT 'EUR' NOT NULL
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
ek_nettonetto NUMERIC(18,4)
OPTIONS(description='Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema) Format NUMERIC(18,4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.            '),
kein_zekp_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichnet, ob sich in den EK-Spalten ein Einkaufspreis befindet (dann 0) oder eine_1 1 (wenn kein Einkaufspreis ermittelt werden kann)  (dann 1)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat_von) NOT ENFORCED
)
OPTIONS(description='TP2_AIS - In dieser Tabelle werden die jeweils gültigen Einkaufspreise pro Markt gespeichert. Zwischentabelle zur Verbesserung der Performance ');