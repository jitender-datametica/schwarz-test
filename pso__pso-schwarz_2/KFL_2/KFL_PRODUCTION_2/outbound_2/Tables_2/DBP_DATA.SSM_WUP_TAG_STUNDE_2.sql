--==============================================================
-- Table: ssm_wup_tag_stunde_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ssm_wup_tag_stunde_2
   generated from Powerdesigner on Dienstag, 15. April 2025 06:26:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ssm_wup_tag_stunde_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK Warenumschlagsplatz'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='PK - Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wup_bereich_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID für die Bereiche innerhalb eines Markt für das Sollstundenmodell'),
wup_abt_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Abteilung innerhalb eines Marktes'),
ssm_cluster_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Sollstundenmodell-Cluster für die jeweilige Abteilung eines '),
ssm_prozess_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Prozesses'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
zeit_stunde BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Volle Stunde (00 bis 23)'),
zeit_15min BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Zahl (0, 15,30, 45 ) beschreibt das 15-Minuten-Intervall'),
ssm_aufwand_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Aufwandstyp (z.B. Aufgabe, Minimal, Dynamisch, etc.)'),
wert BIGNUMERIC(38,4)
OPTIONS(description='Berechneter Endwert (in Industrieminuten) pro Mandant_2(Land_2), Filiale (wup_2), Bereich, Abteilung, Prozesscluster, Prozess, Tag_2, Stunde, 15Min-Einheit'),
wert_gerundet BIGNUMERIC(38,4)
OPTIONS(description='Berechneter gerundeter Endwert (in Industrieminuten) pro Mandant_2(Land_2), Filiale (wup_2), Bereich, Abteilung, Prozesscluster, Prozess, Tag_2, Stunde, 15Min-Einheit'),
wert_minimal_berechnung BIGNUMERIC(38,4)
OPTIONS(description='Tatsächlicher Zeit_2-Aufwand je Prozess nach Abgleich Minimal-Stunden_2 gegen Aufgaben und Treiber je Filiale, Abteilung und 15 Minuten Zeitintervall. Wenn Aufgaben und Treiber größer als die Minimalbesetzung sind, werden alle Prozess mit ssm_aufwand_typ_id =3 auf 0 gesetzt. Ansonsten werden alle Treiber (ID = 1) und Aufgaben (ID = 2) 0 gesetzt.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, wup_bereich_id, wup_abt_id, ssm_cluster_id, ssm_prozess_id, dat, zeit_stunde,
 zeit_15min) NOT ENFORCED
) OPTIONS(description=' VIS - Ergebnistabelle Sollstundenmodell auf Ebene Wup_2 / Prozess / Tag_2');