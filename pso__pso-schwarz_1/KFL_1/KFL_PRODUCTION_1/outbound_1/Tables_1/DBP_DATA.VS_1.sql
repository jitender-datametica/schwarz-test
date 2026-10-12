CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vs_1 (
vs_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Vertriebsschiene'),
vs_bez STRING(160) OPTIONS(description='Bezeichnung der Vertriebsschiene, z.Bsp. Nord'),
vk_id BIGNUMERIC(38,0) OPTIONS(description='Vertriebskanal ID'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
vsvt_bez STRING(160) OPTIONS(description='Bezeichnung, z.Bsp. Vertrieb Nord'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
vs_ref_wup_id BIGNUMERIC(38,0) OPTIONS(description='gibt den leitmarkt der region_1 an. wird manuell befüllt')
) OPTIONS(description='TP1_MIS - Vertriebsschiene');