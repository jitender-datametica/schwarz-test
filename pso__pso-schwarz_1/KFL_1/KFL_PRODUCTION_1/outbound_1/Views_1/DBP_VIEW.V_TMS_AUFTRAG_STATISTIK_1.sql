CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_auftrag_statistik_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_auftrag_id
OPTIONS(description='ID des Auftrags (Auftragsnummer). Aus plaust.au_nr'), tms_auftrag_pos_id
OPTIONS(description='Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen'), auftrag_statistik_lfd_nr
OPTIONS(description='SKey für die Tabelle tms_auftrag_statistik_1 im Quellsystem. Aus plaust.aust_id'), lief_beleg_id
OPTIONS(description='Lieferbeleg'), kj_lief_beleg
OPTIONS(description='Kalenderjahr aus LFDAT. Lookup in besch_lief_1, -1 für keinen Treffer'), lieferkunde_tms_gp_id
OPTIONS(description='ID des tms_gp_1, welcher hier als Lieferkunde auftrifft'), lieferkunde_tms_gp_typ_cd
OPTIONS(description='Code für den tms_gp_1-Typ, welcher hier als Lieferkunde auftrifft'), tms_tour_id
OPTIONS(description='Tournummer'), dat_tour OPTIONS(description='Tourdatum'), betrag_kostenanteil
OPTIONS(description='Anteil des Kunden an den Eigenkosten oder Fremdkosten in Euro (NETTO)'), tms_rech_beleg_id
OPTIONS(description='Rechnungsnummer'), dat_rechnung OPTIONS(description='Rechnungsdatum'), dat_leistung
OPTIONS(description='Datum der Leistung'), abrechnungslauf_id OPTIONS(description='Abrechnungslauf'))
OPTIONS(DESCRIPTION = `TMS - DIE TABELLE ENTHÄLT DIE STATISTISCHE DATEN ZU TMS-AUFTRÄGEN. AUS DER QUELLE PLAUST (WANKO)`)
AS SELECT mandant_id,
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
FROM kfl_production_dbp_data.tms_auftrag_statistik_1;