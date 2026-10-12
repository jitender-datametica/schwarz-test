--==============================================================
-- Table: flw_art_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_art_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
flw_art_nr STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Artikelnummer aus SAP. Quelle ist mara.matnr'),
artikelart_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Ordnet das Material einer Gruppe_2 zu. Z.Bsp. HAWA, ZERL. Quelle ist mara.mtart. Lookup-Tabelle ist in FLW im Gegensatz zu IND nicht vorhanden'),
art_id BIGNUMERIC(38,0)
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
basismenge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Einheit der Basismenge, z.Bsp. kg aus mara.meins'),
bedarfsplan_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Quelle: spmeat_pbdnr. Enthält char-Angaben wie z.Bsp. hawa, schwein, rind,.... Findet sich auch in der Tabelle art_werk_prognose'),
best_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Einheit der Bestellmenge aus bstme'),
gew_einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Gewichtseinheit aus gewei'),
nettogew NUMERIC(18,3) NOT NULL OPTIONS(description='Nettogewicht aus ntgew'),
produktgruppe_id STRING(10) COLLATE 'und:ci'
OPTIONS(description='Produktguppe Id aus prodgr. Referenz zur Tabelle flw_produktgruppe_2'),
vol NUMERIC(18,3) NOT NULL OPTIONS(description='Volumen aus vol'),
vol_einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Volumeneinheit aus voleh'),
loesch_id STRING(2) COLLATE 'und:ci'
OPTIONS(description='MSTAE - ID des Loeschkennzeichens, z.Bsp. L fuer logisch geloeschte Artikel_2'),
dat_von_loesch_id DATE
OPTIONS(description='MSTDE - Datum, ab dem der betriebsübergreifende ArtStatus (DWH: loesch_id) gültig ist'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_art_id) NOT ENFORCED
) OPTIONS(description='FLW - Artikelstammdaten aus der Quelle MARA_2');