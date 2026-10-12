--==============================================================
-- Table: tms_tour_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_tour_det_2
   generated from Powerdesigner on Donnerstag, 24. April 2025 11:16:53
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_tour_det_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_tour_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Tours. Tournummer der Tour_2, zu der die Tourposition gehört. Aus plto.tour_2'),
dat_tour DATE NOT NULL OPTIONS(description='Tourdatum'),
tms_tour_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige Identifizierung einer Tourposition innerhalb der Tour. Entspricht nicht unbedingt - aber im Regelfall - der Reihenfolge, in der die Tourpositionen angefahren werden (Die Tourreihenfolge ist als Array von Positionsnummern im Tourkopf hinterlegt!)'),
tms_tour_pos_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle tms_tour_det_2 im Quellsystem. Aus plto.to_id'),
tms_tour_reihenfolge_nr BIGNUMERIC(38,0)
OPTIONS(description='Reihenfolge in der die Tourpositionen angefahren werden (sollen)'),
lieferkunde_tms_gp_id STRING(30)
OPTIONS(description='ID des tms_gp_2, welcher hier als Lieferkunde auftrifft. In der Outbound-Logistik (Distributionslogistik) entspricht diese Nummer der wup_id.'),
lieferkunde_tms_gp_typ_cd STRING(3)
OPTIONS(description='Code für den tms_gp_2-Typ, welcher hier als Lieferkunde auftrifft'),
gewicht_kg NUMERIC(18,2)
OPTIONS(description='das Gesamtgewicht (einschließlich Verpackung) der Sendung in Kilogramm für jede Position der Tour_2'),
volumen_cbm NUMERIC(18,2)
OPTIONS(description='das Gesamtvolumen (einschließlich Verpackung) der Sendung in Kubikmetern für jede Position der Tour_2'),
anz_stellplatz NUMERIC(18,2)
OPTIONS(description='die Anzahl der Stellplätze. Ein Stellplatz ist definiert als der Platz, der von einer Europalette eingenommen wird.'),
dat_ankunft DATE OPTIONS(description='Ankunftsdatum (ermittelt aus der Optimierung)'),
datzeit_ankunft TIMESTAMP OPTIONS(description='Ankunftszeit (ermittelt aus der Optimierung)'),
datzeit_abfahrt TIMESTAMP OPTIONS(description='Abfahrtszeit'),
dauer_umtauschzeit_min BIGNUMERIC(38,0) OPTIONS(description='Umtauschzeit'),
dauer_fahrzeit_min BIGNUMERIC(38,0) OPTIONS(description='Fahrzeit'),
entfernung_fahrt_km BIGNUMERIC(38,0) OPTIONS(description='Fahrkilometer'),
dauer_pause_min BIGNUMERIC(38,0) OPTIONS(description='Fahrpause'),
dauer_fahrzeit_nachfolger_min NUMERIC(18,2) OPTIONS(description='Fahrzeit zum Nachfolger (mit Komma)'),
entfernung_nachfolger_km NUMERIC(18,2) OPTIONS(description='Kilometer zum Nachfolger (mit Komma)'),
entfernung_lager_km NUMERIC(18,2) OPTIONS(description='Entfernung zum Lager in KM'),
dauer_fahrt_lager_min NUMERIC(18,2) OPTIONS(description='Zeit_2, die zum erreichen des Lagers benötigt wird'),
maut_km NUMERIC(18,2) OPTIONS(description='Anzahl der mautpflichtigen Kilometer'),
gewicht_kg_retoure BIGNUMERIC(38,2) OPTIONS(description='Gewicht der Retoure in Kilogramm'),
volumen_cbm_retoure BIGNUMERIC(38,2) OPTIONS(description='Volumen der Retoure in CBM'),
anz_stellplatz_retoure BIGNUMERIC(38,2) OPTIONS(description='Anzahl der Einheiten / Stellplätze der Retoure'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, tms_tour_id, system_id, dat_tour, tms_tour_pos_id) NOT ENFORCED
)
OPTIONS(description='TMS - Die Tabelle enthält die detaillierte Informationen zu einzelnen Tourstopps, einschließlich Lieferkunde, Reihenfolge und Lieferzeitfenster. Aus der Quelle plto (WANKO)');