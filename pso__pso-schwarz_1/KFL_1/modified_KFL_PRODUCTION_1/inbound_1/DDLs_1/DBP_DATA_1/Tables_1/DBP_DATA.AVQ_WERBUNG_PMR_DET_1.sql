--==============================================================
-- Table: avq_werbung_pmr_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: avq_werbung_pmr_det_1
   generated from Powerdesigner on Mittwoch, 8. Oktober 2025 08:32:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AVQ_WERBUNG_PMR_DET_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer.',
   art_id                              INTEGER     NOT NULL COMMENT 'Input: Artikel_1 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1.',
   dat_aktion_von                      DATE             NOT NULL COMMENT 'Werbung/Aktion_1 gültig ab',
   dat_aktion_bis                      DATE             NOT NULL COMMENT 'Werbung/Aktion_1 gültig bis',
   angebot_nr                          VARCHAR(50)      NOT NULL COMMENT 'Nummer des Angebots aus PMR',
   werbemittelkanal_id                 VARCHAR(4)       NOT NULL COMMENT 'Werbemittel Art_1 ID - medium through which the advertisement is shown (paper, digital)',
   werbemittel_id                      VARCHAR(2)       NOT NULL COMMENT 'Werbemittel - on what item_1 the advertisement is shown (for example leaflet, magazine for Paper Medium, pop-up banner for digital)',
   werbeflaechenthema_cd               VARCHAR(50)      NOT NULL COMMENT 'Code des Werbeflaechenthemas',
   werbeflaechenabschnitt_id           INTEGER     NOT NULL COMMENT 'ID des Werbeflächenabschnitts',
   aktion_id                           VARCHAR(10)      NOT NULL COMMENT 'Eindeutige Kennung einer Aktion_1 aus der Quelle wakh.aktnr',
   dat_sperrung                        INTEGER     COMMENT 'Datum, zu dem ein Artikel_1 gesperrt wurde. Aus aktion_art_wup_zu_1',
   dat_preisaktivierung                DATE             COMMENT 'Datum der Aktionspreisaktivierung. Aus aktion_art_wup_zu_1',
   dat_geloescht_sap                   DATE             COMMENT 'Datum der Löschung. Aus aktion_art_wup_zu_1',
   kjwo                                INTEGER     COMMENT 'Kalenderjahreswoche. Format JJJJWW. Fuer DE die Woche_1, in der die Werbung endet. Fuer KMO die Woche_1, in der die Werbung beginnt.',
   bby_fg                              INTEGER     COMMENT 'Flag: Bonusbuy',
   kdn_fg                              INTEGER     COMMENT 'Flag: KDN-Aktion_1 (K-CARD)',
   kdp_fg                              INTEGER     COMMENT 'Flag: KDP-Aktion_1 (Kundenindividuell)',
   pmr_top_art_fg                      INTEGER     NOT NULL COMMENT 'TOP-Artikel_1 Flag (PMR)',
   werbemittel_avq_prio_nr             INTEGER     COMMENT 'Für die AVQ können verschiedene Werbemittel zusammengefasst werden, ID gibt die Reihenfolge / Priorisierung vor',
   werbeflaechenabschnitt_avq_prio_nr  INTEGER     COMMENT 'Bezeichnung des Werbeflaechenthemas (AVQ)',
   werbeflaechenthema_avq_prio_nr      INTEGER     COMMENT 'Für die AVQ können verschiedene Werbeflächenthemen zusammengefasst und/oder priorisiert werden, ID gibt die Reihenfolge vor',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AVQ_WERBUNG_PMR_DET PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, dat_aktion_von, dat_aktion_bis, angebot_nr, werbemittelkanal_id, werbemittel_id, werbeflaechenthema_cd, werbeflaechenabschnitt_id) NOT ENFORCED
)  COMMENT = 'AVQ(Abverkaufsquote) PMR-Details - Zusatzebene, enthält alle relevanten Aktionen sowie Angebote(Offers) im Aktionszeitraum inkl. aller zugeordneter Werbemittel/Flächen/Abschnitte.';
