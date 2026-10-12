--==============================================================
-- Table: tms_auftrag
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_auftrag
   generated from Powerdesigner on Donnerstag, 24. April 2025 10:38:45
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_AUFTRAG (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_auftrag_id                      VARCHAR(30)      NOT NULL COMMENT 'ID des Auftrags (Auftragsnummer). Aus plau.au_nr',
   tms_auftrag_unter_id                INTEGER     NOT NULL COMMENT 'Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. Aus plau.au_unter_nr',
   tms_auftrag_lfd_nr                  INTEGER     NOT NULL COMMENT 'SKey für die Tabelle tms_auftrag im Quellsystem. Aus plau.id_auftrag',
   lief_beleg_id                       NUMBER(29,0)     COMMENT 'die Beleg ID des Lieferscheins',
   kj_lief_beleg                       INTEGER     COMMENT 'Kalenderjahr aus LFDAT. Lookup in besch_lief, -1 für keinen Treffer',
   versandstelle_id                    VARCHAR(4)       COMMENT 'Versandstelle',
   tms_sortiment_id                    INTEGER     COMMENT 'Artikelsortiment. IDs weichen teilw. von SAP ab!',
   lieferkunde_tms_gp_id               VARCHAR(30)      COMMENT 'ID des tms_gp, welcher hier als Lieferkunde auftrifft',
   lieferkunde_tms_gp_typ_cd           VARCHAR(3)       COMMENT 'Code für den tms_gp-Typ, welcher hier als Lieferkunde auftrifft',
   auftragstext_1                      VARCHAR(100)     COMMENT 'Auftragstext, der kundenspezifisch verwendet wird',
   auftragstext_2                      VARCHAR(100)     COMMENT 'Auftragstext, der kundenspezifisch verwendet wird',
   auftragstext_3                      VARCHAR(100)     COMMENT 'Auftragstext, der kundenspezifisch verwendet wird',
   tms_auftragsart_id                  INTEGER     COMMENT 'Art des Auftrags',
   beladestelle_tms_gp_id              VARCHAR(30)      COMMENT 'ID des tms_gp, welcher hier als Beladestelle auftrifft',
   beladestelle_tms_gp_typ_cd          VARCHAR(3)       COMMENT 'Code für den tms_gp-Typ, welcher hier als Beladestelle auftrifft',
   dat_best                            DATE             COMMENT 'Bestelldatum',
   empfaenger_tms_gp_id                VARCHAR(30)      COMMENT 'ID des tms_gp, welcher hier als Empfänger auftrifft',
   empfaenger_tms_gp_typ_cd            VARCHAR(3)       COMMENT 'Code für den tms_gp-Typ, welcher hier als Empfänger auftrifft',
   entladestelle_tms_gp_id             VARCHAR(30)      COMMENT 'ID des tms_gp, welcher hier als Entladestelle auftrifft',
   entladestelle_tms_gp_typ_cd         VARCHAR(3)       COMMENT 'Code für den tms_gp-Typ, welcher hier als Entladestelle auftrifft',
   quellsystem_name                    VARCHAR(20)      COMMENT 'Datenherkunft aus der Schnittstelle (z. B. EWM, LES)',
   liefergebiet_txt                    VARCHAR(10)      COMMENT 'Liefergebiet (Geographisch lassen sich Kunden in Gebiete ähnlich Postleitzahlengebieten einteilen)',
   tms_land_cd                         VARCHAR(5)       COMMENT 'Länderkennzeichen des Lieferkunden',
   tms_lieferart_id                    VARCHAR(3)       COMMENT 'Art der Lieferung; 0 = Normal, 1 = via CD, 2 = ???',
   dat_lief                            DATE             COMMENT 'Lieferdatum',
   plan_status_cd                      VARCHAR(3)       COMMENT 'Planungsstatus (z.B. ''H'' für hochgesetzt, ''T'' auf Tour)',
   sender_name                         VARCHAR(12)      COMMENT 'Versender (kein TMS-GP sondern z. B. ERP)',
   tms_tour_id                         INTEGER     COMMENT 'Tournummer',
   dat_tour                            DATE             COMMENT 'Tourdatum',
   tms_tour_pos_id                     INTEGER     COMMENT 'Entladetourposition, gibt die Reihenfolge an in der z. B. die Märkte angefahren werden sollen',
   versender_tms_gp_id                 VARCHAR(30)      COMMENT 'ID des tms_gp, welcher hier als Versender auftrifft',
   versender_tms_gp_typ_cd             VARCHAR(3)       COMMENT 'Code für den tms_gp-Typ, welcher hier als Versender auftrifft',
   temperaturgruppe_id                 INTEGER     COMMENT 'Temperaturgruppe des Auftrags.  0 = Nicht gesetzt, 1 = TK (Tiefgekühlt), 2 = GK (Gekühlt), 3 = TE (Temperiert), 4 = UK (Ungekühlt), 5 = TB (Thermobehälter)',
   gewicht_brutto_kg                   NUMBER(29,2)     COMMENT 'Manuell erfasstes Frachtgewicht.',
   gewicht_netto_kg                    NUMBER(29,2)     COMMENT 'Gesamt Gewicht des Auftrags.',
   anz_stellplatz                      NUMBER(29,2)     COMMENT 'Stücke / Einheiten an Stellplätzen des gesamten Auftrags.',
   vorholspedition_tms_gp_id           VARCHAR(30)      COMMENT 'Geschäftspartner ID der Vorholspedition. Die Vorholspedition sammelt alles von den Beladestellen ein, ggf. an unterschiedlichen Adressen.',
   vorholspedition_tms_gp_typ_cd       VARCHAR(3)       COMMENT 'Art der Vorholspedition.',
   tms_auftrag_orig_id                 VARCHAR(30)      COMMENT 'Original Auftragsnummer inklusive aller Zeichen (alphanumerisch und Sonderzeichen), falls vorhanden.',
   best_beleg_id                       INTEGER     COMMENT 'ID des Bestellbelegs, bezieht sich auf in Wanko angelegte Aufträge.',
   tms_auftrag_status_cd               VARCHAR(20)      COMMENT 'Status der Auftragshostkommunikation: 10 = offen; 20 = in Bearbeitung; 30 = disponierbar; 40 = disponiert; 50 = avisiert; 60 = teilweise geliefert; 70 = geliefert; 99 = gelöscht.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_AUFTRAG PRIMARY KEY (mandant_id, system_id, tms_auftrag_id, tms_auftrag_unter_id) NOT ENFORCED
)  COMMENT = 'TMS - Die Tabelle enthält die relevanten Informationen zu einem Distributionsauftrag, einschließlich Auftragsart, Lieferdatum, Lieferkunde, entsprechende TMS-Tour-Detail-Bezeichnung und beteiligte Geschäftspartner. Aus Quelle plau (WANKO)';
