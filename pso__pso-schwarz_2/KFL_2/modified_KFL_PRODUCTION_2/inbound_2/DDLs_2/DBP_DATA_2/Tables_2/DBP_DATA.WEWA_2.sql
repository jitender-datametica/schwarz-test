--==============================================================
-- Table: wewa_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wewa_2
   generated from Powerdesigner on Montag, 20. November 2023 17:57:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WEWA_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wewa_beleg_id                       INTEGER     NOT NULL COMMENT 'Belegnummer aus dem entsprechenden Satz der Tabelle best_belegfluss_2 (dort  Referenzbeleges au lfbnr)',
   wewa_beleg_pos_id                   INTEGER     NOT NULL COMMENT 'Belegposition aus dem entsprechenden Satz der Tabelle best_belegfluss_2 (dort  aus lfpos)',
   wewa_jahr                           INTEGER     NOT NULL COMMENT 'Belegjahr aus dem entsprechenden Satz der Tabelle best_belegfluss_2 (dort  aus lfgja)',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   lager_bewart_id                     VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Schlüssel der Bewegungsarten der Lagerbewegung. Aus der Tabelle best_belegfluss_2 übernommen.',
   dat_buch                            DATE             NOT NULL COMMENT 'Buchungsdatum des Beleges. Aus best_belegfluss_2 übernommen, dort aus budat',
   menge_basis                         NUMBER(29,3)     NOT NULL COMMENT 'Menge in Basismeingeneinheit aus best_belegfluss_2 ( menge)',
   betrag_ek_netto                     NUMBER(29,4)     COMMENT 'Mit dem ek_netto (Rechnungs-Einkaufspreis) bewertete Warenmenge: menge_basis * ek_netto.',
   status_2                              INTEGER     NOT NULL COMMENT 'Status_2 analog bsch_rech_det_2, wirdbei Versorgung ermittelt: endgültig 3, gelöscht 2, vorläufig 1',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   betrag_vk_netto                     NUMBER(29,2)     NOT NULL COMMENT 'entspricht dem Attribut vkwra aus der Tabelle mseg',
   konditionsbetrag_zar5               NUMBER(29,4)     COMMENT 'Umsatz Betrag bei Konditionsart ZAR5 (Akt. Art. Rab.5 in %)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WEWA PRIMARY KEY (mandant_id, wewa_beleg_id, wewa_beleg_pos_id, wewa_jahr) NOT ENFORCED
)  COMMENT = 'AIS_KMO - Aggregat zur Darstellung des Umsatzes mit Lieferanten aus Rechnungen und wenn noch keine Rechnung vorhanden ist aus  Wareneingängen. Quelle ist die Tabelle ekbe(best_belegfluss_2)';
