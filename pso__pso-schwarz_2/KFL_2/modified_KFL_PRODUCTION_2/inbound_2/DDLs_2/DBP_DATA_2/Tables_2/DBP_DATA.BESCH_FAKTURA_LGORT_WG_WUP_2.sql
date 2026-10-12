--==============================================================
-- Table: besch_faktura_lgort_wg_wup_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_faktura_lgort_wg_wup_2
   generated from Powerdesigner on Montag, 19. September 2022 08:03:27
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_FAKTURA_LGORT_WG_WUP_2 CLUSTER BY (DAT_FAKTURA)(
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER    NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER    NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   lagerort_id                         VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Dieses Feld referenziert die DWH Tabelle Lagerort.',
   wg_id                               INTEGER    NOT NULL COMMENT 'ID der Warengruppe',
   fakturaart_id                       VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'Klassifiziert verschiedene Arten von Fakturabelegen, die eine_2 unterschiedliche Verarbeitung durch das System erfordern.',
   dat_faktura                         DATE            NOT NULL COMMENT 'Hier ist abhängig von der Fakturaart entweder das Fakturadatum oder das Datum der Leistungserstellung enthalten',
   dat_erstellung                      DATE            NOT NULL COMMENT 'Das Feld enthält das Erstelldatum des Datensatzes',
   dat_leist_erstellung                DATE            NOT NULL COMMENT 'Datum der Leistungserstellung.     
            ',
   arthiertyp_id                       INTEGER    NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   auftraggeber_id                     VARCHAR(10)     NOT NULL COMMENT 'Kundennummer des Auftaggebers. Noch keine Referenz zu einer bestehenden DWH Tabelle möglich (SAP Quellel KNA1_2)',
   bestellart_id                       VARCHAR(4)      COLLATE 'en-ci' COMMENT 'ID der Bestellart',
   dat_preisfindung                    DATE            COMMENT 'Datum für Preisfindung und Währungskurs, kann vom Fakturadatum abweichen',
   auftrag_grund_id                    VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'Grund für die Erstellung eines Verkaufsbelegs',
   verrechnung_betrag                  NUMBER(29,2)    COMMENT 'Verrechnungswert einer Position in einem lieferbezogenen Fakturabeleg. Der Verrechnungswert wird bei der Buchung des Warenausgangs ermittelt.Format decimal(18,2). Aus wavwr',
   zwsum_1_betrag                      NUMBER(29,2)    COMMENT 'Konditionszwischensumme 1 aus dem Kalkulationsschema. Dies entspricht dem End Betrag des Schemas. Format decimal(18,2)',
   zwsum_2_betrag                      NUMBER(29,2)    COMMENT 'Konditionszwischensumme 2 aus dem Kalkulationsschema. Dies entspricht dem Verkaufspreis. Format decimal(18,2)',
   zwsum_3_betrag                      NUMBER(29,2)    COMMENT 'Konditionszwischensumme 3 aus dem Kalkulationsschema. Dies entspricht dem Einkaufspreis Netto bei Reklamationen (Einkaufspreis netto  bzw. EK-Aktion_2 netto vermindert um die Reklapauschale). Format decimal(18,2)',
   zwsum_4_betrag                      NUMBER(29,2)    COMMENT 'Konditionszwischensumme 4 aus dem Kalkulationsschema. Dies entspricht dem Lagerwert bei Reklamationen (Reklapauschale) Format decimal(18,2)',
   zwsum_5_betrag                      NUMBER(29,2)    COMMENT 'Konditionszwischensumme 5 aus dem Kalkulationsschema. Dies entspricht dem Verkaufswert bei Reklamationen. Format decimal(18,2)',
   zwsum_6_betrag                      NUMBER(29,2)    COMMENT 'Konditionszwischensumme 6 aus dem Kalkulationsschema. Dies entspricht dem Wert der Logistikvergütung für diese Position. Format decimal(18,2)',
   zwsum_8_betrag                      NUMBER(29,2)    COMMENT 'Enthält den Rabattbetrag  bezogen auf den VK_2 im Fall von teilkostenloser Lieferung. Format decimal(18,2)',
   zwsum_9_betrag                      NUMBER(29,2)    COMMENT 'Enthält den Rabattbetrag - bezogen auf den EK - im Fall von teilkostenloser Lieferung. Format decimal(18,2) Compress CD-47-AD-36-C7-B7-B2-2A-FF-C7-61-09-CC-15-E3-DD',
   vk_netto_betrag                     NUMBER(29,2)    COMMENT 'zwsum_2_betrag reduziert um MWSt-Betrag',
   vk_netto_rekl_tkl_betrag            NUMBER(29,2)    COMMENT 'Summe aus zwsum2 + zwsum5 + zwsum8, reduziert um die MWSt',
   menge_faktura_kolli                 NUMBER(29,3)    COMMENT 'Dieses Feld enthält die Menge in der Kollimengeneinheit. Der gültige Umrechnungsfaktor wird aus der DWH Tabelle art_umrechnung_faktor_per_2 ermittelt',
   menge_faktura_palette               NUMBER(29,3)    COMMENT 'Dieses Feld enthält die Menge in der Palettenmengeneinheit. Der erforderliche Umrechnungsfaktor wird aus den DWH Tabellen art_vorschlagswert_per_2 und art_umrechnung_faktor_per_2 ermittelt.',
   menge_faktura_bme                   NUMBER(29,3)    COMMENT 'Fakturierte Menge der Fakturabelegposition.',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_FAKTURA_LGORT_WG_WUP PRIMARY KEY (mandant_id, wup_id, nb_id, lagerort_id, wg_id, fakturaart_id, dat_faktura, dat_erstellung, dat_leist_erstellung, arthiertyp_id, auftraggeber_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - Diese Tabelle enthält die nach Warengruppe, VZ und Lagerort aggregierten Fakturabelege.';
