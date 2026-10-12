CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_hotline_anruf (mandant_id OPTIONS(description='Mandant im DWH'),
crm_hotline_bereich_id
OPTIONS(description='ID des Bereichs innerhalb der CRM-Hotline, an den der Anruf zugestellt wurde. Dieser Wert kategorisiert, welche Abteilung oder welches Team den Anruf entgegengenommen hat.'),
dat_anruf OPTIONS(description='Anlagedatum des Tickets'), anz_anruf OPTIONS(description='Anzahl der Anrufe.'),
anz_angenommen OPTIONS(description='Anzahl der Angenommene Anrufe.'), anz_aufgelegt
OPTIONS(description='Anzahl der Aufgelegte Anrufe.'), anz_wartend
OPTIONS(description='Anzahl der Anrufe die auf Wartend gesetzt würden.'), anz_angenommen_unter_25_sek
OPTIONS(description='Anzahl der Anrufe, wo die Gesprächsdauer unter 25 Sekunden war.'), anz_angenommen_ueber_25_sek
OPTIONS(description='Anzahl der Anrufe, wo die Gesprächsdauer über 25 Sekunden war.'), zeit_durchschnitt_wartezeit
OPTIONS(description='Durchschnittliche Wartezeit bis den Anruf angenommen würde.'),
zeit_durchschnitt_wartezeit_vor_auflegen
OPTIONS(description='Durchschnittliche Wartezeit bis den Anruf aufgelegt würde.'), zeit_durchschnitt_gespraech
OPTIONS(description='Durchschnittliche Gesprächsdauer von Anruf.'), zeit_durchschnitt_nachbearbeitung
OPTIONS(description='Durchschnittliche Erfassungszeit von Ticket ins System.'), prz_servicelevel
OPTIONS(description='Prozentsatz der innerhalb eines definierten Zeitraums angenommenen Anrufe. Er berechnet sich im Quellsystem.'))
OPTIONS(DESCRIPTION = `DIESE TABELLE ERFASST DETAILLIERTE KENNZAHLEN ZU CALLCENTER-ANRUFEN AUF DER EBENE MANDANT, BEREICHE UND ANLAGEDATUM. DIE TABELLE SPEICHERT DIE ANZAHL DER ANRUFE, ANGENOMMENE, AUFGELEGTE UND WARTENDE ANRUFE. DIESE DATEN ERMÖGLICHEN EINE UMFASSENDE BEWERTUNG DER CALLCENTER-PERFORMANCE UND ERREICHBARKEIT. DIE DATEN FÜR ANRUFE AUS DEUTSCHLAND STAMMEN VON DEM SYSTEM "VOXTRON" UND DIE ANRUFE AUS ANDEREN LÄNDERN ÜBER "TELEKOM" ERFASST WERDEN.  DORT GIBT ES NUR EINE TELEFONNUMMER, UND DER KUNDE WIRD ZU DEN ENTSPRECHENDEN KOLLEGEN IN DEN BEREICHEN WEITERGELEITET.`)
AS SELECT mandant_id,
 crm_hotline_bereich_id,
 dat_anruf,
 anz_anruf,
 anz_angenommen,
 anz_aufgelegt,
 anz_wartend,
 anz_angenommen_unter_25_sek,
 anz_angenommen_ueber_25_sek,
 zeit_durchschnitt_wartezeit,
 zeit_durchschnitt_wartezeit_vor_auflegen,
 zeit_durchschnitt_gespraech,
 zeit_durchschnitt_nachbearbeitung,
 prz_servicelevel
FROM kfl_production_dbp_data.crm_hotline_anruf;