--==============================================================
-- Table: cd_typ_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: cd_typ_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:16 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.cd_typ_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
cd_typ_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Typ des CD-Belegs, z.Bsp. 2 ist CD Fleischwerk. Quelle ist zzlvcd'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.            '),
cd_typ_bez STRING(50) COLLATE 'und:ci' OPTIONS(description='Kurzbschreibung des CD-Typs, z.Bsp. CD Fleischwerk'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP408_LVS - Sprachabhängige Bezeichnungen der Cross-Docking Typen aus der Wertehilfe ZLVCD');