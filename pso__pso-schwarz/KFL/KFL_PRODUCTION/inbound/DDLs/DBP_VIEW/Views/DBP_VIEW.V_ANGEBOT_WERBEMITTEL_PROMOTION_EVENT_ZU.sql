create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_ANGEBOT_WERBEMITTEL_PROMOTION_EVENT_ZU(
	MANDANT_ID COMMENT 'Mandant im DWH',
	ANGEBOT_NR COMMENT 'Numerische oder Alphanumerische Nummer des Angebots',
	WERBEMITTEL_ID COMMENT 'ID des Werbemittels',
	WERBEMITTELKANAL_ID COMMENT 'ID des Werbemittelkanals',
	PROMOTION_EVENT_ID COMMENT 'ID des Promotion Events.',
	WERBEFLAECHENABSCHNITT_NAME COMMENT 'Name des Werbeflaechenabschnitts.',
	WERBEMITTEL_BEZ COMMENT 'Bezeichnung des Werbemittels',
	WERBEMITTELKANAL_BEZ COMMENT 'Bezeichnung des Werbemittelkanals.',
	WERBETHEMA_ID COMMENT 'ID des Werbethemas',
	WERBETHEMA_BEZ COMMENT 'Bezeichnung des Werbethemas',
	WERBEFLAECHENTHEMA_CD COMMENT 'Code des Werbeflaechenthemas',
	WERBEFLAECHENTHEMA_BEZ COMMENT 'Bezeichnung des Werbeflaechenthemas',
	WERBEPOSITION_NR COMMENT 'Nummer der Position des Angebots innerhalb des Werbeflachenabschnitts.'
) COMMENT='Zuordnungstabelle zwischen einem Angebot, dem Werbemittel und Event. Beinhaltet Informationen wo Angebote eines Events beworben werden. Die Tabelle wird zusätzlich zur promotion event Tabelle benötigt, da es auch Angebote ohne Event geben kann, die Informationen zum Werbemittel, Werbethema, etc. beinhalten. '
 as 
    SELECT 
        mandant_id,
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

FROM DBP_DATA.ANGEBOT_WERBEMITTEL_PROMOTION_EVENT_ZU ;
