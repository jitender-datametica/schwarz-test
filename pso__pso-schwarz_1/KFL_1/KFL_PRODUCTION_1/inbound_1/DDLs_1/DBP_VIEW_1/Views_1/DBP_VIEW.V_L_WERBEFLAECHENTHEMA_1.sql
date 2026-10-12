create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_L_WERBEFLAECHENTHEMA_1(
	MANDANT_ID COMMENT 'Mandant_1 im DWH.',
	WERBEMITTELKANAL_ID COMMENT 'ID des Werbemittelkanals',
	WERBEMITTEL_ID COMMENT 'ID des Werbemittels',
	WERBEFLAECHENTHEMA_CD COMMENT 'Code des Werbeflaechenthemas',
	WERBEFLAECHENTHEMA_BEZ COMMENT 'Bezeichnung des Werbeflaechenthemas',
	WERBEFLAECHENTHEMA_WFL_BEZ COMMENT 'Bezeichnung, durch die Warenfluss-Nutzer (WFL) gesetzt wird. Dieses Feld dient dazu, dass der Nutzer eine_1 Bezeichnung für bestimmt Werbefläche Themen definieren kann, welche im Frontend angezeigt wird. ',
	WERBEFLAECHENTHEMA_AVQ_PRIO_NR COMMENT 'Priorisierungs-ID zur Gruppierung und Reihenfolge der Werbeflächenthemen bei der Berechnung der Abverkaufsquote (AVQ). Werbeflächenthemen mit der gleichen ID werden zusammengefasst.'
) as 
    SELECT 
        mandant_id,
        werbemittelkanal_id,
        werbemittel_id,
        werbeflaechenthema_cd,
        werbeflaechenthema_bez,
        werbeflaechenthema_wfl_bez,
        werbeflaechenthema_avq_prio_nr

FROM DBP_DATA.L_WERBEFLAECHENTHEMA_1 ;
