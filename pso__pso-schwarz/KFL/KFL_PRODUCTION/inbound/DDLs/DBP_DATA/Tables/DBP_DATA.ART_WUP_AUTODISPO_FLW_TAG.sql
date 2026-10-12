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
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   kunde_id                            NUMBER(38,0)     NOT NULL COMMENT 'Marktnummer',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Lieferndes VZ o. dezentraler Lieferant',
   nb_id_kunde                         NUMBER(38,0)     NOT NULL COMMENT 'Nebenbetrieb Markt (0)',
   nb_id_lieferant                     NUMBER(38,0)     NOT NULL COMMENT 'Nebenbetrieb Lieferndes VZ o. dezentraler Lieferant (-111)',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikel',
   dat                                 DATE             NOT NULL COMMENT 'Datum',
   menge_einh_id                       VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Mengeneinheit der Kennzahlen - für DE Fleisch BME, KG, KOL, ST, EUR - Rest nur Basismengeneinheit (BME)',
   we_bearbeitungszeit                 NUMBER(38,0)     COMMENT 'Bearbeitungszeit Wareneingang in Tagen',
   planlieferzeit                      NUMBER(38,0)     COMMENT 'Planlieferzeit in Tagen',
   kdis                                NUMBER(38,0)     COMMENT 'Flag: kDiS oder DiS (Bestelllistung)',
   verkaufslistung_fg                  NUMBER(38,0)     COMMENT 'Flag: Verkaufslistung (Bestelllistung + X Tage)',
   sa_af_fg                            NUMBER(38,0)     COMMENT 'Flag: Sonderaktion oder Aktionsfrei',
   udf_prognose_menge_gesteuert        NUMBER(13,3)     COMMENT 'SAP UDF-Prognose (gesteuert)',
   udf_prognose_menge_ungesteuert      NUMBER(13,3)     COMMENT 'SAP UDF-Prognose (ungesteuert)',
   fur_prognose_menge_ungesteuert      NUMBER(13,3)     COMMENT 'SAP F&R-Prognose (ungesteuert)',
   fur_prognose_menge_gesteuert        NUMBER(13,3)     COMMENT 'SAP F&R-Prognose (gesteuert)',
   fur_prognose_menge_max              NUMBER(13,3)     COMMENT 'SAP F&R-Prognose (max)',
   menge_abverkauf                     NUMBER(13,3)     COMMENT 'Abverkaufte Menge',
   ret_bestand                         NUMBER(13,3)     COMMENT 'Frei verfügbarer Bestand im Markt (SAP Retail)',
   fur_bestand                         NUMBER(13,3)     COMMENT 'Bestand im Markt (SAP F&R)',
   menge_we_offen                      NUMBER(13,3)     COMMENT 'Offener Wareneingang (Bestellungen ohne Endlieferkenzeichen)',
   menge_bv                            NUMBER(13,3)     COMMENT 'Menge Bestellvorschlag',
   menge_ofc                           NUMBER(13,3)     COMMENT 'Menge Order Forecast',
   nullbestand_fg                      NUMBER(38,0)     COMMENT 'Flag: Nullbestand im Markt (F&R Bestand <= 0)',
   menge_preisabschriften              NUMBER(13,3)     COMMENT 'Menge Preisabschriften',
   menge_totalabschriften              NUMBER(13,3)     COMMENT 'Menge Totalabschriften',
   kollifaktor                         NUMBER(13,3)     COMMENT 'Kollifaktor',
   egalisierungsfaktor                 NUMBER(13,3)     COMMENT 'Egalisierungsfaktor (=Packungsinhalt)',
   servicelevel                        NUMBER(5,2)      COMMENT 'Servicelevel',
   optik                               NUMBER(19,6)     COMMENT 'Optik',
   menge_we                            NUMBER(13,3)     COMMENT 'Menge Wareneingang (gebuchter WE)',
   nullbestand_exc_fg                  NUMBER(38,0)     DEFAULT 0 COMMENT 'Flag: Nullbestand im Markt (Exception 209)',
   menge_we_geplant                    NUMBER(38,3)     COMMENT 'Geplanter Wareneingang. Berechnungslogik: 
            - wenn Bestelltag < Heute dann menge_we
            - wenn Bestelltag = Heute dann menge_we_offen
            - wenn Bestelltag > Heute dann menge_ofc + menge_we_offen
            Offener Wareneingang aus SAP RET EKPO; Order Forecast für Liefertag aus ZFRE_OFC',
   display_art_id                      NUMBER(38,0)     COMMENT 'Artikel-ID des Displays im Lagerbewegungsbeleg. Displays (a.k.a. Aussteller) als auch die Komponenten / Artikel in einem Display werden im Lagerbewegungsbeleg als eigene Positionen / Artikel aufgeführt. Ein Display ist beispielsweise eine fertig gebaute Palette von Mondelez, die mehrere Sorten Milka Schokolade enthält und an den Markt geliefert wird. Über diese Spalte bekommen die Komponenten die art_id des zugehörigen Displays. Wird bei der Beladung gefüllt.',
   komponentenmenge                    NUMBER(38,4)     COMMENT 'Gibt an, wie viele Einheiten einer bestimmten Sorte (Komponente) in einem Display enthalten sind. Für die Komponenten selbst wird hier die jeweilige Einzelmenge erfasst. Für das Display (DP) wird die Summe aller enthaltenen  Aus stueckliste_det befüllt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_WUP_AUTODISPO_FLW_TAG PRIMARY KEY (mandant_id, kunde_id, wup_id, nb_id_kunde, nb_id_lieferant, art_id, dat, menge_einh_id) NOT ENFORCED
)  COMMENT = 'Tabelle enthält Artikel/Markt/Tag Kombinationen auf Autodispo - Grundgesamtheit bildet für Fleischartikel in DE der EK Ordersatz (EORD), für den Rest die Tabelle ZE1WBB06 (beide SAP RET).';
