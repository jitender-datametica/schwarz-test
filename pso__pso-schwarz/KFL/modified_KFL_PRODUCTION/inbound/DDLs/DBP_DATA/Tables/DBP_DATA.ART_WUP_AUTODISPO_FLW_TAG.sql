--==============================================================
-- Table: art_wup_autodispo_flw_tag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_wup_autodispo_flw_tag
   generated from Powerdesigner on Mittwoch, 9. Juli 2025 11:47:11
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_WUP_AUTODISPO_FLW_TAG CLUSTER BY (
     DAT,
     MANDANT_ID
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   kunde_id                            INTEGER     NOT NULL COMMENT 'Marktnummer',
   wup_id                              INTEGER     NOT NULL COMMENT 'Lieferndes VZ o. dezentraler Lieferant',
   nb_id_kunde                         INTEGER     NOT NULL COMMENT 'Nebenbetrieb Markt (0)',
   nb_id_lieferant                     INTEGER     NOT NULL COMMENT 'Nebenbetrieb Lieferndes VZ o. dezentraler Lieferant (-111)',
   art_id                              INTEGER     NOT NULL COMMENT 'Artikel',
   dat                                 DATE             NOT NULL COMMENT 'Datum',
   menge_einh_id                       VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Mengeneinheit der Kennzahlen - für DE Fleisch BME, KG, KOL, ST, EUR - Rest nur Basismengeneinheit (BME)',
   we_bearbeitungszeit                 INTEGER     COMMENT 'Bearbeitungszeit Wareneingang in Tagen',
   planlieferzeit                      INTEGER     COMMENT 'Planlieferzeit in Tagen',
   kdis                                INTEGER     COMMENT 'Flag: kDiS oder DiS (Bestelllistung)',
   verkaufslistung_fg                  INTEGER     COMMENT 'Flag: Verkaufslistung (Bestelllistung + X Tage)',
   sa_af_fg                            INTEGER     COMMENT 'Flag: Sonderaktion oder Aktionsfrei',
   udf_prognose_menge_gesteuert        NUMBER(29,3)     COMMENT 'SAP UDF-Prognose (gesteuert)',
   udf_prognose_menge_ungesteuert      NUMBER(29,3)     COMMENT 'SAP UDF-Prognose (ungesteuert)',
   fur_prognose_menge_ungesteuert      NUMBER(29,3)     COMMENT 'SAP F&R-Prognose (ungesteuert)',
   fur_prognose_menge_gesteuert        NUMBER(29,3)     COMMENT 'SAP F&R-Prognose (gesteuert)',
   fur_prognose_menge_max              NUMBER(29,3)     COMMENT 'SAP F&R-Prognose (max)',
   menge_abverkauf                     NUMBER(29,3)     COMMENT 'Abverkaufte Menge',
   ret_bestand                         NUMBER(29,3)     COMMENT 'Frei verfügbarer Bestand im Markt (SAP Retail)',
   fur_bestand                         NUMBER(29,3)     COMMENT 'Bestand im Markt (SAP F&R)',
   menge_we_offen                      NUMBER(29,3)     COMMENT 'Offener Wareneingang (Bestellungen ohne Endlieferkenzeichen)',
   menge_bv                            NUMBER(29,3)     COMMENT 'Menge Bestellvorschlag',
   menge_ofc                           NUMBER(29,3)     COMMENT 'Menge Order Forecast',
   nullbestand_fg                      INTEGER     COMMENT 'Flag: Nullbestand im Markt (F&R Bestand <= 0)',
   menge_preisabschriften              NUMBER(29,3)     COMMENT 'Menge Preisabschriften',
   menge_totalabschriften              NUMBER(29,3)     COMMENT 'Menge Totalabschriften',
   kollifaktor                         NUMBER(29,3)     COMMENT 'Kollifaktor',
   egalisierungsfaktor                 NUMBER(29,3)     COMMENT 'Egalisierungsfaktor (=Packungsinhalt)',
   servicelevel                        NUMBER(29,2)      COMMENT 'Servicelevel',
   optik                               NUMBER(29,6)     COMMENT 'Optik',
   menge_we                            NUMBER(29,3)     COMMENT 'Menge Wareneingang (gebuchter WE)',
   nullbestand_exc_fg                  INTEGER     DEFAULT 0 COMMENT 'Flag: Nullbestand im Markt (Exception 209)',
   menge_we_geplant                    NUMBER(29,3)     COMMENT 'Geplanter Wareneingang. Berechnungslogik: 
            - wenn Bestelltag < Heute dann menge_we
            - wenn Bestelltag = Heute dann menge_we_offen
            - wenn Bestelltag > Heute dann menge_ofc + menge_we_offen
            Offener Wareneingang aus SAP RET EKPO; Order Forecast für Liefertag aus ZFRE_OFC',
   display_art_id                      INTEGER     COMMENT 'Artikel-ID des Displays im Lagerbewegungsbeleg. Displays (a.k.a. Aussteller) als auch die Komponenten / Artikel in einem Display werden im Lagerbewegungsbeleg als eigene Positionen / Artikel aufgeführt. Ein Display ist beispielsweise eine fertig gebaute Palette von Mondelez, die mehrere Sorten Milka Schokolade enthält und an den Markt geliefert wird. Über diese Spalte bekommen die Komponenten die art_id des zugehörigen Displays. Wird bei der Beladung gefüllt.',
   komponentenmenge                    NUMBER(29,4)     COMMENT 'Gibt an, wie viele Einheiten einer bestimmten Sorte (Komponente) in einem Display enthalten sind. Für die Komponenten selbst wird hier die jeweilige Einzelmenge erfasst. Für das Display (DP) wird die Summe aller enthaltenen  Aus stueckliste_det befüllt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_AUTODISPO_FLW_TAG PRIMARY KEY (mandant_id, kunde_id, wup_id, nb_id_kunde, nb_id_lieferant, art_id, dat, menge_einh_id) NOT ENFORCED
)  COMMENT = 'Tabelle enthält Artikel/Markt/Tag Kombinationen auf Autodispo - Grundgesamtheit bildet für Fleischartikel in DE der EK Ordersatz (EORD), für den Rest die Tabelle ZE1WBB06 (beide SAP RET).';
