--==============================================================
-- Table: transportation_unit_hu_lief_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: transportation_unit_hu_lief_zu
   generated from Powerdesigner on Donnerstag, 10. Oktober 2024 13:32:35
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transportation_unit_hu_lief_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
transportation_unit_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Transporteinheit (intern)'),
kj_transportation_unit BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anlagejahr der Transporteinheit'),
transportation_unit_sr_act_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='transportation_unit_sr_act_id'),
transportation_unit_seq_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Reihenfolgenummer'),
compartment_hu_guid STRING(32) OPTIONS(description='GUID Handling Unit (Fach)'),
ladeposition BIGNUMERIC(38,0) OPTIONS(description='Postion am Fahrzeug / Transporteinheit'),
lagernummer_id STRING(4) COLLATE 'und:ci' OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'),
beleg_guid STRING(32) OPTIONS(description='Beleg-ID'),
beleg_pos_guid STRING(32) OPTIONS(description='Positions-ID'),
belegtyp_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Belegtyp'),
beleg_id BIGNUMERIC(35,0) OPTIONS(description='Belegnummer'),
beleg_pos_id BIGNUMERIC(38,0) OPTIONS(description='Positionsnummer'),
zuordnungsart_id STRING(1) COLLATE 'und:ci' OPTIONS(description='Zuordnungsart'),
top_hu_guid STRING(32) COLLATE 'und:ci' OPTIONS(description='GUID Handling Unit (Top)'),
top_hu_id STRING(32) OPTIONS(description='HUIDENT Handling Unit (Top)'),
cross_hu_fg STRING(1) COLLATE 'und:ci' OPTIONS(description='Flag: Lieferübergreifende HU'),
change_fg STRING(1) COLLATE 'und:ci' OPTIONS(description='Flag: Änderungsindikator'),
status_fg STRING(1) COLLATE 'und:ci' OPTIONS(description='Flag: Status'),
datzeit_erstellung DATETIME OPTIONS(description='Erstellungszeitpunkt'),
datzeit_aenderung DATETIME OPTIONS(description='Änderungszeitpunkt'),
auslieferung_exist_fg STRING(1) COLLATE 'und:ci' OPTIONS(description='Flag: Status "Auslieferung existiert"'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, transportation_unit_id, kj_transportation_unit, transportation_unit_sr_act_id,
 transportation_unit_seq_id) NOT ENFORCED
) OPTIONS(description='Transportation Unit, HU, Delivery');