--==============================================================
-- Table: art_wup_ek_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_ek_zu_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_EK_ZU_PER_1 (
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Marktnummer',
   nb_id                               INTEGER     NOT NULL COMMENT 'Nebenbetriebskennziffer hier immer = 0',
   dat_von                             DATE             NOT NULL COMMENT 'Die Schnittstelle liefert nur ein von - Datum. Das bis - Datum wird durch den nächsten gelieferten Satz definiert.',
   dat_bis                             DATE             NOT NULL COMMENT 'Gültigkeitsende des Datensatzes. Bei der Initialübernahme eines Datensatzes wird dieses Feld mit dem Wert 31.12.9999 belegt.',
   ek_netto                            NUMBER(29,4)     COMMENT 'Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema) Format decimal(9,4).Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.
            ',
   ek_netto_bnk                        NUMBER(29,4)     COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten. Enthält den Aktionspreis, wenn vorhanden, sonst den Normalpreis Format decimal(9,4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.',
   ek_mep                              NUMBER(29,4)     COMMENT 'Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema) Format decimal(9,4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.
            ',
   einstandspreis                      NUMBER(29,4)     COMMENT 'Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema) Format decimal(9,4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.
            ',
   komponentenmenge                    NUMBER(29,4)      NOT NULL DEFAULT 1 COMMENT 'Menge des Inhalts bei strukturierten Artikeln (Display) - aber nicht Pfandartikeln. Bei nicht strukturierten Artikeln ist der Wert = 1. Die EK-Preise werden mit diesem Wert multipliziert, um zu einem Gesamt-EK pro Artikel_1 zu kommen',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' DEFAULT 'EUR' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   ek_nettonetto                       NUMBER(29,4)     COMMENT 'Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema) Format decimal(18,4). Abhängig vom man_spanne_fg kann anstatt eines EK ein manuell gepflegter Faktor enthalten sein.
            ',
   kein_zekp_fg                        INTEGER     NOT NULL COMMENT 'Kennzeichnet, ob sich in den EK-Spalten ein Einkaufspreis befindet (dann 0) oder eine_1 1 (wenn kein Einkaufspreis ermittelt werden kann)  (dann 1)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_EK_ZU_PER PRIMARY KEY (art_id, mandant_id, wup_id, nb_id, dat_von) NOT ENFORCED
)  COMMENT = 'TP2_AIS - In dieser Tabelle werden die jeweils gültigen Einkaufspreise pro Markt gespeichert. Zwischentabelle zur Verbesserung der Performance ';

