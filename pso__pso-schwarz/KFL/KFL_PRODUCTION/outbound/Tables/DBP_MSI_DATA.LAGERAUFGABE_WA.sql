--==============================================================
-- Table: lageraufgabe_wa
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lageraufgabe_wa
   generated from Powerdesigner on Dienstag, 4. April 2023 14:21:06
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.lageraufgabe_wa (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex'),
lageraufgabe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lageraufgabe'),
handling_unit_id_nach STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Nach-Handling-Unit'),
artikelsortiment_id STRING(1) OPTIONS(description='Kauflandspezifische Info Sortiments ID'),
handling_unit_id_ext STRING(20) COLLATE 'und:ci'
OPTIONS(description='Externe Handling Unit Identifikation aus exidv. Nummer der Versandeinheit (NVE).'),
dat_lief_soll DATE OPTIONS(description='Lieferdatum der Position.'),
lief_typ_id STRING(4) COLLATE 'und:ci'
OPTIONS(description='Klassifikation, mit der zwischen verschiedenen Arten der Lieferung unterschieden wird. Die Lieferart bestimmt, wie das System eine Lieferung bearbeitet.'),
kunde_id BIGNUMERIC(38,0)
OPTIONS(description='Die Kunde ID ist die wup_id des belieferten Marktes. Dazu gibt es auch eine mandant_id_kunde.'),
lief_pal_typ_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Der Palettentyp einer Lieferung kennzeichnet, ob es sich um eine Ganzpalettenlieferung, Mischpalettenlieferung, Lieferung je Markt, etc., handelt.'),
lief_pal_typ_dwh_id STRING(2) COLLATE 'und:ci'
OPTIONS(description='Abgeleiteter Palettentyp (6 wird in 61 und 64 unterteilt),'),
werbeware_id STRING(1) COLLATE 'und:ci'
OPTIONS(description='Aus besch_lief: Wird gefüllt, wenn die Bestellart eine Werbebestellart ist. Wertevorrat: W = Werbung, N = Normalware, B = Beides W und N, S = Schnellschuss.'),
transportation_unit_id BIGNUMERIC(38,0) OPTIONS(description='Transporteinheit (intern).'),
datzeit_start_max DATETIME OPTIONS(description='Spätester Starttermin (SST)      '),
datzeit_erstellung DATETIME OPTIONS(description='Erstellungszeitpunkt'),
datzeit_start DATETIME OPTIONS(description='Startzeitpunkt'),
datzeit_lezter_pick DATETIME OPTIONS(description='zeitpunkt letzter pick'),
datzeit_quittierungs_bsf DATETIME OPTIONS(description='quittierungszeitpunkt bereitstellfläche'),
datzeit_verladung DATETIME OPTIONS(description='zeitpunkt verladung'),
queue_id STRING(10) COLLATE 'und:ci' OPTIONS(description='Queue'),
welle_id BIGNUMERIC(38,0)
OPTIONS(description='Welle. Logical grouping of tasks (lageraufgabe) that are performed together (in one wave)'),
lagersortiment_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Lagersortiment ID.'),
lagerbereich_id_nach STRING(4) COLLATE 'und:ci' OPTIONS(description='Nachlagerbereich'),
lagertyp_id_nach STRING(4) COLLATE 'und:ci' OPTIONS(description='Nach-Lagertyp'),
lagerplatz_id_nach STRING(18) COLLATE 'und:ci' NOT NULL OPTIONS(description='Nachlagerplatz'),
bsf_wechsel STRING(1) NOT NULL OPTIONS(description='flag: wechsel der bereitstellfläche'),
dat_aktion DATE OPTIONS(description='Werbedatum.'),
datzeit_bereitstellung DATETIME OPTIONS(description='Bereitstelllzeitstempel'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lageraufgabe_id) NOT ENFORCED
)
OPTIONS(description='Aggregated table that stores the result of joining LAGERAUFGABE , BESCH_LIEF_WA_DET, LAGERAUFTRAG, PROTOKOLL_VERLADUNG_EWM, BESCH_LIEF             This table contains 1 rows per Warehouse (lagernummer_id), Warehouse Task (lageraufgabe_id), Handling Unit that is the destination of the task (handling_unit_id_nach) and Mandant');