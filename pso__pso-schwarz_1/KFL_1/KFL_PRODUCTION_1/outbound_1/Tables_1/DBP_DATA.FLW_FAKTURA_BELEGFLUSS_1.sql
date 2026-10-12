--==============================================================
-- Table: flw_faktura_belegfluss_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_faktura_belegfluss_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_faktura_belegfluss_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
lief_beleg_id INTEGER NOT NULL OPTIONS(description='Nummer, die die Lieferung eindeutig identifiziert. Quelle vbeln'),
lief_beleg_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Position des Lieferbelegs aus SAP posnr'),
folge_beleg_id INTEGER NOT NULL OPTIONS(description='Faktura Belegnummer aus vbeln'),
folge_beleg_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Belegposition aus posnr'),
folge_beleg_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichnet die Art_1 des Folgevertriebsbelegtyps: M = Faktura, R=Warenbewegung'),
lief_beleg_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kenzeichnet die Art_1 des Vorgängervertriebsbelegtyp aus vbtyp_v'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, lief_beleg_id, lief_beleg_pos_id, folge_beleg_id, folge_beleg_pos_id) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='FLW - Vertriebsbelegfluss aus der Quelle SAP FLW');