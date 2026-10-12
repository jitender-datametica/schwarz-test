--==============================================================
-- Table: bsch_rech_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: bsch_rech_det_1
   generated from Powerdesigner on Montag, 21. Juli 2025 05:50:00
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BSCH_RECH_DET_1 CLUSTER BY (
     WUP_ID,
     DAT 
) (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   bsch_id                             INTEGER     NOT NULL COMMENT 'WE-/WA-ID - numerisch',
   bsch_pos_id                         INTEGER     NOT NULL COMMENT 'Positions-ID   -  numerisch',
   dat                                 DATE             NOT NULL COMMENT 'Bezugsdatum',
   bewart_id                           INTEGER     NOT NULL COMMENT 'Bewegungsart ID wird hier - leider! in einem anderen Sinn als im übrigen Datenmodell verwendet - hier: Typ der Wareneingangsbewegung WE/WA 1, BA = 2, RBA = 3',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   gp_id                               INTEGER     NOT NULL COMMENT '6 stellige Lieferanten-ID (ohne Pfandpositionen in Detailtabelle)',
   ba_id                               INTEGER     COMMENT 'Bela-/Rückbela-ID   numerisch
            = 0 bei WE/WA
            ',
   ba_pos_id                           INTEGER     COMMENT 'Bela-/Rückbela-Positions-ID   numerisch
            = 0 bei WE/WA 
            ',
   menge_rech                          NUMBER(29,3)     COMMENT 'den Umsatz betreffende Menge',
   ek_n                                NUMBER(29,4)     COMMENT 'EK-Netto-Umsatz für den Artikel.',
   ek_nn                               NUMBER(29,4)     COMMENT 'Netto Netto Umsatz Gesamt für den Artikel.',
   status_1                              INTEGER     COMMENT 'Status_1: endgültig 3, gelöscht 2, vorläufig 1',
   einkaufsorganisation_id             INTEGER     COMMENT 'Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen',
   vk_n                                NUMBER(29,4)     COMMENT 'VK_1-Netto-Umsatz',
   ek_mep                              NUMBER(29,4)     COMMENT 'EK-Mep-Umsatz für den Artikel.',
   ek_kb                               NUMBER(29,4)     COMMENT 'EK-Kalkulationsbasis-Umsatz für den Artikel.',
   diff_menge_rech_we                  NUMBER(29,3)     NOT NULL COMMENT 'Bei endgültigen Belegen wird hier die Differenz zur Menge des letzten vorläufigen Belegs gespeichert',
   diff_ek_n_we                        NUMBER(29,4)     NOT NULL COMMENT 'Bei endgültigen Belegen wird hier die Differenz zum EKnetto des letzten vorläufigen Belegs gespeichert',
   diff_vk_n_we                        NUMBER(29,4)     NOT NULL COMMENT 'Bei endgültigen Belegen wird hier die Differenz zum VKnetto des letzten vorläufigen Belegs gespeichert',
   lagerort_id                         VARCHAR(4)       COLLATE 'en-ci' COMMENT 'Schlüssel für die Lagerorte. Die Lagerorte sind pro Werk/Betrieb eindeutig. Aus lgort',
   lager_bewart_id                     VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Schlüssel der Bewegungsarten der Lagerbewegung. Datentyp abweichend von der lookup-Tabelle gewählt',
   logkosten                           NUMBER(29,4)     COMMENT 'enthält Logistikkosten (menge aus bsch_rech_det_1 * logistikkostenzuschlag aus art_gp_wup_zu_per_1)',
   wrg_id                              VARCHAR(3)       COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   betrag_ek_mep_vor_fwu               NUMBER(29,5)     COMMENT 'Menge * Markteinstandspreis ohne Logistikkosten inkl. Handlingkosten. Quellfeld: ZEKP.MEPOL.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BSCH_RECH_DET PRIMARY KEY (mandant_id, bsch_id, bsch_pos_id, dat, bewart_id, art_id, wup_id, nb_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Wareneingänge auf Positionsebene';
