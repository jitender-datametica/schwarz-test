--==============================================================
-- Table: ts_wup_tm_gp_kosten_upload_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wup_tm_gp_kosten_upload_per_2
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:14
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_wup_tm_gp_kosten_upload_per_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_gp_id STRING(30) NOT NULL OPTIONS(description='ID des Geschäftspartners. Aus plkd.nr  (hier: Spedition)'),
tms_gp_typ_cd STRING(3) NOT NULL
OPTIONS(description='Geschäftspartnertyp. L- Lager, S - Spediteur, 0(null) - Markt(Kunde)     (hier: nur Speditionen)'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum  (hier: nur Werk)'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
kosten_upload_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: für Touren die von einer gg. Spedition aus einem gg. VZ gefahren werden, werden Daten in der Tabelle transportation_unit_kosten_upload erwartet'),
dat_bis DATE NOT NULL OPTIONS(description='Gültig bis'),
dat_von DATE OPTIONS(description='Gültig von'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_gp_id, tms_gp_typ_cd, wup_id, nb_id, dat_bis) NOT ENFORCED
)
OPTIONS(description='Transaction Services Table - User can maintain when to expect a record in Upload Table (dbp_data.transportation_unit_kosten_2)  for a given TDL/DC combination');