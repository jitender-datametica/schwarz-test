--==============================================================
-- Table: lagerbestand_ewm_tag_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lagerbestand_ewm_tag_2
   generated from Powerdesigner on Mittwoch, 15. November 2023 13:36:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.lagerbestand_ewm_tag_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
parent_guid STRING(32) NOT NULL OPTIONS(description='Parent GUID'),
lagerbestand_guid STRING(32) NOT NULL OPTIONS(description='GUID Stock Item_2'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer'),
dat DATE NOT NULL OPTIONS(description='Datum'),
lagertyp_id STRING(4) OPTIONS(description='Storage Type'),
lagerbereich_id STRING(4) OPTIONS(description='Storage Section'),
lagerplatz_id STRING(18) OPTIONS(description='Storage Bin'),
handling_unit_id STRING(20) OPTIONS(description='Handling Unit_2 Identification'),
handling_unit_id_top STRING(20) OPTIONS(description='Handling Unit_2 Identification'),
art_guid STRING(32) OPTIONS(description='Product'),
art_id BIGNUMERIC(38,0)
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
charge_id STRING(10) OPTIONS(description='Batch'),
lagerbestand_typ_id STRING(2) OPTIONS(description='Stock Type'),
verfuegungsberechtigter_id BIGNUMERIC(38,0) OPTIONS(description='Party Entitled to Dispose (gp_id)'),
eigentuemer_id BIGNUMERIC(38,0) OPTIONS(description='Owner (gp_id)'),
bestand_belegtyp_id STRING(3) OPTIONS(description='Type: Sales_2 Order Stock or Project Stock'),
bestand_beleg_id BIGNUMERIC(38,0) OPTIONS(description='Number of the Sales_2 Order or Project for Special Stock'),
bestand_belegnummer_ext STRING(35) OPTIONS(description='External Number of Sales_2 Order/Project (Special Stock)'),
bestand_beleg_pos_id BIGNUMERIC(38,0) OPTIONS(description='Sales_2 Order Item_2 for Sales_2 Order Stock'),
bestand_verwendung_id STRING(1) OPTIONS(description='Stock Usage'),
referenz_belegtyp_id STRING(3) OPTIONS(description='Doc. Category for Doc. Reference and Doc.-Related Stocks'),
dat_wareneingang DATE OPTIONS(description='Goods Receipt Date'),
dat_mhd DATE OPTIONS(description='Best-Before Date / Shelf Life Expiration Date'),
herkunftsland_id STRING(3) OPTIONS(description='Country_2 of Origin'),
bestand_id BIGNUMERIC(38,0) OPTIONS(description='Identification Number of Stock'),
ref_belegtyp_id STRING(3) OPTIONS(description='Doc. Category for Doc. Reference and Doc.-Related Stocks'),
ref_beleg_id BIGNUMERIC(38,0) OPTIONS(description='Document Number for Stock Reference'),
ref_beleg_pos_id BIGNUMERIC(38,0) OPTIONS(description='Item_2 Number of Stock Reference'),
pruef_typ_id STRING(1) OPTIONS(description='Inspection Type'),
pruef_beleg_id BIGNUMERIC(38,0) OPTIONS(description='QIE Entity: External Identification'),
gewicht_netto NUMERIC(18,3) OPTIONS(description='Loading/Net Weight'),
gew_einh_id STRING(3) OPTIONS(description='Weight Unit_2'),
volumen_netto NUMERIC(18,3) OPTIONS(description='Loading/Net Volume'),
vol_einh_id STRING(3) OPTIONS(description='Volume Unit_2'),
kapa_verbrauch NUMERIC(18,3) OPTIONS(description='Capacity Consumption'),
menge NUMERIC(18,3) OPTIONS(description='Quantity'),
menge_einh_id STRING(3) OPTIONS(description='Base Unit_2 of Measure'),
menge_altnv NUMERIC(18,3) OPTIONS(description='Packed Quantity in Alternative Unit_2 of Measure'),
altnv_menge_einh_id STRING(3) OPTIONS(description='Alternative Unit_2 of Measure for Stock-keeping Unit_2'),
menge_bewertung NUMERIC(18,3) OPTIONS(description='Actual Valuation Quantity (for UI)'),
bew_menge_einh_id STRING(3) OPTIONS(description='Unit_2 for Valuation Quantity'),
wert NUMERIC(18,3) OPTIONS(description='Product Value'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
konsolidierungsgruppe_id STRING(10) OPTIONS(description='Consolidation Group'),
psa_id BIGNUMERIC(38,0) OPTIONS(description='Production Supply Area (PSA)'),
lagerplatz_typ_id STRING(4) OPTIONS(description='Storage Bin Type'),
lagertyprolle_id STRING(1) OPTIONS(description='Storage Type Role'),
gang_id BIGNUMERIC(38,0) OPTIONS(description='Aisle in a Storage Bin'),
saeule_id BIGNUMERIC(38,0) OPTIONS(description='Stack in a Storage Bin'),
ebene_id STRING(10) OPTIONS(description='Level in a Storage Bin'),
lagereinheitentyp_id STRING(4) OPTIONS(description='Handling Unit_2 Type'),
lagereinheitentyp_id_top STRING(4) OPTIONS(description='Top Handling Unit_2 Type'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
gefahrgut_id_1 STRING(5) OPTIONS(description='Hazard Rating'),
gefahrgut_id_2 STRING(5) OPTIONS(description='Hazard Rating'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, parent_guid, lagerbestand_guid, lagernummer_id, dat) NOT ENFORCED
)
OPTIONS(description='Lagerbestand aus SAP EWM, Datasource 0WM_STOCK. Tabelle enthält den am jeweiligen Tag_2 (12:00 Uhr Mittag) vorhandenen Bestand an einem Lagerplatz im VZ wobei dort mehrere Positionen/HUs gelagert sein können');