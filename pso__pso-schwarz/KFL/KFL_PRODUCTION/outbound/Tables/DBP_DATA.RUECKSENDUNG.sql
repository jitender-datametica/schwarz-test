--==============================================================
-- Table: ruecksendung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ruecksendung
   generated from Powerdesigner on Montag, 29. Juli 2024 22:22:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ruecksendung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
ruecksendung_beleg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige Kennung für den Rücksendevorgang. Dieser Beleg dokumentiert die Rücksendung eines Artikels von einer Filiale. Bei zentralen Retouren erfolgt die Rücksendung an das Verteilzentrum. Bei dezentralen Retouren wird der Artikel an den Lieferanten zurückgesendet.'),
wa_wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Warenumschlagsplatz-ID der Filiale, die die Rücksendung vornimmt.'),
wa_nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP.'),
we_wup_id BIGNUMERIC(38,0)
OPTIONS(description='ID des Warenumschlagsplatz des empfangenden Lagers. Nur bei zentraler Rücksendung auszufüllen. Null für dezentrale Rücksendungen.'),
we_nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des empfangenden WUP. Nur bei zentraler Rücksendung auszufüllen. Null für dezentrale Rücksendungen.'),
we_gp_id BIGNUMERIC(38,0)
OPTIONS(description='ID des Geschäftspartners des empfangenden Lieferants. Nur bei dezentraler Rücksendung auszufüllen. Null für zentraler Rücksendungen.'),
dat_lief DATE OPTIONS(description='Lieferdatum des Versandes.'),
ruecksendung_status_id BIGNUMERIC(38,0)
OPTIONS(description='Ampelstatus der Rücklieferung: 1 = Gelb, in Bearbeitung, 2 = Grün, erfasst und freigegeben, 3 = Rot, RL-Datum kritisch, 4 = Zwangsabschluss.            ASTAT = 3 ist nur als Warnmeldung für den Markt gedacht, deshalb wird 1(in Bearbeitung) zugeordnet.             Mapping dezentraler Retourenstatus für Inland (ZRP_RALFH.STAFH) auf Ampelstatus:            B generiert -> 0 Gelb und blau, noch nicht erfasst            D in Arbeit -> 1 Gelb, in Bearbeitung            G freigegeben -> 1 Gelb, in Bearbeitung            I abgeschlossen -> 2 Grün, erfasst und freigegeben            K zwangsabgeschlossen -> 4 Zwangsabschluss            H vom Einkauf manuell beendet -> 2 Grün, erfasst und freigegeben'),
anz_palette BIGNUMERIC(38,0) OPTIONS(description='Anzahl der zurückgesandten Paletten.'),
gefahrstoff_fg BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichen, ob es sich bei dem zurückgesendeten Artikel um Gefahrgut handelt.'),
ruecksendung_typ_kz STRING(4) OPTIONS(description='Code für die Art der Rücksendung.'),
dat_aenderung DATE OPTIONS(description='Datum der letzten Änderung im Quellsystem.'),
dat_erstellung DATE OPTIONS(description='Datum, an dem der Satz im Quellsystem hinzugefügt wurde.'),
bezugsweg_id BIGNUMERIC(38,0)
OPTIONS(description='Kennzeichnet die Herkunft des zurückgesendeten Artikels und den Zielort der Rücksendung. Bezugsweg=1: Direkt vom Lieferanten bezogen (Rücksendung an Lieferanten). Bezugsweg=4: Vom Zentrallager bezogen (Rücksendung an Zentrallager).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wa_wup_id, ruecksendung_beleg_id, wa_nb_id) NOT ENFORCED
)
OPTIONS(description='Die Tabelle beinhaltet Informationen zu den Retouren der Filialen. Eine Rücksendung erfolgt entweder an das Zentrallager (zentrale Rücksendung genannt) oder an den Lieferanten (dezentrale Rücksendung genannt).');