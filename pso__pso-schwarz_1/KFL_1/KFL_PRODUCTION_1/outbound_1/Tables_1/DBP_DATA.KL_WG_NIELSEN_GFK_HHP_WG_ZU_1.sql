CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kl_wg_nielsen_gfk_hhp_wg_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
kl_wg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID Kaufland Unterwarengruppen für Nielsen-Daten (Vergabe im Beladeprozess)'),
gfk_wg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der GfK Warengruppe aus dem Haushaltspanel(wird manuell im DWH generiert)'),
td_update TIMESTAMP,
td_insert TIMESTAMP
)
OPTIONS(description='EK-INTEGER  - Sortimentstool - Mapping-Tabelle Kaufland Warengruppen für Nielsen (kl_wg_id) zu GfK Haushaltspanel Warengruppe (gfk_wg_id) - wird durch einen TS-Bericht aus MSI vom FB gepflegt');