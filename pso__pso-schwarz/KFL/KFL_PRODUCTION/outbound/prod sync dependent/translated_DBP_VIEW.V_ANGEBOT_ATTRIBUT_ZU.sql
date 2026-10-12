CREATE OR REPLACE VIEW kfl_production_dbp_view.v_angebot_attribut_zu (mandant_id OPTIONS(description='Mandant im DWH'),
angebot_nr OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'), angebot_attribut_id
OPTIONS(description='ID des Attributs'), angebot_attribut_txt
OPTIONS(description='Freitext für den Wert des Attributs. Dieser Wert kann sich je nach Bedeutung des Attributs unterscheiden.'))
OPTIONS(DESCRIPTION = `Zuordnungstabelle zwischen einem Angebot und dem jeweils verknüpften Attribut um weitere Informationen dem Angebot hinzuzufügen.`)
AS SELECT mandant_id,
 angebot_nr,
 angebot_attribut_id,
 angebot_attribut_txt
FROM kfl_production_dbp_data.angebot_attribut_zu;