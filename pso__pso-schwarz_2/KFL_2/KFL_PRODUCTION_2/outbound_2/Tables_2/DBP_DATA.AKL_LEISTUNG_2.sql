CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.akl_leistung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lagernummer/Lagerkomplex'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
dat DATE NOT NULL OPTIONS(description='Datum im Format JJJJ-MM_2-TT'),
stunde BIGNUMERIC(38,0) OPTIONS(description='Stunde         '),
lagertyp_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Lagertyp'),
meldepunkt STRING(6) OPTIONS(description='Meldepunkt'),
warenbewegungstyp_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Warenbewegungstyp'),
lager_einheiten_typ STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Lagereinheittyp: Der Lager-Einheiten_Typ betrifft die Höhe einer Palette (z.Bsp. P3 = Palette Höhe 3 (165)). Aus letyp'),
menge_lbs_lvs_palette BIGNUMERIC(38,0) OPTIONS(description='Anzahl Behälter'),
menge_lbs_lvs_kolli BIGNUMERIC(38,0) OPTIONS(description='Anzahl Kolli'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Leistungsdaten AKL');