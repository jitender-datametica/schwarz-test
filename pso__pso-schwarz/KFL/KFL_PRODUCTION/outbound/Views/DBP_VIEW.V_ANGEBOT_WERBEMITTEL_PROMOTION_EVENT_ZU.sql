CREATE OR REPLACE VIEW kfl_production_dbp_view.v_angebot_werbemittel_promotion_event_zu (mandant_id
OPTIONS(description='Mandant im DWH'), angebot_nr
OPTIONS(description='Numerische oder Alphanumerische Nummer des Angebots'), werbemittel_id
OPTIONS(description='ID des Werbemittels'), werbemittelkanal_id OPTIONS(description='ID des Werbemittelkanals'),
promotion_event_id OPTIONS(description='ID des Promotion Events.'), werbeflaechenabschnitt_name
OPTIONS(description='Name des Werbeflaechenabschnitts.'), werbemittel_bez
OPTIONS(description='Bezeichnung des Werbemittels'), werbemittelkanal_bez
OPTIONS(description='Bezeichnung des Werbemittelkanals.'), werbethema_id OPTIONS(description='ID des Werbethemas'),
werbethema_bez OPTIONS(description='Bezeichnung des Werbethemas'), werbeflaechenthema_cd
OPTIONS(description='Code des Werbeflaechenthemas'), werbeflaechenthema_bez
OPTIONS(description='Bezeichnung des Werbeflaechenthemas'), werbeposition_nr
OPTIONS(description='Nummer der Position des Angebots innerhalb des Werbeflachenabschnitts.'))
OPTIONS(DESCRIPTION = `ZUORDNUNGSTABELLE ZWISCHEN EINEM ANGEBOT, DEM WERBEMITTEL UND EVENT. BEINHALTET INFORMATIONEN WO ANGEBOTE EINES EVENTS BEWORBEN WERDEN. DIE TABELLE WIRD ZUSÄTZLICH ZUR PROMOTION EVENT TABELLE BENÖTIGT, DA ES AUCH ANGEBOTE OHNE EVENT GEBEN KANN, DIE INFORMATIONEN ZUM WERBEMITTEL, WERBETHEMA, ETC. BEINHALTEN. `)
AS SELECT mandant_id,
 angebot_nr,
 werbemittel_id,
 werbemittelkanal_id,
 promotion_event_id,
 werbeflaechenabschnitt_name,
 werbemittel_bez,
 werbemittelkanal_bez,
 werbethema_id,
 werbethema_bez,
 werbeflaechenthema_cd,
 werbeflaechenthema_bez,
 werbeposition_nr
FROM kfl_production_dbp_data.angebot_werbemittel_promotion_event_zu;