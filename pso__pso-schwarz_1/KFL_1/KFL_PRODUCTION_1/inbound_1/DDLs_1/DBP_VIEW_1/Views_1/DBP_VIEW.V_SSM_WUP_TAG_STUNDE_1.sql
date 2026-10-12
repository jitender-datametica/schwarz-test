CREATE OR REPLACE VIEW DBP_VIEW.V_SSM_WUP_TAG_STUNDE_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,wup_id                                   COMMENT 'PK Warenumschlagsplatz'
  ,nb_id                                    COMMENT 'PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,wup_bereich_id                           COMMENT 'ID für die Bereiche innerhalb eines Markt für das Sollstundenmodell'
  ,wup_abt_id                               COMMENT 'ID der Abteilung innerhalb eines Marktes'
  ,ssm_cluster_id                           COMMENT 'ID des Sollstundenmodell-Cluster für die jeweilige Abteilung eines '
  ,ssm_prozess_id                           COMMENT 'ID des Prozesses'
  ,dat                                      COMMENT 'Datum im Format JJJJ-MM_1-TT'
  ,zeit_stunde                              COMMENT 'Volle Stunde (00 bis 23)'
  ,zeit_15min                               COMMENT 'Zahl (0, 15,30, 45 ) beschreibt das 15-Minuten-Intervall'
  ,ssm_aufwand_typ_id                       COMMENT 'ID des Aufwandstyp (z.B. Aufgabe, Minimal, Dynamisch, etc.)'
  ,wert                                     COMMENT 'Berechneter Endwert (in Industrieminuten) pro Mandant_1(Land_1), Filiale (wup_1), Bereich, Abteilung, Prozesscluster, Prozess, Tag_1, Stunde, 15Min-Einheit'
  ,wert_gerundet                            COMMENT 'Berechneter gerundeter Endwert (in Industrieminuten) pro Mandant_1(Land_1), Filiale (wup_1), Bereich, Abteilung, Prozesscluster, Prozess, Tag_1, Stunde, 15Min-Einheit'
  ,wert_minimal_berechnung                  COMMENT 'Tatsächlicher Zeit_1-Aufwand je Prozess nach Abgleich Minimal-Stunden_1 gegen Aufgaben und Treiber je Filiale, Abteilung und 15 Minuten Zeitintervall. Wenn Aufgaben und Treiber größer als die Minimalbesetzung sind, werden alle Prozess mit ssm_aufwand_typ_id =3 auf 0 gesetzt. Ansonsten werden alle Treiber (ID = 1) und Aufgaben (ID = 2) 0 gesetzt.'
)
COMMENT = ' VIS - Ergebnistabelle Sollstundenmodell auf Ebene Wup_1 / Prozess / Tag_1'
 AS 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        wup_bereich_id,
        wup_abt_id,
        ssm_cluster_id,
        ssm_prozess_id,
        dat,
        zeit_stunde,
        zeit_15min,
        ssm_aufwand_typ_id,
        wert,
        wert_gerundet,
        wert_minimal_berechnung

FROM DBP_DATA.SSM_WUP_TAG_STUNDE_1 ;