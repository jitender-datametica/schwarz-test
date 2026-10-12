CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kl_art_kat_nielsen (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
kl_art_kat_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID Kaufland Artikelkategorie für Nielsen-Daten (Vergabe im Beladeprozess)'),
kl_art_kat_bez STRING(200) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung Kaufland Artikelkategorie für Nielsen-Daten'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='EK-INTEGER  - Kaufland Artikelkategorien für Nielsen  (Hierarchie: Artikelkategorie (art_kat)- Warengruppe (wg)  - Oberwarengruppe (owg) - Unterwarengruppe (uwg))');