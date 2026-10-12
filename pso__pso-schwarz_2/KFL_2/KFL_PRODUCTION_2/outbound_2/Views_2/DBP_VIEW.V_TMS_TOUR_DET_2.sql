CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_tour_det_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_tour_id
OPTIONS(description='ID des Tours. Tournummer der Tour_2, zu der die Tourposition gehört. Aus plto.tour_2'), dat_tour
OPTIONS(description='Tourdatum'), tms_tour_pos_id
OPTIONS(description='Eindeutige Identifizierung einer Tourposition innerhalb der Tour. Entspricht nicht unbedingt - aber im Regelfall - der Reihenfolge, in der die Tourpositionen angefahren werden (Die Tourreihenfolge ist als Array von Positionsnummern im Tourkopf hinterlegt!)'),
tms_tour_pos_lfd_nr OPTIONS(description='SKey für die Tabelle tms_tour_det_2 im Quellsystem. Aus plto.to_id'),
tms_tour_reihenfolge_nr OPTIONS(description='Reihenfolge in der die Tourpositionen angefahren werden (sollen)'),
lieferkunde_tms_gp_id
OPTIONS(description='ID des tms_gp_2, welcher hier als Lieferkunde auftrifft. In der Outbound-Logistik (Distributionslogistik) entspricht diese Nummer der wup_id.'),
lieferkunde_tms_gp_typ_cd OPTIONS(description='Code für den tms_gp_2-Typ, welcher hier als Lieferkunde auftrifft'),
gewicht_kg
OPTIONS(description='das Gesamtgewicht (einschließlich Verpackung) der Sendung in Kilogramm für jede Position der Tour_2'),
volumen_cbm
OPTIONS(description='das Gesamtvolumen (einschließlich Verpackung) der Sendung in Kubikmetern für jede Position der Tour_2'),
anz_stellplatz
OPTIONS(description='die Anzahl der Stellplätze. Ein Stellplatz ist definiert als der Platz, der von einer Europalette eingenommen wird.'),
dat_ankunft OPTIONS(description='Ankunftsdatum (ermittelt aus der Optimierung)'), datzeit_ankunft
OPTIONS(description='Ankunftszeit (ermittelt aus der Optimierung)'), datzeit_abfahrt OPTIONS(description='Abfahrtszeit'),
dauer_umtauschzeit_min OPTIONS(description='Umtauschzeit'), dauer_fahrzeit_min OPTIONS(description='Fahrzeit'),
entfernung_fahrt_km OPTIONS(description='Fahrkilometer'), dauer_pause_min OPTIONS(description='Fahrpause'),
dauer_fahrzeit_nachfolger_min OPTIONS(description='Fahrzeit zum Nachfolger (mit Komma)'), entfernung_nachfolger_km
OPTIONS(description='Kilometer zum Nachfolger (mit Komma)'), entfernung_lager_km
OPTIONS(description='Entfernung zum Lager in KM'), dauer_fahrt_lager_min
OPTIONS(description='Zeit_2, die zum erreichen des Lagers benötigt wird'), maut_km
OPTIONS(description='Anzahl der mautpflichtigen Kilometer'), gewicht_kg_retoure
OPTIONS(description='Gewicht der Retoure in Kilogramm'), volumen_cbm_retoure
OPTIONS(description='Volumen der Retoure in CBM'), anz_stellplatz_retoure
OPTIONS(description='Anzahl der Einheiten / Stellplätze der Retoure'))
OPTIONS(DESCRIPTION = `TMS - DIE TABELLE ENTHÄLT DIE DETAILLIERTE INFORMATIONEN ZU EINZELNEN TOURSTOPPS, EINSCHLIESSLICH LIEFERKUNDE, REIHENFOLGE UND LIEFERZEITFENSTER. AUS DER QUELLE PLTO (WANKO)`)
AS SELECT mandant_id,
 system_id,
 tms_tour_id,
 dat_tour,
 tms_tour_pos_id,
 tms_tour_pos_lfd_nr,
 tms_tour_reihenfolge_nr,
 lieferkunde_tms_gp_id,
 lieferkunde_tms_gp_typ_cd,
 gewicht_kg,
 volumen_cbm,
 anz_stellplatz,
 dat_ankunft,
 datzeit_ankunft,
 datzeit_abfahrt,
 dauer_umtauschzeit_min,
 dauer_fahrzeit_min,
 entfernung_fahrt_km,
 dauer_pause_min,
 dauer_fahrzeit_nachfolger_min,
 entfernung_nachfolger_km,
 entfernung_lager_km,
 dauer_fahrt_lager_min,
 maut_km,
 gewicht_kg_retoure,
 volumen_cbm_retoure,
 anz_stellplatz_retoure
FROM kfl_production_dbp_data.tms_tour_det_2;