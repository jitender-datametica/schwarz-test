--==============================================================
-- Table: ts_wbs_art_aktion_markt_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_art_aktion_markt_2
   generated from Powerdesigner on Donnerstag, 5. Februar 2026 14:23:18
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TS_WBS_ART_AKTION_MARKT_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikelnummer',
   aktion_id                           VARCHAR(10)      NOT NULL COMMENT 'Aktionsnummer',
   angebot_nr                          VARCHAR(50)      NOT NULL COMMENT 'Numerische oder Alphanumerische Nummer des Angebots',
   dat_von                             DATE             NOT NULL COMMENT 'Gültig von',
   dat_bis                             DATE             NOT NULL COMMENT 'Gültig bis',
   gk_fg                               NUMBER(38,0)     COMMENT 'Flag: Gondelkopf',
   menge_mindestplatzierung_bme        NUMBER(38,3)     COMMENT 'Menge Mindestplatzierung in BME',
   top_gk_fg                           NUMBER(38,0)     COMMENT 'Flag: Top_Gondelkopf',
   fixmenge_wfl_bme                    NUMBER(38,3)     COMMENT 'Fixmenge Warenfluss',
   adjustment_id                       NUMBER(38,0)     COMMENT 'Mit der Adjustment_ID kann der Benutzer entscheiden, auf welche Weise die Nachversorgung in WBS TP1 berechnet werden soll.
            0 = UDF&R: UDF berechnet die Prognosen und übergibt sie an F&R
            1 = Standard adjustment (WBS): WBS berechnet die Nachversorgungsmenge und stellt sie den Benutzern als PREX-Upload zur Verfügung.
            2 = Platzhalter (Stand 28.03.2025)
            3 = External adjustment: Die SAP Autodispo errechnet keine Mengen. In diesem Fall ist eine_2 manuelle Bestellanlage durch das Land_2 notwendig. ',
   max_kapa_fg                         NUMBER(38,0)     COMMENT 'Flag: Max. Kapa.',
   dat_letzte_nachversorgung           DATE             COMMENT 'Datum letzte Nachversorgung.',
   max_kapa_endbestand_proz            NUMBER(38,3)     COMMENT 'Max. Kapa für Endbestand in %',
   rest_von_normalbestand_proz         NUMBER(38,3)     COMMENT 'Restbestand in % vom Normalbestand',
   kjwo                                NUMBER(38,0)     COMMENT 'Kalenderwoche Aktionsstart.',
   nachversorgung_schwellwert_pal_abrundung_proz NUMBER(38,3)     COMMENT 'WBS Nachversorgung: Paletten Abrundung Schwellwert in %',
   nachversorgung_schwellwert_pal_aufrundung_proz NUMBER(38,3)     COMMENT 'WBS Nachversorgung: Paletten Aufrundung (nur im Nicht-Äderungsfall) in %',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WBS_ART_AKTION_MARKT PRIMARY KEY (mandant_id, wup_id, nb_id, art_id, aktion_id, angebot_nr) NOT ENFORCED
)  COMMENT = 'Artikel_2+Markt-Ebene [GK/Mindestplatzierung]';
