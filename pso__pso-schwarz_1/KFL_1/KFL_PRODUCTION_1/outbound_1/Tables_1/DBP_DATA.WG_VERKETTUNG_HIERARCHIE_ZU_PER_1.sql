--==============================================================
-- Table: wg_verkettung_hierarchie_zu_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wg_verkettung_hierarchie_zu_per_1
   generated from Powerdesigner on Dienstag, 28. September 2021 15:20:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wg_verkettung_hierarchie_zu_per_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_1 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0)
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wg_verkett_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warengruppenverkettungskennzeichen'),
wg_verkett_hier_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='LVS:Warengruppenverkettungshierarchie'),
dat_von DATE NOT NULL OPTIONS(description='Beginn der Gültigkeitsperiode. Format JJJJ-MM_1-TT '),
dat_bis DATE OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM_1-TT'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Warengruppenverkettungshierarchie zuordnen');