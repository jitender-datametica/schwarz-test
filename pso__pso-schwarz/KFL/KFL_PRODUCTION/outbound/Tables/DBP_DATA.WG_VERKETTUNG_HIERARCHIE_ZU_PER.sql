--==============================================================
-- Table: wg_verkettung_hierarchie_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wg_verkettung_hierarchie_zu_per
   generated from Powerdesigner on Dienstag, 28. September 2021 15:20:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wg_verkettung_hierarchie_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wg_verkett_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warengruppenverkettungskennzeichen'),
wg_verkett_hier_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='LVS:Warengruppenverkettungshierarchie'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode. Format JJJJ-MM-TT '),
dat_bis DATE OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM-TT'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Warengruppenverkettungshierarchie zuordnen');