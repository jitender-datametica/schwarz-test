create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_WERBEFLAECHENABSCHNITT_SPR_ZU_2(
	WERBEFLAECHENABSCHNITT_ID COMMENT 'ID des Werbeflächenabschnitts',
	SPR_ID COMMENT 'ID der Sprache',
	WERBEFLAECHENABSCHNITT_NAME COMMENT 'Bezeichnung des Werbeflächenabschnitts',
	WERBEFLAECHENABSCHNITT_WFL_BEZ COMMENT 'Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine_2 Bezeichnung für bestimmt Werbeflächenabschnitt definieren kann, welche im Frontend angezeigt wird.'
) as 
    SELECT 
        werbeflaechenabschnitt_id,
        spr_id,
        werbeflaechenabschnitt_name,
        werbeflaechenabschnitt_wfl_bez

FROM DBP_DATA.WERBEFLAECHENABSCHNITT_SPR_ZU_2 ;
