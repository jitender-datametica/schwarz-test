CREATE OR REPLACE VIEW kfl_production_dbp_view.v_angebot_attribut_zu_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
angebot_nr OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'), angebot_attribut_id
OPTIONS(description='ID des Attributs'), angebot_attribut_txt
OPTIONS(description='Freitext für den Wert des Attributs. Dieser Wert kann sich je nach Bedeutung des Attributs unterscheiden.'))
OPTIONS(DESCRIPTION = `ZUORDNUNGSTABELLE ZWISCHEN EINEM ANGEBOT_1 UND DEM JEWEILS VERKNÜPFTEN ATTRIBUT UM WEITERE INFORMATIONEN DEM ANGEBOT_1 HINZUZUFÜGEN.`)
AS SELECT mandant_id,
 angebot_nr,
 angebot_attribut_id,
 angebot_attribut_txt
FROM kfl_production_dbp_data.angebot_attribut_zu_1;