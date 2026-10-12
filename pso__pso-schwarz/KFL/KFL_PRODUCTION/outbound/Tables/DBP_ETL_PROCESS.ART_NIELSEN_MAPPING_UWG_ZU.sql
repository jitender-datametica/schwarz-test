CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.art_nielsen_mapping_uwg_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_nielsen_tag STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='eindeutige Artikel-ID aus Nielsen '),
gtin_id INTEGER NOT NULL OPTIONS(description='Global Trade Item Number (GTIN)'),
art_nielsen_bez STRING(500) COLLATE 'und:ci' OPTIONS(description='Artikelbezeichnung aus Nielsen '),
kl_art_kat_id BIGNUMERIC(38,0)
OPTIONS(description='ID Kaufland Artikelkategorie für Nielsen-Daten (Vergabe im Beladeprozess)'),
kl_wg_id BIGNUMERIC(38,0) OPTIONS(description='ID Kaufland Warengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
kl_owg_id BIGNUMERIC(38,0)
OPTIONS(description='ID Kaufland Oberwarengruppe für Nielsen-Daten (Vergabe im Beladeprozess)'),
kl_uwg_id BIGNUMERIC(38,0)
OPTIONS(description='ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
td_update TIMESTAMP
OPTIONS(description='technical fields for synchronisation framework. will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='technical fields for synchronisation framework. will be delted after last product migration')
);