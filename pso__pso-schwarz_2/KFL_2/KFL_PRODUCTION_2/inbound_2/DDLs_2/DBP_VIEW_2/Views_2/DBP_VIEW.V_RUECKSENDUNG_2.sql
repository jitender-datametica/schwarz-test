CREATE OR REPLACE VIEW DBP_VIEW.V_RUECKSENDUNG_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,ruecksendung_beleg_id                    COMMENT 'Eindeutige Kennung für den Rücksendevorgang. Dieser Beleg dokumentiert die Rücksendung eines Artikels von einer Filiale. Bei zentralen Retouren erfolgt die Rücksendung an das Verteilzentrum. Bei dezentralen Retouren wird der Artikel_2 an den Lieferanten zurückgesendet.'
  ,wa_wup_id                                COMMENT 'Warenumschlagsplatz-ID der Filiale, die die Rücksendung vornimmt.'
  ,wa_nb_id                                 COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des abgebenden WUP.'
  ,we_wup_id                                COMMENT 'ID des Warenumschlagsplatz des empfangenden Lagers. Nur bei zentraler Rücksendung auszufüllen. Null für dezentrale Rücksendungen.'
  ,we_nb_id                                 COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer des empfangenden WUP. Nur bei zentraler Rücksendung auszufüllen. Null für dezentrale Rücksendungen.'
  ,we_gp_id                                 COMMENT 'ID des Geschäftspartners des empfangenden Lieferants. Nur bei dezentraler Rücksendung auszufüllen. Null für zentraler Rücksendungen.'
  ,dat_lief                                 COMMENT 'Lieferdatum des Versandes.'
  ,ruecksendung_status_id                   COMMENT 'Ampelstatus der Rücklieferung: 1 = Gelb, in Bearbeitung, 2 = Grün, erfasst und freigegeben, 3 = Rot, RL-Datum kritisch, 4 = Zwangsabschluss.
ASTAT = 3 ist nur als Warnmeldung für den Markt gedacht, deshalb wird 1(in Bearbeitung) zugeordnet. 
Mapping dezentraler Retourenstatus für Inland (ZRP_RALFH.STAFH) auf Ampelstatus:
B generiert -> 0 Gelb und blau, noch nicht erfasst
D in Arbeit -> 1 Gelb, in Bearbeitung
G freigegeben -> 1 Gelb, in Bearbeitung
I abgeschlossen -> 2 Grün, erfasst und freigegeben
K zwangsabgeschlossen -> 4 Zwangsabschluss
H vom Einkauf manuell beendet -> 2 Grün, erfasst und freigegeben'
  ,anz_palette                              COMMENT 'Anzahl der zurückgesandten Paletten.'
  ,gefahrstoff_fg                           COMMENT 'Kennzeichen, ob es sich bei dem zurückgesendeten Artikel_2 um Gefahrgut handelt.'
  ,ruecksendung_typ_kz                      COMMENT 'Code für die Art_2 der Rücksendung.'
  ,dat_aenderung                            COMMENT 'Datum der letzten Änderung im Quellsystem.'
  ,dat_erstellung                           COMMENT 'Datum, an dem der Satz im Quellsystem hinzugefügt wurde.'
  ,bezugsweg_id                             COMMENT 'Kennzeichnet die Herkunft des zurückgesendeten Artikels und den Zielort der Rücksendung. Bezugsweg=1: Direkt vom Lieferanten bezogen (Rücksendung an Lieferanten). Bezugsweg=4: Vom Zentrallager bezogen (Rücksendung an Zentrallager).'
)
COMMENT = 'Die Tabelle beinhaltet Informationen zu den Retouren der Filialen. Eine_2 Rücksendung erfolgt entweder an das Zentrallager (zentrale Rücksendung genannt) oder an den Lieferanten (dezentrale Rücksendung genannt).'
 AS 
    SELECT 
        mandant_id,
        ruecksendung_beleg_id,
        wa_wup_id,
        wa_nb_id,
        we_wup_id,
        we_nb_id,
        we_gp_id,
        dat_lief,
        ruecksendung_status_id,
        anz_palette,
        gefahrstoff_fg,
        ruecksendung_typ_kz,
        dat_aenderung,
        dat_erstellung,
        bezugsweg_id

FROM DBP_DATA.RUECKSENDUNG_2 ;