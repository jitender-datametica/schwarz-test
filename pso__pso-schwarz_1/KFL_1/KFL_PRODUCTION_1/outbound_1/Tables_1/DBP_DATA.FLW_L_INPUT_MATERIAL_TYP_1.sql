--==============================================================
-- Table: flw_l_input_material_typ_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_input_material_typ_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_input_material_typ_1 (
input_material_typ_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Typ des inputmaterials aus itypm. Z.Bsp. I = Input (Zukauf), A = Eingang (Vorstufe), N = Gesamt'),
input_material_typ_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung des Input Material Typs, z.Bsp. "Weiterverwendung"'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
)
OPTIONS(description='FLW - Lookup-Tabelle der Input Materialtypen. Tabelle wird nicht über SST befüllt, sondern über die Fakten');