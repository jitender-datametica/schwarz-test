CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_rohstoff_gruppe_zuordnungstyp (rohstoff_gruppe_zuordnungstyp_id
OPTIONS(description='ID der Zurodnungstyp zwischen Rohstoffgruppen.'), rohstoff_gruppe_zuordnungstyp_bez
OPTIONS(description='Bezeichnung des Zuordnungstyps zwischen Rohstoffgruppen.'))
OPTIONS(DESCRIPTION = `LOOKUP TABELLE FÜR ZURODNUNGSTYP ZWISCHEN ROHSTOFFGRUPPEN.(ZB: ZUORDNUNG ZWISCHEN KFL KATEGORIE UND KFL SUBKATEGORIE..)`)
AS SELECT rohstoff_gruppe_zuordnungstyp_id,
 rohstoff_gruppe_zuordnungstyp_bez
FROM kfl_production_dbp_data.l_rohstoff_gruppe_zuordnungstyp;