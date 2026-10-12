CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_sortiment_preisklasse_wug_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID. Kennzeichnet'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
wug_id BIGNUMERIC(38,0) NOT NULL,
wrg_id STRING(12) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
preislage_1 NUMERIC(9,2) NOT NULL OPTIONS(description='Obergrenze der 1. Preislage'),
preislage_2 NUMERIC(9,2) NOT NULL OPTIONS(description='Obergrenze der 2. Preislage'),
preislage_3 NUMERIC(9,2) NOT NULL OPTIONS(description='Obergrenze der 3. Preislage'),
preislage_4 NUMERIC(9,2) NOT NULL OPTIONS(description='Obergrenze der 4. Preislage'),
preislage_5 NUMERIC(9,2) NOT NULL OPTIONS(description='Obergrenze der 5. Preislage'),
preislage_6 NUMERIC(9,2) NOT NULL OPTIONS(description='Obergrenze der 6. Preislage'),
preislage_7 NUMERIC(9,2) NOT NULL OPTIONS(description='Obergrenze der 7. Preislage'),
preislage_8 NUMERIC(9,2) NOT NULL OPTIONS(description='Obergrenze der 8. Preislage'),
preislage_9 NUMERIC(9,2) NOT NULL OPTIONS(description='Obergrenze der 9. Preislage'),
preislage_10 NUMERIC(9,2) NOT NULL OPTIONS(description='Obergrenze der 10. Preislage'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='EK-INTEGER  - Sortimentstool - Preisklassen zur Darstellung der Preislagen pro Warenuntergruppe (WGI) (manueller Upload der Daten durch MSI-Transaktionservice)');