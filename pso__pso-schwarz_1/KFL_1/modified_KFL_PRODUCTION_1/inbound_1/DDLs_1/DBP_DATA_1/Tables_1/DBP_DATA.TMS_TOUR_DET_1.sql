--==============================================================
-- Table: tms_tour_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_tour_det_1
   generated from Powerdesigner on Donnerstag, 24. April 2025 11:16:53
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TMS_TOUR_DET_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   tms_tour_id                         INTEGER     NOT NULL COMMENT 'ID des Tours. Tournummer der Tour_1, zu der die Tourposition gehört. Aus plto.tour_1',
   dat_tour                            DATE             NOT NULL COMMENT 'Tourdatum',
   tms_tour_pos_id                     INTEGER     NOT NULL COMMENT 'Eindeutige Identifizierung einer Tourposition innerhalb der Tour. Entspricht nicht unbedingt - aber im Regelfall - der Reihenfolge, in der die Tourpositionen angefahren werden (Die Tourreihenfolge ist als Array von Positionsnummern im Tourkopf hinterlegt!)',
   tms_tour_pos_lfd_nr                 INTEGER     NOT NULL COMMENT 'SKey für die Tabelle tms_tour_det_1 im Quellsystem. Aus plto.to_id',
   tms_tour_reihenfolge_nr             INTEGER     COMMENT 'Reihenfolge in der die Tourpositionen angefahren werden (sollen)',
   lieferkunde_tms_gp_id               VARCHAR(30)      COMMENT 'ID des tms_gp_1, welcher hier als Lieferkunde auftrifft. In der Outbound-Logistik (Distributionslogistik) entspricht diese Nummer der wup_id.',
   lieferkunde_tms_gp_typ_cd           VARCHAR(3)       COMMENT 'Code für den tms_gp_1-Typ, welcher hier als Lieferkunde auftrifft',
   gewicht_kg                          NUMBER(29,2)     COMMENT 'das Gesamtgewicht (einschließlich Verpackung) der Sendung in Kilogramm für jede Position der Tour_1',
   volumen_cbm                         NUMBER(29,2)     COMMENT 'das Gesamtvolumen (einschließlich Verpackung) der Sendung in Kubikmetern für jede Position der Tour_1',
   anz_stellplatz                      NUMBER(29,2)     COMMENT 'die Anzahl der Stellplätze. Ein Stellplatz ist definiert als der Platz, der von einer Europalette eingenommen wird.',
   dat_ankunft                         DATE             COMMENT 'Ankunftsdatum (ermittelt aus der Optimierung)',
   datzeit_ankunft                     TIMESTAMP_LTZ(9) COMMENT 'Ankunftszeit (ermittelt aus der Optimierung)',
   datzeit_abfahrt                     TIMESTAMP_LTZ(9) COMMENT 'Abfahrtszeit',
   dauer_umtauschzeit_min              INTEGER     COMMENT 'Umtauschzeit',
   dauer_fahrzeit_min                  INTEGER     COMMENT 'Fahrzeit',
   entfernung_fahrt_km                 INTEGER     COMMENT 'Fahrkilometer',
   dauer_pause_min                     INTEGER     COMMENT 'Fahrpause',
   dauer_fahrzeit_nachfolger_min       NUMBER(29,2)     COMMENT 'Fahrzeit zum Nachfolger (mit Komma)',
   entfernung_nachfolger_km            NUMBER(29,2)     COMMENT 'Kilometer zum Nachfolger (mit Komma)',
   entfernung_lager_km                 NUMBER(29,2)     COMMENT 'Entfernung zum Lager in KM',
   dauer_fahrt_lager_min               NUMBER(29,2)     COMMENT 'Zeit_1, die zum erreichen des Lagers benötigt wird',
   maut_km                             NUMBER(29,2)     COMMENT 'Anzahl der mautpflichtigen Kilometer',
   gewicht_kg_retoure                  NUMBER(29,2)     COMMENT 'Gewicht der Retoure in Kilogramm',
   volumen_cbm_retoure                 NUMBER(29,2)     COMMENT 'Volumen der Retoure in CBM',
   anz_stellplatz_retoure              NUMBER(29,2)     COMMENT 'Anzahl der Einheiten / Stellplätze der Retoure',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TMS_TOUR_DET PRIMARY KEY (mandant_id, tms_tour_id, system_id, dat_tour, tms_tour_pos_id) NOT ENFORCED
)  COMMENT = 'TMS - Die Tabelle enthält die detaillierte Informationen zu einzelnen Tourstopps, einschließlich Lieferkunde, Reihenfolge und Lieferzeitfenster. Aus der Quelle plto (WANKO)';
