--==============================================================
-- Table: lagerplatz_ewm_tag_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerplatz_ewm_tag_2
   generated from Powerdesigner on Donnerstag, 19. Januar 2023 14:59:52
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerplatz_ewm_tag_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer / Lagerkomplex.'),
lagerplatz_id STRING(18) NOT NULL OPTIONS(description='Lagerplatz.'),
dat DATE NOT NULL OPTIONS(description='Datum.'),
lagertyp_id STRING(4) OPTIONS(description='Lagertyp.'),
lagerbereich_id STRING(4) OPTIONS(description='Lagerbereich.'),
lagerplatztyp_id STRING(4) OPTIONS(description='Lagerplatztyp.'),
lagerplatz_zugriffstyp_id STRING(4) OPTIONS(description='Lagerplatz-Zugriffstyp.'),
lagerplatz_aufteilung_id STRING(1) OPTIONS(description='Lagerplatzaufteilung.'),
lagerplatz_position STRING(2) OPTIONS(description='Position auf dem Lagerplatz.'),
auslagerung_sperr_fg BIGNUMERIC(38,0) OPTIONS(description='Sperrkennzeichen: für Auslagerung.'),
einlagerung_sperr_fg BIGNUMERIC(38,0) OPTIONS(description='Sperrkennzeichen: für Einlagerung.'),
inventur_block_fg BIGNUMERIC(38,0) OPTIONS(description='Lagerplatz blockiert wegen Inventur.'),
aufgeteilt_fg BIGNUMERIC(38,0) OPTIONS(description='Lagerplatz ist aufgeteilt.'),
anz_hu BIGNUMERIC(38,0) OPTIONS(description='Anzahl der Handling Units im Lagerplatz.'),
anz_hu_max BIGNUMERIC(38,0) OPTIONS(description='Maximale Anzahl der Handling Unit_2 auf dem Lagerplatz.'),
gewicht_max NUMERIC(15,3) OPTIONS(description='Maximalgewicht des Lagerplatzes.'),
gew_einh_id STRING(3) OPTIONS(description='Gewichtseinheit.'),
gewicht NUMERIC(15,3) OPTIONS(description='Gewicht der Materialien auf dem Lagerplatz.'),
volumen_netto NUMERIC(15,3) OPTIONS(description='Ladungs- oder Nettovolumen.'),
volumen_max NUMERIC(15,3) OPTIONS(description='Maximalvolumen.'),
vol_einh_id STRING(3) OPTIONS(description='Volumeneinheit.'),
kapa_max NUMERIC(15,3) OPTIONS(description='Gesamtkapazität des Lagerplatzes.'),
kapa_frei NUMERIC(15,3) OPTIONS(description='Freie Kapazität auf dem Lagerplatz.'),
leer_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Lagerplatz leer.'),
voll_fg BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen, ob der Platz voll ist.'),
dat_erste_einlagerung DATE OPTIONS(description='Datum der ersten Einlagerung.'),
datzeit_letzte_bewegung DATETIME OPTIONS(description='Letzte Bewegung auf dem Platz.'),
lageraufgabe_id_letzte_bew BIGNUMERIC(38,0) OPTIONS(description='Lageraufgabe_2 der letzten Bewegung.'),
brandabschnitt_id STRING(2) OPTIONS(description='Brandabschnitt.'),
datzeit_aenderung DATETIME OPTIONS(description='Änderungszeitpunkt.'),
haupt_lagerplatz_id STRING(18) OPTIONS(description='Lagerplatz.'),
loc_guid STRING(32) OPTIONS(description='GUID Lokation.'),
handling_unit_guid STRING(32) OPTIONS(description='Eindeutige interne Identifikation einer HU.'),
gang_id BIGNUMERIC(38,0) OPTIONS(description='Lagerplatzgang.'),
saeule_id BIGNUMERIC(38,0) OPTIONS(description='Lagerplatzsäule.'),
ebene_id STRING(10) OPTIONS(description='Lagerplatzebene.'),
x_koordinate NUMERIC(10,3) OPTIONS(description='X-Koordinate.'),
y_koordinate NUMERIC(10,3) OPTIONS(description='Y-Koordinate.'),
z_koordinate NUMERIC(10,3) OPTIONS(description='Z-Koordinate.'),
lagernereich_lgst_id STRING(4) OPTIONS(description='Lagerungsgruppe für die Layoutorientierung.'),
feldtyp_id STRING(4) OPTIONS(description='Feldtyp.'),
regaltyp_id STRING(4) OPTIONS(description='Regaltyp.'),
wa_lane_kapa NUMERIC(4,2) OPTIONS(description='Warenausgang Lane Kapazität.'),
we_lane_kapa NUMERIC(4,2) OPTIONS(description='Wareneingang Lane Kapazität.'),
kapa_erh_fg BIGNUMERIC(38,0) OPTIONS(description='Kapazität für Lane Management erhöhen.'),
tiefe_frei BIGNUMERIC(38,0)
OPTIONS(description='Freie Platztiefe in Mengeneinheit. Die Einheit ist je nach Lagertyp unterschiedlich, wobei die lagertyp_id darüber Aufschluss geben kann. Es kann z.B. eine_2 Palettenart sein, ein Schnelldreher Durchlauflager für eine_2 Kolliart, ein Lagerort zur Umlagerung_2, etc.'),
tiefe_max BIGNUMERIC(38,0)
OPTIONS(description='Maximale Platztiefe in Mengeneinheit. Die Einheit ist je nach Lagertyp unterschiedlich, wobei die lagertyp_id darüber Aufschluss geben kann. Es kann z.B. eine_2 Palettenart sein, ein Schnelldreher Durchlauflager für eine_2 Kolliart, ein Lagerort zur Umlagerung_2, etc.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lagernummer_id, lagerplatz_id) NOT ENFORCED
) OPTIONS(description='LOG - Lagerplatz EWM. Bestandsdaten täglich um 12 Uhr, basierend auf lagerplatz_ewm_per.');