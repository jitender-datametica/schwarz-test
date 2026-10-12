/* --------------------------------------------------------------------------------
   DDL for table: t_ref_pick_area_descr_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_pick_area_descr_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse; FK auf LOCATION_2'),
lang_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key REPORT LANGUAGE'),
lang_cd STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Sprache - Code; '),
pick_area_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Greif-/Lagerzone / Kommisionierungsbereich'),
pick_area_descr STRING(100) NOT NULL OPTIONS(description='Greif-/Lagerzone - Beschreibung'),
pick_main_area_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Haupt-Greif-/Lagerzone  / Kommisionierungsbereich'),
pick_main_area_descr STRING(100) NOT NULL OPTIONS(description='Haupt-Greif-/Lagerzone - Beschreibung'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (loc_sid, pick_area_id, lang_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Greifzone / Kommissionierungsbereich             fuer WHs aus SAP-Laendern wird die Lagerzone assoziiert             Bsp: Picking Area 16 : Verbrauchsmaterial --> Picking Main Area 10 (=HR HochRegal)             ...             WAWI-DWH: t_itm_pp_picking_area');