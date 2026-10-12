CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_cos_bonuspunkte_tag (crm_konto_id
OPTIONS(description='CRM-interne ID des Loyaltyaccounts/Bonuskontos.'), dat
OPTIONS(description='Datum für Tagesstand der Bonuspunkte.'), bonuspunkte_kanal_id
OPTIONS(description='Die Plattform, auf der die Bonuspunkte erzielt oder ausgegeben wurden.ZB: Markplatz, Filiale.'),
mandant_id OPTIONS(description='KFL-Land des Kundenkontos, das an Loyalty-Programms teilnimmt.'), anz_bonuspunkte
OPTIONS(description='Die tägliche gesamte anzahl an Bonuspunkten auf das Konto.'))
OPTIONS(DESCRIPTION = `DIE TABELLE ENTHÄLT DIE TÄGLICHEN BONUSPUNKTEN EINES KUNDEN.`) AS SELECT crm_konto_id,
 dat,
 bonuspunkte_kanal_id,
 mandant_id,
 anz_bonuspunkte
FROM kfl_production_dbp_msi_data.cos_bonuspunkte_tag;