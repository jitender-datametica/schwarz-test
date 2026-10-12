--==============================================================
-- Table: ssm_wup_tag_stunde
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ssm_wup_tag_stunde
   generated from Powerdesigner on Dienstag, 15. April 2025 06:26:39
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.SSM_WUP_TAG_STUNDE (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'PK Warenumschlagsplatz',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   wup_bereich_id                      NUMBER(38,0)     NOT NULL COMMENT 'ID für die Bereiche innerhalb eines Markt für das Sollstundenmodell',
   wup_abt_id                          NUMBER(38,0)     NOT NULL COMMENT 'ID der Abteilung innerhalb eines Marktes',
   ssm_cluster_id                      NUMBER(38,0)     NOT NULL COMMENT 'ID des Sollstundenmodell-Cluster für die jeweilige Abteilung eines ',
   ssm_prozess_id                      NUMBER(38,0)     NOT NULL COMMENT 'ID des Prozesses',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM-TT',
   zeit_stunde                         NUMBER(38,0)     NOT NULL COMMENT 'Volle Stunde (00 bis 23)',
   zeit_15min                          NUMBER(38,0)     NOT NULL COMMENT 'Zahl (0, 15,30, 45 ) beschreibt das 15-Minuten-Intervall',
   ssm_aufwand_typ_id                  NUMBER(38,0)     NOT NULL COMMENT 'ID des Aufwandstyp (z.B. Aufgabe, Minimal, Dynamisch, etc.)',
   wert                                NUMBER(38,4)     COMMENT 'Berechneter Endwert (in Industrieminuten) pro Mandant(Land), Filiale (wup), Bereich, Abteilung, Prozesscluster, Prozess, Tag, Stunde, 15Min-Einheit',
   wert_gerundet                       NUMBER(38,4)     COMMENT 'Berechneter gerundeter Endwert (in Industrieminuten) pro Mandant(Land), Filiale (wup), Bereich, Abteilung, Prozesscluster, Prozess, Tag, Stunde, 15Min-Einheit',
   wert_minimal_berechnung             NUMBER(38,4)     COMMENT 'Tatsächlicher Zeit-Aufwand je Prozess nach Abgleich Minimal-Stunden gegen Aufgaben und Treiber je Filiale, Abteilung und 15 Minuten Zeitintervall. Wenn Aufgaben und Treiber größer als die Minimalbesetzung sind, werden alle Prozess mit ssm_aufwand_typ_id =3 auf 0 gesetzt. Ansonsten werden alle Treiber (ID = 1) und Aufgaben (ID = 2) 0 gesetzt.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_SSM_WUP_TAG_STUNDE PRIMARY KEY (mandant_id, wup_id, nb_id, wup_bereich_id, wup_abt_id, ssm_cluster_id, ssm_prozess_id, dat, zeit_stunde, zeit_15min) NOT ENFORCED
)  COMMENT = ' VIS - Ergebnistabelle Sollstundenmodell auf Ebene Wup / Prozess / Tag';
