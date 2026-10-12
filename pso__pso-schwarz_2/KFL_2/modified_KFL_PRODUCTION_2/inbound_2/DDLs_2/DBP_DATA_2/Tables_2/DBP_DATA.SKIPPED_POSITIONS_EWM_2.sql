--==============================================================
-- Table: skipped_positions_ewm_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: skipped_positions_ewm_2
   generated from Powerdesigner on Thursday, June 9, 2022 10:14:10 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.SKIPPED_POSITIONS_EWM_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH.',
   lagernummer_id                      VARCHAR(4)      NOT NULL COMMENT 'ID der Lagernummer - hoechste Ebene der Lagerhierarchie.',
   lagerauftrag_id                     INTEGER    NOT NULL COMMENT 'Lagerauftrag_2 ID.',
   lageraufgabe_id                     INTEGER    NOT NULL COMMENT 'Lageraufgabe_2 ID.',
   lageraufgabe_pos_id                 INTEGER    NOT NULL COMMENT 'Lageraufgabe_2 Position ID.',
   lagersortiment_id                   VARCHAR(1)      COMMENT 'Lagersortiment ID.',
   lagerauftrag_status_id              VARCHAR(1)      COMMENT 'Lagerauftrag_2 Status_2 ID.',
   lageraufgabe_status_id              VARCHAR(1)      COMMENT 'Lageraufgabe_2 Status_2 ID.',
   lagerprozessart_id                  VARCHAR(4)      COMMENT 'Lagerprozessart ID.',
   artikelsortiment_id                 VARCHAR(1)      COMMENT 'Artikelsortiment ID.',
   lief_beleg_id                       INTEGER    COMMENT 'Das Feld enthält die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.',
   lief_beleg_pos_id                   INTEGER    COMMENT 'Das Feld enthaelt die Nummer einer Lieferscheinposition und dient zusammen mit der Lieferscheinbeleg ID der eindeutigen Identifikation der Lieferscheinbelegpositionen.',
   lief_pal_typ_id                     VARCHAR(2)      COMMENT 'Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine_2 Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt etc. handelt.',
   ewm_gv_grp_id                       VARCHAR(4)      COMMENT 'Gruppe_2 des Geschaeftsvorfalls.',
   ewm_exc_kategorie_id                VARCHAR(1)      COMMENT 'Exception Kategorie ID (Ebene Lageraufgabe_2/Position).',
   lagerauftrag_has_exc_1_fg           INTEGER    COMMENT 'Flag: Lagerauftrag_2 hat min. eine_2 Lageraufgabe_2/Position mit Exception Kategorie 1.',
   lagerauftrag_has_exc_2_fg           INTEGER    COMMENT 'Flag: Lagerauftrag_2 hat min. eine_2 Lageraufgabe_2/Position mit Exception Kategorie 2.',
   lagerauftrag_has_exc_3_fg           INTEGER    COMMENT 'Flag: Lagerauftrag_2 hat min. eine_2 Lageraufgabe_2/Position mit Exception Kategorie 3.',
   dat_lief_soll                       DATE            COMMENT 'Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann für den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschaetzungen errechnen.',
   wg_verkett_lief                     INTEGER    COMMENT 'Die Warengruppenverkettung gibt an, welche Artikel_2 gemeinsam auf eine_2 Palette gepackt werden.',
   werbeware_id                        VARCHAR(1)      COMMENT 'Wird gefuellt, wenn die Bestellart eine_2 Werbebestellart ist. Wertevorrat:
            W     Werbung      
            N      Normalware   
            B      W und N      
            S      Schnellschuss',
   art_id                              INTEGER    COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
   ausnahme_code                       VARCHAR(4)      COMMENT 'Ausnahme_2-Code.',
   bus_kontext                         VARCHAR(3)      COMMENT 'Business Kontext.',
   ausfuehr_schritt_id                 VARCHAR(2)      COMMENT 'Ausfuehrungsschritt im Business-Kontext.',
   menge_ist_bme                       NUMBER(38,14)   COMMENT 'Ist-Menge in Basismengeneinheit.',
   manuell_erzeugt_fg                  INTEGER    COMMENT 'Flag: Manuell erzeugt.',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_SKIPPED_POSITIONS_EWM PRIMARY KEY (mandant_id, lagernummer_id, lagerauftrag_id, lageraufgabe_id, lageraufgabe_pos_id) NOT ENFORCED
)  COMMENT = 'EWM Skipped Positions.';
