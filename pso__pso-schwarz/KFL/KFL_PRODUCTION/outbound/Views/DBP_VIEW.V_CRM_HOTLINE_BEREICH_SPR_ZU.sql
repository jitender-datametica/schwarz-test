CREATE OR REPLACE VIEW kfl_production_dbp_view.v_crm_hotline_bereich_spr_zu (mandant_id
OPTIONS(description='Mandant im DWH.'), crm_hotline_bereich_id
OPTIONS(description='ID des Bereichs innerhalb der CRM-Hotline, an den der Anruf zugestellt wurde. Dieser Wert kategorisiert, welche Abteilung oder welches Team den Anruf entgegengenommen hat.'),
spr_id OPTIONS(description='ID der Sprache'), crm_hotline_bereich_bez
OPTIONS(description='Bezeichnung des Bereichs innerhalb der CRM-Hotline.'))
OPTIONS(DESCRIPTION = `DIESE TABELLE ENTHÄLT DIE SPRACHABHÄNGIGEN BEZEICHNUNGEN DER CRM-HOTLINE-BEREICHE. SIE WIRD MANUELL BEFÜLLT.`)
AS SELECT mandant_id,
 crm_hotline_bereich_id,
 spr_id,
 crm_hotline_bereich_bez
FROM kfl_production_dbp_data.crm_hotline_bereich_spr_zu;