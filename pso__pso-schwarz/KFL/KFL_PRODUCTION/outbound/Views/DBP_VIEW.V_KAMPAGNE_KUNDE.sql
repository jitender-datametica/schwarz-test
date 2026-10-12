CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kampagne_kunde (mandant_id OPTIONS(description='Mandant im DWH.'),
kampagne_kunde_id
OPTIONS(description='Vom Quellsystem generierte ID des Kunden (GUID). Es ist der Empfänger der von Kampagnen gesendeten Nachrichten.'))
OPTIONS(DESCRIPTION = `DIE TABELLE ENTHÄLT DIE NUTZER, BZW. KUNDEN, AN DIE IM ZUGE VON MARKETINGKAMPAGNEN NACHRICHTEN GESCHICKT WERDEN. SIE DIENT DAZU, DIE EMPFÄNGER VON VERSCHIEDENEN KOMMUNIKATIONSPUNKTEN WIE E-MAILS, PUSH-BENACHRICHTIGUNGEN UND SMS ZU DEFINIEREN UND ZU VERWALTEN.`)
AS SELECT mandant_id,
 kampagne_kunde_id
FROM kfl_production_dbp_data.kampagne_kunde;