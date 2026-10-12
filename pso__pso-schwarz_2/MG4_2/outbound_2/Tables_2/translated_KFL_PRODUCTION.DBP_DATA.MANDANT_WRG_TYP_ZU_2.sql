CREATE OR REPLACE TABLE kfl_production_dbp_data.mandant_wrg_typ_zu_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wrg_typ_id INTEGER NOT NULL OPTIONS(description='Es gibt zwei Typen der Währung - Land_2 = 1 und Euro = 0'),
wrg_id STRING(12) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
wrg_typ_bez STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung des Währungstyps. Kann Land_2 oder Euro sein.'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='LIS - Legt pro Mandant_2 und Währungstyp eine_2 Währung fest');