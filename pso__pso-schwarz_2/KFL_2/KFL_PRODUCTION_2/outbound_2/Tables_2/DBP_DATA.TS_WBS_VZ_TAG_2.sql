CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_wbs_vz_tag_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE NOT NULL OPTIONS(description='Datum'),
non_adjustable_day_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Flag: Datum ist für die Nachversorgung als "non adjustable" markiert'),
kommentar STRING(100) OPTIONS(description='Kommentar (Non-adjustable day)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Steuertabelle WBS');