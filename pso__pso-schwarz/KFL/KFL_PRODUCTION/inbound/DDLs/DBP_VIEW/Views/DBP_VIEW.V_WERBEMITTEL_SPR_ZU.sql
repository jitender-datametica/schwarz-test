create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_WERBEMITTEL_SPR_ZU(
	WERBEMITTELKANAL_ID COMMENT 'Werbemittel Art ID - medium through which the advertisement is shown (paper, digital)',
	WERBEMITTEL_ID COMMENT 'Werbemittel - on what item the advertisement is shown (for example leaflet, magazine for Paper Medium, pop-up banner for digital)',
	SPR_ID COMMENT 'Sprachschlüssel',
	WERBEMITTEL_BEZ COMMENT 'Werbemittelbezeichnung',
	WERBEMITTEL_WFL_BEZ COMMENT 'Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine Bezeichnung für bestimmt Werbefläche Themen definieren kann, welche im Frontend angezeigt wird.'
) as 
    SELECT 
        werbemittelkanal_id,
        werbemittel_id,
        spr_id,
        werbemittel_bez,
        werbemittel_wfl_bez

FROM DBP_DATA.WERBEMITTEL_SPR_ZU ;
