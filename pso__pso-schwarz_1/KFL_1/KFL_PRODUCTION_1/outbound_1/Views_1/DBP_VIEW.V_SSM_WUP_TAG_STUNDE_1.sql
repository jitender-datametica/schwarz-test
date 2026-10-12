CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ssm_wup_tag_stunde_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
wup_id OPTIONS(description='PK Warenumschlagsplatz'), nb_id
OPTIONS(description='PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wup_bereich_id OPTIONS(description='ID für die Bereiche innerhalb eines Markt für das Sollstundenmodell'), wup_abt_id
OPTIONS(description='ID der Abteilung innerhalb eines Marktes'), ssm_cluster_id
OPTIONS(description='ID des Sollstundenmodell-Cluster für die jeweilige Abteilung eines '), ssm_prozess_id
OPTIONS(description='ID des Prozesses'), dat OPTIONS(description='Datum im Format JJJJ-MM_1-TT'), zeit_stunde
OPTIONS(description='Volle Stunde (00 bis 23)'), zeit_15min
OPTIONS(description='Zahl (0, 15,30, 45 ) beschreibt das 15-Minuten-Intervall'), ssm_aufwand_typ_id
OPTIONS(description='ID des Aufwandstyp (z.B. Aufgabe, Minimal, Dynamisch, etc.)'), wert
OPTIONS(description='Berechneter Endwert (in Industrieminuten) pro Mandant_1(Land_1), Filiale (wup_1), Bereich, Abteilung, Prozesscluster, Prozess, Tag_1, Stunde, 15Min-Einheit'),
wert_gerundet
OPTIONS(description='Berechneter gerundeter Endwert (in Industrieminuten) pro Mandant_1(Land_1), Filiale (wup_1), Bereich, Abteilung, Prozesscluster, Prozess, Tag_1, Stunde, 15Min-Einheit'),
wert_minimal_berechnung
OPTIONS(description='Tatsächlicher Zeit_1-Aufwand je Prozess nach Abgleich Minimal-Stunden_1 gegen Aufgaben und Treiber je Filiale, Abteilung und 15 Minuten Zeitintervall. Wenn Aufgaben und Treiber größer als die Minimalbesetzung sind, werden alle Prozess mit ssm_aufwand_typ_id =3 auf 0 gesetzt. Ansonsten werden alle Treiber (ID = 1) und Aufgaben (ID = 2) 0 gesetzt.'))
OPTIONS(DESCRIPTION = ` VIS - ERGEBNISTABELLE SOLLSTUNDENMODELL AUF EBENE WUP_1 / PROZESS / TAG_1`) AS SELECT mandant_id,
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
FROM kfl_production_dbp_data.ssm_wup_tag_stunde_1;