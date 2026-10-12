CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mdl_vis_bereich_spr_zu_1 (
bereich_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Bereich ID '),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
bereich_bez STRING(80) OPTIONS(description='Bereich DESC'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Sprachenabhängige Bezeichnungen der Bereiche');