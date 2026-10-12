--==============================================================
-- Table: best_offen_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_offen_2
   generated from Powerdesigner on Montag, 6. Februar 2023 14:31:21
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BEST_OFFEN_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH.',
   best_beleg_id                       NUMBER(18,0)     NOT NULL COMMENT 'Belegnummer des Einkaufsbelegs.',
   best_beleg_pos_id                   NUMBER(38,0)     NOT NULL COMMENT 'Positionsnummer des Einkaufsbelegs.',
   wup_id                              NUMBER(38,0)     COMMENT 'Der "WUP_2" beinhaltet Märkte und Läger. WUP_2 = WarenUmschlagsPlatz. Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   nb_id                               NUMBER(38,0)     COMMENT 'Nebenbetrieb. Im bisherigen System die 4 Stelle der Marktnummer.',
   gp_id                               NUMBER(38,0)     COMMENT 'Geschäftspartner-ID (Lieferanten-ID).',
   art_id                              NUMBER(38,0)     COMMENT 'Input: Artikel_2 - Id einschließlich der Generationen-ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige Artikel_2-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1.',
   dat_best_beleg                      DATE             COMMENT 'Datum des Bestellbelegs',
   dat_lief_wunsch                     DATE             COMMENT 'Wunschlieferdatum (EINDT).',
   kunde_id                            NUMBER(38,0)     COMMENT 'Warenempfänger (Marktnummer).',
   nb_id_kunde                         NUMBER(38,0)     COMMENT 'Nebenbetrieb Warenempfänger. Im bisherigen System die 4 Stelle der Marktnummer.',
   einkaufsorganisation_id             NUMBER(38,0)     COMMENT 'Einkaufsorganisation.',
   einkaeufer_grp_id                   VARCHAR(3)       COMMENT 'Einkäufergruppe.',
   menge_best                          NUMBER(13,3)     COMMENT 'Bestellmenge.',
   menge_einh_id                       VARCHAR(3)       COMMENT 'Basismengeneinheit.',
   menge_lief_ist                      NUMBER(13,3)     COMMENT 'Tatsächlich gelieferte Menge in VME.',
   endlief_fg                          NUMBER(38,0)     COMMENT 'Endlieferungskennzeichen.',
   menge_offen                         NUMBER(13,3)     COMMENT 'Offene Menge.',
   bestellart_id                       VARCHAR(4)       COMMENT 'Bestellart.',
   dat_generierung                     DATE             COMMENT 'Generierungsdatum.',
   block_stock_fg                      NUMBER(38,0)     COMMENT 'Block Stock Flag.',
   cpo_fg                              NUMBER(38,0)     COMMENT 'Collective Purchase Orders Flag.',
   best_aend_kz                        VARCHAR(1)       COMMENT 'Lösch- / Änderungskennzeichen für die Bestellposition. L wenn die Bestellposition gelöscht wurde, D wenn das Lieferdatum geändert wurde, sonst NULL.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BEST_OFFEN PRIMARY KEY (mandant_id, best_beleg_id, best_beleg_pos_id) NOT ENFORCED
)  COMMENT = 'Enthält offene Bestellungen auf Ebene Bestellposition aus ZEK_OPENORDER.';
