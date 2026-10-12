CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wg_filter_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
wg_filter_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID Filter auf Warengruppen '),
wug_id BIGNUMERIC(38,0) OPTIONS(description='ID der Warenuntergruppe'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='VIS - Zuordnung WG-Filter-ID zu WG_ID (Warengruppen) - wird manuell beladen');