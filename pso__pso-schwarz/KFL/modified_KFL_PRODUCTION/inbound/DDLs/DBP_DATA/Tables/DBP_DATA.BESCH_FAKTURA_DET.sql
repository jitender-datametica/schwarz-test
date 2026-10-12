--==============================================================
-- Table: besch_faktura_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_faktura_det
   generated from Powerdesigner on Montag, 21. Juli 2025 05:50:00
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_FAKTURA_DET CLUSTER BY (DAT_FAKTURA) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   faktura_beleg_id                    INTEGER     NOT NULL COMMENT 'Das Feld enthält die Beleg ID der Faktura und dient der eindeutigen Identifikation der Fakturabelege.',
   faktura_beleg_pos_id                INTEGER     NOT NULL COMMENT 'Das Feld enthält die Nummer einer Fakturaposition und dient zusammen mit der Fakturabeleg ID  der eindeutigen Identifikation der Fakturabelegpositionen.',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1',
   wup_id                              INTEGER     NOT NULL COMMENT 'Die Wup_id entspricht der Nummer des Werks/Betriebs. Dabei kann es sich entweder um ein Verteilzentrum, ein Lager oder einen Markt handeln. Zusammen mit der nb_id kann ein Eintrag aus der DWH Tabelle wup eindeutig identifiziert werden. SAP RET - VBPA - KUNNR',
   nb_id                               INTEGER     NOT NULL COMMENT 'Die nb_id identifiziert die Nebenbetriebe (z.B. Tankstelle, Backshop, usw.) für einen Betrieb/Werk (= wup_id).',
   lagerort_id                         VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Dieses Feld referenziert die DWH Tabelle Lagerort.
            
            ',
   verrechnung_betrag                  NUMBER(29,4)     COMMENT 'Verrechnungswert einer Position in einem lieferbezogenen Fakturabeleg. Der Verrechnungswert wird bei der Buchung des Warenausgangs ermittelt. Aus wavwr',
   zwsum_1_betrag                      NUMBER(29,4)     COMMENT 'Konditionszwischensumme 1 aus dem Kalkulationsschema. Dies entspricht dem End Betrag des Schemas.',
   zwsum_2_betrag                      NUMBER(29,4)     COMMENT 'Konditionszwischensumme 2 aus dem Kalkulationsschema. Dies entspricht dem Verkaufspreis.',
   zwsum_3_betrag                      NUMBER(29,4)     COMMENT 'Konditionszwischensumme 3 aus dem Kalkulationsschema. Dies entspricht dem Einkaufspreis Netto bei Reklamationen (Einkaufspreis netto  bzw. EK-Aktion netto vermindert um die Reklapauschale).',
   zwsum_4_betrag                      NUMBER(29,4)     COMMENT 'Konditionszwischensumme 4 aus dem Kalkulationsschema. Dies entspricht dem Lagerwert bei Reklamationen (Reklapauschale)',
   zwsum_5_betrag                      NUMBER(29,4)     COMMENT 'Konditionszwischensumme 5 aus dem Kalkulationsschema. Dies entspricht dem Verkaufswert bei Reklamationen.',
   zwsum_6_betrag                      NUMBER(29,4)     COMMENT 'Konditionszwischensumme 6 aus dem Kalkulationsschema. Dies entspricht dem Wert der Logistikvergütung für diese Position.',
   menge_faktura_bme                   NUMBER(29,3)     NOT NULL COMMENT 'Fakturierte Menge der Fakturabelegposition.',
   aktion_id                           VARCHAR(10)      COLLATE 'en-ci' COMMENT 'Nummer zur Identifizierung einer Aktion, für die beschafft werden soll. Sie können pro Position eines Einkaufsbelegs eingeben, zu welcher Aktion die Position gehört.',
   verk_menge_einh_id                  VARCHAR(3)       NOT NULL COMMENT 'Dieses Feld enthält die Mengenheiheit für die Berechnung der Basismenge in die alternative Mengeneinheit (Verkaufsmenge). Dazu ist der Umrechnungsfaktor aus der DWH Tabelle art_umrechnung_faktor_per pro Material zu ermitteln.',
   menge_faktura_kolli                 NUMBER(29,3)     NOT NULL COMMENT 'Dieses Feld enthält die Menge in der Kollimengeneinheit. Der gültige Umrechnungsfaktor wird aus der DWH Tabelle art_umrechnung_faktor_per ermittelt.',
   menge_faktura_palette               NUMBER(29,3)     COMMENT 'Dieses Feld enthält die Menge in der Palettenmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per und art_umrechnung_faktor_per ermittelt.',
   dat_leist_erstellung                DATE             NOT NULL COMMENT 'Datum der Leistungserstellung.     
            ',
   vorlage_beleg_id                    INTEGER     NOT NULL COMMENT 'Belegnummer des Vorlagebeleges',
   vorlage_beleg_pos_id                INTEGER     NOT NULL COMMENT 'Positionsnummer des Vorlagebelegs',
   best_beleg_id                       INTEGER     NOT NULL COMMENT 'Das Feld enthält die Beleg ID der Bestellung und dient der eindeutigen Identifikation der Bestellbelege.
            (Dieses Feld hat momentan keine Werte, zukünftig soll dies die Referenz zu der Bestellung ermöglichen)',
   best_beleg_pos_id                   INTEGER     NOT NULL COMMENT 'Das Feld enthält die Nummer einer Bestellposition und dient zusammen mit der Bestellbelet ID  der eindeutigen Identifikation der Bestellbelegpositionen.
            (Dieses Feld hat momentan keine Werte, zukünftig soll dies die Referenz zu der Bestellung ermöglichen',
   dat_faktura_sap                     DATE             NOT NULL COMMENT 'Das Original - Fakturadatum aus SAP. Gehört logisch nur in die Kopftabelle und ist aus historischen Gründen hier gespeichert',
   auftrag_grund_id                    VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Dieses Attribut gibt den Grund für die Erstellung des Verkaufsbelegs an. Referenz zu der Tabelle l_auftrag_grund',
   dat_faktura                         DATE             NOT NULL COMMENT 'Abhängig von der Fakturaart ist hier entweder das Fakturadatum oder das Datum der Leistungserstellung hinterlegt Das Feld wird aus der Kopftabelle "vererbt", um einen PPI darüber bilden zu können (Performance!)',
   zwsum_8_betrag                      NUMBER(29,4)     COMMENT 'Enthält den Rabattbetrag  bezogen auf den VK im Fall von teilkostenloser Lieferung.',
   zwsum_9_betrag                      NUMBER(29,4)     COMMENT 'Enthält den Rabattbetrag - bezogen auf den EK - im Fall von teilkostenloser Lieferung. Format decimal(18,2) Compress CD-47-AD-36-C7-B7-B2-2A-FF-C7-61-09-CC-15-E3-DD',
   bestellart_id                       VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Die Bestellart wurde in diese Tabelle einbezogen, um teilkostenlose Lieferungen aus den Fakturen bestimmen zu können. Eigenstlich gehört die Bestellart zu den Bestellungen (besch_best)',
   menge_faktura_kg                    NUMBER(29,3)     COMMENT 'Die fakturierte Mengen in Kilogramm. Entspricht bei Gewichtsware der Column menge_fakturiert, wird bei Stückware berechnet. Redundantes Feld aus Performancegründen für einen! Bericht Fakturaliste Wurst',
   dat_preisfindung                    DATE             COMMENT 'Datum für Preisfindung und Währungskurs, kann vom Fakturadatum abweichen',
   mwst                                NUMBER(29,2)      COMMENT 'Mehrwertsteuersatz. Wird aus Performancegründen hier redundant gespeichert. Datenformat mit Absicht abweichend von der Tabelle mwst',
   ek_netto_bnk                        NUMBER(29,4)     COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten. Enthält den Aktionspreis, wenn vorhanden, sonst den Normalpreis.',
   ek_mep                              NUMBER(29,4)     COMMENT 'Markteinstandspreis (Bedeutung vgl. Kalkulationsschema).',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   betrag_ek_mep_vor_fwu               NUMBER(29,5)     COMMENT 'Menge * Markteinstandspreis ohne Logistikkosten inkl. Handlingkosten. Quellfeld: ZEKP.MEPOL.',
   betrag_logkostenzuschlag            NUMBER(29,5)     COMMENT 'Menge * Logistikkostenzuschlag (ZEKP.LOKAU).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_FAKTURA_DET PRIMARY KEY (mandant_id, faktura_beleg_id, faktura_beleg_pos_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - In dieser Tabelle sind die Fakturabelegpositionen aus der SAP Tabelle VBRP enhalten  nur für Mandant 1. Die dazugehörigen Kopfinformationen befinden sich in der DWH Tabelle FAKTURA.';
