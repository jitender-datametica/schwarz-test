--==============================================================
-- Table: hydra_leistung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hydra_leistung
   generated from Powerdesigner on Montag, 22. August 2022 13:09:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.hydra_leistung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
buchungskreis_id_hydra STRING(4) NOT NULL OPTIONS(description='Buchungskreis aus Hydra'),
produktivitaetsschl_hydra STRING(14) NOT NULL OPTIONS(description='Produktivitätsschlüssel aus Hydra'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer / Lagerkomplex   '),
transport_gv_id STRING(18) NOT NULL OPTIONS(description='Geschäftsvorfall'),
belegart_id_hydra STRING(4) NOT NULL OPTIONS(description='Belegart aus Hydra'),
wg_verkett_lief BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WG-Verkettung Lieferung'),
dat DATE NOT NULL OPTIONS(description='Feld vom Typ DATS         '),
menge_1 NUMERIC(15,3) OPTIONS(description='Stück für Kennzahl 1'),
dauer_1 NUMERIC(9,2) OPTIONS(description='Dauer für Kennzahl 1 in Stunden'),
menge_2 NUMERIC(15,3) OPTIONS(description='Stück für Kennzahl 2'),
dauer_2 NUMERIC(9,2) OPTIONS(description='Dauer für Kennzahl 2 in Stunden'),
menge_3 NUMERIC(15,3) OPTIONS(description='Stück für Kennzahl 3'),
dauer_3 NUMERIC(9,2) OPTIONS(description='Dauer für Kennzahl 3 in Stunden'),
menge_4 NUMERIC(15,3) OPTIONS(description='Stück für Kennzahl 4'),
dauer_4 NUMERIC(9,2) OPTIONS(description='Dauer für Kennzahl 4 in Stunden'),
abrechnung_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag gibt an ob die Abrechnung erfolgt ist und die Daten sich somit nicht mehr ändern'),
personalteilbereich_id STRING(4)
OPTIONS(description='Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, buchungskreis_id_hydra, produktivitaetsschl_hydra, lagernummer_id, transport_gv_id,
 belegart_id_hydra, wg_verkett_lief, dat) NOT ENFORCED
) OPTIONS(description='2DO - for clarification');