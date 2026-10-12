--==============================================================
-- Table: ssm_wup_tag_stunde_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ssm_wup_tag_stunde_2
   generated from Powerdesigner on Dienstag, 15. April 2025 06:26:39
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.SSM_WUP_TAG_STUNDE_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wup_id                              INTEGER     NOT NULL COMMENT 'PK Warenumschlagsplatz',
   nb_id                               INTEGER     NOT NULL COMMENT 'PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wup_bereich_id                      INTEGER     NOT NULL COMMENT 'ID für die Bereiche innerhalb eines Markt für das Sollstundenmodell',
   wup_abt_id                          INTEGER     NOT NULL COMMENT 'ID der Abteilung innerhalb eines Marktes',
   ssm_cluster_id                      INTEGER     NOT NULL COMMENT 'ID des Sollstundenmodell-Cluster für die jeweilige Abteilung eines ',
   ssm_prozess_id                      INTEGER     NOT NULL COMMENT 'ID des Prozesses',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM_2-TT',
   zeit_stunde                         INTEGER     NOT NULL COMMENT 'Volle Stunde (00 bis 23)',
   zeit_15min                          INTEGER     NOT NULL COMMENT 'Zahl (0, 15,30, 45 ) beschreibt das 15-Minuten-Intervall',
   ssm_aufwand_typ_id                  INTEGER     NOT NULL COMMENT 'ID des Aufwandstyp (z.B. Aufgabe, Minimal, Dynamisch, etc.)',
   wert                                NUMBER(29,4)     COMMENT 'Berechneter Endwert (in Industrieminuten) pro Mandant_2(Land_2), Filiale (wup_2), Bereich, Abteilung, Prozesscluster, Prozess, Tag_2, Stunde, 15Min-Einheit',
   wert_gerundet                       NUMBER(29,4)     COMMENT 'Berechneter gerundeter Endwert (in Industrieminuten) pro Mandant_2(Land_2), Filiale (wup_2), Bereich, Abteilung, Prozesscluster, Prozess, Tag_2, Stunde, 15Min-Einheit',
   wert_minimal_berechnung             NUMBER(29,4)     COMMENT 'Tatsächlicher Zeit_2-Aufwand je Prozess nach Abgleich Minimal-Stunden_2 gegen Aufgaben und Treiber je Filiale, Abteilung und 15 Minuten Zeitintervall. Wenn Aufgaben und Treiber größer als die Minimalbesetzung sind, werden alle Prozess mit ssm_aufwand_typ_id =3 auf 0 gesetzt. Ansonsten werden alle Treiber (ID = 1) und Aufgaben (ID = 2) 0 gesetzt.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_SSM_WUP_TAG_STUNDE PRIMARY KEY (mandant_id, wup_id, nb_id, wup_bereich_id, wup_abt_id, ssm_cluster_id, ssm_prozess_id, dat, zeit_stunde, zeit_15min) NOT ENFORCED
)  COMMENT = ' VIS - Ergebnistabelle Sollstundenmodell auf Ebene Wup_2 / Prozess / Tag_2';
