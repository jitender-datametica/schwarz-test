CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_lageraufgabe_wa_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
lagernummer_id OPTIONS(description='Lagernummer/Lagerkomplex'), lageraufgabe_id OPTIONS(description='Lageraufgabe_1'),
handling_unit_id_nach OPTIONS(description='Nach-Handling-Unit_1'), artikelsortiment_id
OPTIONS(description='Kauflandspezifische Info Sortiments ID'), handling_unit_id_ext
OPTIONS(description='Externe Handling Unit_1 Identifikation aus exidv. Nummer der Versandeinheit (NVE).'), dat_lief_soll
OPTIONS(description='Lieferdatum der Position.'), lief_typ_id
OPTIONS(description='Klassifikation, mit der zwischen verschiedenen Arten der Lieferung unterschieden wird. Die Lieferart bestimmt, wie das System eine_1 Lieferung bearbeitet.'),
kunde_id
OPTIONS(description='Die Kunde ID ist die wup_id des belieferten Marktes. Dazu gibt es auch eine_1 mandant_id_kunde.'),
lief_pal_typ_id
OPTIONS(description='Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine_1 Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt, etc., handelt.'),
lief_pal_typ_dwh_id OPTIONS(description='Abgeleiteter Palettentyp (6 wird in 61 und 64 unterteilt),'), werbeware_id
OPTIONS(description='Aus besch_lief_1: Wird gefüllt, wenn die Bestellart eine_1 Werbebestellart ist. Wertevorrat: W = Werbung, N = Normalware, B = Beides W und N, S = Schnellschuss.'),
transportation_unit_id OPTIONS(description='Transporteinheit (intern).'), kj_transportation_unit
OPTIONS(description='Anlagejahr der Transporteinheit'), datzeit_start_max
OPTIONS(description='Spätester Starttermin (SST)      '), datzeit_erstellung OPTIONS(description='Erstellungszeitpunkt'),
datzeit_start OPTIONS(description='Startzeitpunkt'), datzeit_lezter_pick OPTIONS(description='zeitpunkt letzter pick'),
datzeit_quittierung_bsf
OPTIONS(description='Quittierungszeitpunkt dieser einzelnen Palette auf der Bereitstellfläche (BSF)'), datzeit_verladung
OPTIONS(description='zeitpunkt verladung'), queue_id OPTIONS(description='Queue'), welle_id
OPTIONS(description='Welle. Logical grouping of tasks (lageraufgabe_1) that are performed together (in one wave)'),
lagersortiment_id OPTIONS(description='Lagersortiment ID.'), lagerbereich_id_nach
OPTIONS(description='Nachlagerbereich'), lagertyp_id_nach OPTIONS(description='Nach-Lagertyp'), lagerplatz_id_nach
OPTIONS(description='Nachlagerplatz'), bsf_wechsel OPTIONS(description='flag: wechsel der bereitstellfläche'),
dat_aktion OPTIONS(description='Werbedatum.'), datzeit_bereitstellung OPTIONS(description='Bereitstelllzeitstempel'),
dat_tour OPTIONS(description='Tourdatum'), tdl_tms_gp_id
OPTIONS(description='Geschäftspartner-ID des Transportdienstleisters (TDL). FK auf tms_gp_1 und der referenzierte Geschäftspartner-Typ(tms_gp_typ_cd) ist implizit\'S\' (Spediteur).'),
datzeit_quittierung_tour_erste_pal
OPTIONS(description='Quittierungszeitpunkt der ersten Palette auf der Bereitstellfläche (BSF) (je Tour_1)'),
datzeit_quittierung_tour_letzte_pal
OPTIONS(description='Quittierungszeitpunkt der letzten Palette auf der Bereitstellfläche (BSF) (je Tour_1)')) AS SELECT
 mandant_id,
 lagernummer_id,
 lageraufgabe_id,
 handling_unit_id_nach,
 artikelsortiment_id,
 handling_unit_id_ext,
 dat_lief_soll,
 lief_typ_id,
 kunde_id,
 lief_pal_typ_id,
 lief_pal_typ_dwh_id,
 werbeware_id,
 transportation_unit_id,
 kj_transportation_unit,
 datzeit_start_max,
 datzeit_erstellung,
 datzeit_start,
 datzeit_lezter_pick,
 datzeit_quittierung_bsf,
 datzeit_verladung,
 queue_id,
 welle_id,
 lagersortiment_id,
 lagerbereich_id_nach,
 lagertyp_id_nach,
 lagerplatz_id_nach,
 bsf_wechsel,
 dat_aktion,
 datzeit_bereitstellung,
 dat_tour,
 tdl_tms_gp_id,
 datzeit_quittierung_tour_erste_pal,
 datzeit_quittierung_tour_letzte_pal
FROM kfl_production_dbp_msi_data.lageraufgabe_wa_1;