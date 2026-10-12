--==============================================================
-- Table: ts_wbs_ausliefergruppe
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_ausliefergruppe
   generated from Powerdesigner on Montag, 19. Januar 2026 10:13:42
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TS_WBS_AUSLIEFERGRUPPE (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant',
   ausliefergruppe_id                  VARCHAR(10)      NOT NULL COMMENT 'Ausliefergruppe',
   berechnung_schwellwert_pal_abrundung_proz NUMBER(29,3)     COMMENT 'WBS Berechnung: Paletten Abrundung  Schwellwert in %',
   berechnung_schwellwert_pal_aufrundung_proz NUMBER(29,3)     COMMENT 'WBS Berechnung: Paletten Aufrundung  (nur im Nicht-Äderungsfall) in %',
   berechnung_kolli_rundung_proz       NUMBER(29,3)     COMMENT 'WBS Berechnung: Kolli Ab- und Aufrundung in %',
   nachversorgung_schwellwert_pal_abrundung_proz NUMBER(29,3)     COMMENT 'WBS Nachversorgung: Paletten Abrundung  Schwellwert in %',
   nachversorgung_schwellwert_pal_aufrundung_proz NUMBER(29,3)     COMMENT 'WBS Nachversorgung: Paletten Aufrundung  (nur im Nicht-Äderungsfall) in %',
   nachversorgung_kolli_rundung_proz   NUMBER(29,3)     COMMENT 'WBS Nachversorgung: Kolli Ab- und Aufrundung in %',
   max_kapa_endbestand_proz            NUMBER(29,3)     COMMENT 'Max. Kapa für Endbestand in %',
   bestand_betrachtung_proz            NUMBER(29,3)     COMMENT 'Bestandbetrachtung in %',
   rest_von_normalbestand_proz         NUMBER(29,3)     COMMENT 'Restbestand in % vom Normalbestand',
   erweiterung_bedarfshorizont_tage    INTEGER     COMMENT 'Erweiterung des Bedarfshorizonts bei der Werbemengenhochrechnung in Tagen.
            Bedarfshorizont = Demand-Horizont. Das ist ein Zeitraum, für welchen der Bedarf ermittelt wird ( die benötigte Menge für den Abverkauf)
            Bei der Ermittlung der Menge muss immer prüfen, für wie viele Tage diese reichen muss',
   menge_zielendbestand_schwellwert_ame INTEGER     COMMENT 'Schwellwert, ab welchem der Zielendbestand bei der Berechnung verwendet wird',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WBS_AUSLIEFERGRUPPE PRIMARY KEY (mandant_id, ausliefergruppe_id) NOT ENFORCED
)  COMMENT = 'SCM-WBS - This table contains settings for WBS calculation core on AUGR level (Auslieferungsgruppe). Content is maintained by transaction services document. Promotional weeks are added in advance and users can make changes to the settings, in which case the contents here are overwritten.';
