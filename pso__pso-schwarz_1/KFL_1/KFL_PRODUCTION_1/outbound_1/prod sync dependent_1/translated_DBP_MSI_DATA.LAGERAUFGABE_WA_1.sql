CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.lageraufgabe_wa_1 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex'),
lageraufgabe_id INTEGER NOT NULL OPTIONS(description='Lageraufgabe_1'),
handling_unit_id_nach STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Nach-Handling-Unit_1'),
artikelsortiment_id STRING(1) OPTIONS(description='Kauflandspezifische Info Sortiments ID'),
handling_unit_id_ext STRING(20) COLLATE 'und:ci'
OPTIONS(description='Externe Handling Unit_1 Identifikation aus exidv. Nummer der Versandeinheit (NVE).'),
dat_lief_soll DATE OPTIONS(description='Lieferdatum der Position.'),
lief_typ_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Klassifikation, mit der zwischen verschiedenen Arten der Lieferung unterschieden wird. Die Lieferart bestimmt, wie das System eine_1 Lieferung bearbeitet.'),
kunde_id INTEGER
OPTIONS(description='Die Kunde ID ist die wup_id des belieferten Marktes. Dazu gibt es auch eine_1 mandant_id_kunde.'),
lief_pal_typ_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine_1 Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt, etc., handelt.'),
lief_pal_typ_dwh_id STRING(2) COLLATE 'und:ci'
OPTIONS(description='Abgeleiteter Palettentyp (6 wird in 61 und 64 unterteilt),'),
werbeware_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Aus besch_lief_1: Wird gefüllt, wenn die Bestellart eine_1 Werbebestellart ist. Wertevorrat: W = Werbung, N = Normalware, B = Beides W und N, S = Schnellschuss.'),
transportation_unit_id INTEGER OPTIONS(description='Transporteinheit (intern).'),
kj_transportation_unit INTEGER OPTIONS(description='Anlagejahr der Transporteinheit'),
datzeit_start_max DATETIME OPTIONS(description='Spätester Starttermin (SST)      '),
datzeit_erstellung DATETIME OPTIONS(description='Erstellungszeitpunkt'),
datzeit_start DATETIME OPTIONS(description='Startzeitpunkt'),
datzeit_lezter_pick DATETIME OPTIONS(description='zeitpunkt letzter pick'),
datzeit_quittierung_bsf DATETIME
OPTIONS(description='Quittierungszeitpunkt dieser einzelnen Palette auf der Bereitstellfläche (BSF)'),
datzeit_verladung DATETIME OPTIONS(description='zeitpunkt verladung'),
queue_id STRING(10) COLLATE 'und:ci' OPTIONS(description='Queue'),
welle_id INTEGER
OPTIONS(description='Welle. Logical grouping of tasks (lageraufgabe_1) that are performed together (in one wave)'),
lagersortiment_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Lagersortiment ID.'),
lagerbereich_id_nach STRING(4) COLLATE 'und:ci' OPTIONS(description='Nachlagerbereich'),
lagertyp_id_nach STRING(4) COLLATE 'und:ci' OPTIONS(description='Nach-Lagertyp'),
lagerplatz_id_nach STRING(18) COLLATE 'und:ci' NOT NULL OPTIONS(description='Nachlagerplatz'),
bsf_wechsel STRING(1) NOT NULL OPTIONS(description='flag: wechsel der bereitstellfläche'),
dat_aktion DATE OPTIONS(description='Werbedatum.'),
datzeit_bereitstellung DATETIME OPTIONS(description='Bereitstelllzeitstempel'),
dat_tour DATE OPTIONS(description='Tourdatum'),
tdl_tms_gp_id STRING(30)
OPTIONS(description='Geschäftspartner-ID des Transportdienstleisters (TDL). FK auf tms_gp_1 und der referenzierte Geschäftspartner-Typ(tms_gp_typ_cd) ist implizit\'S\' (Spediteur).'),
datzeit_quittierung_tour_erste_pal DATETIME
OPTIONS(description='Quittierungszeitpunkt der ersten Palette auf der Bereitstellfläche (BSF) (je Tour_1)'),
datzeit_quittierung_tour_letzte_pal DATETIME
OPTIONS(description='Quittierungszeitpunkt der letzten Palette auf der Bereitstellfläche (BSF) (je Tour_1)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lageraufgabe_id) NOT ENFORCED
)
OPTIONS(description='Aggregated table that stores the result of joining LAGERAUFGABE_1 , BESCH_LIEF_WA_DET_1, LAGERAUFTRAG_1, PROTOKOLL_VERLADUNG_EWM_1, BESCH_LIEF_1\n             This table contains 1 rows per Warehouse (lagernummer_id), Warehouse Task (lageraufgabe_id), Handling Unit_1 that is the destination of the task (handling_unit_id_nach) and Mandant_1');