--==============================================================
-- Table: auslieferung_kopf_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: auslieferung_kopf_1
   generated from Powerdesigner on Mittwoch, 5. Juli 2023 10:31:29
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.auslieferung_kopf_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
beleg_guid STRING(32) NOT NULL OPTIONS(description='Beleg-ID.'),
belegtyp_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Belegtyp.'),
belegart_id STRING(4) OPTIONS(description='Belegart - Document type of the Delivery Order'),
beleg_id BIGNUMERIC(35,0) OPTIONS(description='Belegnummer.'),
odo_typ_id STRING(1)
OPTIONS(description='Outbound Delivery Order - Typ (leer = geplant, 0 = ausführbar, 1 = abweichend)'),
lief_pal_typ_akaf_id STRING(1)
OPTIONS(description='the type of pallet that is assembled by this automatic picking/assembling machine (AKAF)'),
anz_lt_geplant STRING(5) OPTIONS(description='Anzahl geplante Ladungsträger (Number of planned load carriers)'),
anz_hu_geplant STRING(1) OPTIONS(description='Anzahl geplanten Handling Units (Number of planned handling units)'),
akaf_anfragenummer STRING(20)
OPTIONS(description='Key of transaction/operation that was performed by the automated picking machine (AKAF) in system that operates the machine'),
datzeit_erstellung DATETIME OPTIONS(description='Anlagetimestamp.'),
datzeit_aenderung DATETIME OPTIONS(description='Aenderungstimestamp.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, beleg_guid) NOT ENFORCED
) OPTIONS(description='Outbound Delivery Order Header.');