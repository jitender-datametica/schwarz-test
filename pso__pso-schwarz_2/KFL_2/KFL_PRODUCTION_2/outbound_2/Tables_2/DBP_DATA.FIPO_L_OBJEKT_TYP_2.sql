--==============================================================
-- Table: fipo_l_objekt_typ_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: fipo_l_objekt_typ_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.fipo_l_objekt_typ_2 (
fipo_objekt_typ_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID des FIPO-Opbjekttyps aus dem Quellfeld obt_id'),
fipo_objekt_typ_bez STRING(50) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des FIP-Objekttyps, z.Bsp. Filiale, Gastro. Aus dem Quellfeld obt_bezeichnung'),
fipo_sap_vkorg STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Verkaufsorganisation des Objekttyps, z.Bsp. KLR. Aus dem Quellfeld obt_sap_vkorg'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (fipo_objekt_typ_id) NOT ENFORCED
) OPTIONS(description='FIPO - Lookup Tabelle der FIPO-Objekttypen');