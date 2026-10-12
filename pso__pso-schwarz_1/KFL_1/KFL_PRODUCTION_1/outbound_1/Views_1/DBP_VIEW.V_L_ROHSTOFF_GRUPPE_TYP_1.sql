CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_rohstoff_gruppe_typ_1 (rohstoff_gruppe_typ_id
OPTIONS(description='ID des Gruppierungstyps eines Rohstoffs.'), rohstoff_gruppe_typ_bez
OPTIONS(description='Bezeichnung des Gruppierungstyps eines Rohstoffs.'))
OPTIONS(DESCRIPTION = `LOOKUP TABELLE FÜR GRUPPIERUNGSTYP EINES ROHSTOFFS - KFL KATEGORIE, KFL SUBKATEGORIE, MINTEC KATEGORIE, MINTEC SUBKATEGORIE`)
AS SELECT rohstoff_gruppe_typ_id,
 rohstoff_gruppe_typ_bez
FROM kfl_production_dbp_data.l_rohstoff_gruppe_typ_1;