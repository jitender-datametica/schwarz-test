--==============================================================
-- Table: lagerbestand_ewm_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerbestand_ewm_per
   generated from Powerdesigner on Mittwoch, 15. November 2023 13:33:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerbestand_ewm_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
parent_guid STRING(32) NOT NULL OPTIONS(description='Parent GUID'),
lagerbestand_guid STRING(32) NOT NULL OPTIONS(description='GUID Stock Item'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer'),
datzeit_von DATETIME NOT NULL OPTIONS(description='Gültig von.'),
datzeit_bis DATETIME OPTIONS(description='Gültig bis.'),
lagertyp_id STRING(4) OPTIONS(description='Storage Type'),
lagerbereich_id STRING(4) OPTIONS(description='Storage Section'),
lagerplatz_id STRING(18) OPTIONS(description='Storage Bin'),
handling_unit_id STRING(20) OPTIONS(description='Handling Unit Identification'),
handling_unit_id_top STRING(20) OPTIONS(description='Handling Unit Identification'),
art_guid STRING(32) OPTIONS(description='Product'),
art_id BIGNUMERIC(38,0)
OPTIONS(description='Input: Artikel - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
charge_id STRING(10) OPTIONS(description='Batch'),
lagerbestand_typ_id STRING(2) OPTIONS(description='Stock Type'),
verfuegungsberechtigter_id BIGNUMERIC(38,0) OPTIONS(description='Party Entitled to Dispose (gp_id)'),
eigentuemer_id BIGNUMERIC(38,0) OPTIONS(description='Owner (gp_id)'),
bestand_belegtyp_id STRING(3) OPTIONS(description='Type: Sales Order Stock or Project Stock'),
bestand_beleg_id BIGNUMERIC(38,0) OPTIONS(description='Number of the Sales Order or Project for Special Stock'),
bestand_belegnummer_ext STRING(35) OPTIONS(description='External Number of Sales Order/Project (Special Stock)'),
bestand_beleg_pos_id BIGNUMERIC(38,0) OPTIONS(description='Sales Order Item for Sales Order Stock'),
bestand_verwendung_id STRING(1) OPTIONS(description='Stock Usage'),
referenz_belegtyp_id STRING(3) OPTIONS(description='Doc. Category for Doc. Reference and Doc.-Related Stocks'),
dat_wareneingang DATE OPTIONS(description='Goods Receipt Date'),
dat_mhd DATE OPTIONS(description='Best-Before Date / Shelf Life Expiration Date'),
herkunftsland_id STRING(3) OPTIONS(description='Country of Origin'),
bestand_id BIGNUMERIC(38,0) OPTIONS(description='Identification Number of Stock'),
ref_belegtyp_id STRING(3) OPTIONS(description='Doc. Category for Doc. Reference and Doc.-Related Stocks'),
ref_beleg_id BIGNUMERIC(38,0) OPTIONS(description='Document Number for Stock Reference'),
ref_beleg_pos_id BIGNUMERIC(38,0) OPTIONS(description='Item Number of Stock Reference'),
pruef_typ_id STRING(1) OPTIONS(description='Inspection Type'),
pruef_beleg_id BIGNUMERIC(38,0) OPTIONS(description='QIE Entity: External Identification'),
gewicht_netto NUMERIC(18,3) OPTIONS(description='Loading/Net Weight'),
gew_einh_id STRING(3) OPTIONS(description='Weight Unit'),
volumen_netto NUMERIC(18,3) OPTIONS(description='Loading/Net Volume'),
vol_einh_id STRING(3) OPTIONS(description='Volume Unit'),
kapa_verbrauch NUMERIC(18,3) OPTIONS(description='Capacity Consumption'),
menge NUMERIC(18,3) OPTIONS(description='Quantity'),
menge_einh_id STRING(3) OPTIONS(description='Base Unit of Measure'),
menge_altnv NUMERIC(18,3) OPTIONS(description='Packed Quantity in Alternative Unit of Measure'),
altnv_menge_einh_id STRING(3) OPTIONS(description='Alternative Unit of Measure for Stock-keeping Unit'),
menge_bewertung NUMERIC(18,3) OPTIONS(description='Actual Valuation Quantity (for UI)'),
bew_menge_einh_id STRING(3) OPTIONS(description='Unit for Valuation Quantity'),
wert NUMERIC(18,3) OPTIONS(description='Product Value'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
konsolidierungsgruppe_id STRING(10) OPTIONS(description='Consolidation Group'),
psa_id BIGNUMERIC(38,0) OPTIONS(description='Production Supply Area (PSA)'),
lagerplatz_typ_id STRING(4) OPTIONS(description='Storage Bin Type'),
lagertyprolle_id STRING(1) OPTIONS(description='Storage Type Role'),
gang_id BIGNUMERIC(38,0) OPTIONS(description='Aisle in a Storage Bin'),
saeule_id BIGNUMERIC(38,0) OPTIONS(description='Stack in a Storage Bin'),
ebene_id STRING(10) OPTIONS(description='Level in a Storage Bin'),
lagereinheitentyp_id STRING(4) OPTIONS(description='Handling Unit Type'),
lagereinheitentyp_id_top STRING(4) OPTIONS(description='Top Handling Unit Type'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
gefahrgut_id_1 STRING(5) OPTIONS(description='Hazard Rating'),
gefahrgut_id_2 STRING(5) OPTIONS(description='Hazard Rating'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, parent_guid, lagerbestand_guid, lagernummer_id, datzeit_von) NOT ENFORCED
)
OPTIONS(description='Lagerbestand aus SAP EWM, Datasource 0WM_STOCK. Tabelle enthält den im Gültigkeitsintervall vorhandenen Bestand an einem Lagerplatz im VZ wobei dort mehrere Positionen/HUs gelagert sein können.');