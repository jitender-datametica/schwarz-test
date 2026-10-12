CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gfk_hhp_wg (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
gfk_wg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der GfK Warengruppe aus dem Haushaltspanel(wird manuell im DWH generiert)'),
gfk_wg_bez STRING(240) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der GfK Warengruppe aus dem Haushaltspanel'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='EK-INTEGER  - GfK Haushaltspanel Warengruppe');