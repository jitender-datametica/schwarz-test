CREATE OR REPLACE VIEW DBP_VIEW.V_PROTOKOLL_VERLADUNG_EWM_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,transportation_unit_id                   COMMENT 'Nummer eines Transportes im EWM-System. Ein Transport / eine_2 Tour_2 ist eine_2 Fahrt einer Transporters mit Start- und Zielverteilzentrum inklusive Zwischenstopps bei anderen VZs. Das Feld hat die gleiche Bedeutung wie tour_id, wurde aber von SAP abgeaendert.'
  ,kj_transportation_unit                   COMMENT 'Anlagejahr der Transporteinheit'
  ,transportation_unit_sr_act_id            COMMENT 'Warenannahme- und Versandaktivitaetsnummer der Transporteinheit.'
  ,handling_unit_id_ext                     COMMENT 'Externe Handling-Unit_2-Identifikation. Nummer der Palette.'
  ,datzeit_scan                             COMMENT 'Datum- und Zeitstempel der Bearbeitung. UTC-Zeitstempel in Langform (JJJJMMTThhmmssmmmuuun).'
  ,lagernummer_id                           COMMENT 'ID der Lagernummer - hoechste Ebene der Lagerhierarchie.'
  ,lagersortiment_id                        COMMENT 'Lagersortiment ID.'
  ,kunde_id                                 COMMENT 'Warenempfaenger (wup_id_markt, Marktnummer).'
  ,dat_scan                                 COMMENT 'Scandatum.'
  ,zeit_scan                                COMMENT 'Scanuhrzeit.'
  ,versandeinheit_id_ext                    COMMENT 'Handling-Unit_2-ID bei Sammelpalette, wenn Paletten vereinigt werden. Enthaelt 18-stellige Nummer, wenn Teil einer Palette, -1 wenn Palette, 1 wenn Sammelpalette.'
  ,lief_beleg_id                            COMMENT 'Das Feld enthaelt die Beleg ID des Lieferscheins und dient der eindeutigen Identifikation der Lieferscheinbelege.'
  ,dat_lief_soll                            COMMENT 'Datum, bei dem die Lieferung beim Kunden eingehen soll. Das System kann fuer den Warenausgang das Lieferdatum aufgrund vordefinierter Zeitschaetzungen errechnen.'
  ,z_arbeitsgebiet_id                       COMMENT 'Nachrichtentyp einer Pruefung bei einer Verladung. Ordnet die Pruef ID einem Typ/Arbeitsgebiet zu, in dem die Pruefung stattfindet. Ohne diese ID ist die pruef_id nicht eindeutig.'
  ,pruef_id                                 COMMENT 'Nachrichtennummer die den Prueffall beschreibt.'
  ,gesamtgewicht_hu                         COMMENT 'Gesamtgewicht der Palette / Handling-Unit.'
)
COMMENT = 'ZGI_LOAD_RECORD ''Protokolltabelle Verladung'', Quelle SAP-EWM. Die Tabelle protokoll_verladung_2 aus Quelle SAP-LES bildet den gleichen Sachverhalt ab, nur in etwas anderer Form / anderer Granularitaet. SAP hat ihr Datenmodell veraendert, weshalbt sich Feldnamen und z.T. auch Bedeutung unterscheiden. Auch werden hier einige Fehler der anderen Tabelle behoben.'
 AS 
    SELECT 
        mandant_id,
        transportation_unit_id,
        kj_transportation_unit,
        transportation_unit_sr_act_id,
        handling_unit_id_ext,
        datzeit_scan,
        lagernummer_id,
        lagersortiment_id,
        kunde_id,
        dat_scan,
        zeit_scan,
        versandeinheit_id_ext,
        lief_beleg_id,
        dat_lief_soll,
        z_arbeitsgebiet_id,
        pruef_id,
        gesamtgewicht_hu

FROM DBP_DATA.PROTOKOLL_VERLADUNG_EWM_2 ;