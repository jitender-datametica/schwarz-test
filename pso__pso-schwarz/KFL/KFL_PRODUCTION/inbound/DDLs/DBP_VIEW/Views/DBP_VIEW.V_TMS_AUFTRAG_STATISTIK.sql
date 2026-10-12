CREATE OR REPLACE VIEW DBP_VIEW.V_TMS_AUFTRAG_STATISTIK (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,system_id                                COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.'
  ,tms_auftrag_id                           COMMENT 'ID des Auftrags (Auftragsnummer). Aus plaust.au_nr'
  ,tms_auftrag_pos_id                       COMMENT 'Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen'
  ,auftrag_statistik_lfd_nr                 COMMENT 'SKey für die Tabelle tms_auftrag_statistik im Quellsystem. Aus plaust.aust_id'
  ,lief_beleg_id                            COMMENT 'Lieferbeleg'
  ,kj_lief_beleg                            COMMENT 'Kalenderjahr aus LFDAT. Lookup in besch_lief, -1 für keinen Treffer'
  ,lieferkunde_tms_gp_id                    COMMENT 'ID des tms_gp, welcher hier als Lieferkunde auftrifft'
  ,lieferkunde_tms_gp_typ_cd                COMMENT 'Code für den tms_gp-Typ, welcher hier als Lieferkunde auftrifft'
  ,tms_tour_id                              COMMENT 'Tournummer'
  ,dat_tour                                 COMMENT 'Tourdatum'
  ,betrag_kostenanteil                      COMMENT 'Anteil des Kunden an den Eigenkosten oder Fremdkosten in Euro (NETTO)'
  ,tms_rech_beleg_id                        COMMENT 'Rechnungsnummer'
  ,dat_rechnung                             COMMENT 'Rechnungsdatum'
  ,dat_leistung                             COMMENT 'Datum der Leistung'
  ,abrechnungslauf_id                       COMMENT 'Abrechnungslauf'
)
COMMENT = 'TMS - Die Tabelle enthält die statistische Daten zu TMS-Aufträgen. Aus der Quelle plaust (WANKO)'
 AS 
    SELECT 
        mandant_id,
        system_id,
        tms_auftrag_id,
        tms_auftrag_pos_id,
        auftrag_statistik_lfd_nr,
        lief_beleg_id,
        kj_lief_beleg,
        lieferkunde_tms_gp_id,
        lieferkunde_tms_gp_typ_cd,
        tms_tour_id,
        dat_tour,
        betrag_kostenanteil,
        tms_rech_beleg_id,
        dat_rechnung,
        dat_leistung,
        abrechnungslauf_id

FROM DBP_DATA.TMS_AUFTRAG_STATISTIK ;