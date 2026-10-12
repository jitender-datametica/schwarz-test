CREATE OR REPLACE VIEW DBP_VIEW.V_L_MARKT_VERRAEUMUNG_PRIO_GRUND_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,verraeumung_prio_grund_id                COMMENT 'ID des Priogrunds. Wichtig führende 0 beibehalten. Z.B. 02'
)
COMMENT = 'Lookup-Tabelle für die Verräumungs-Prioritätsgründe in der Filiale. Diese Tabelle listet die verschiedenen Gründe auf, die einen Artikel_2 im Lager als "kritisch" für die Verräumung auf die Verkaufsfläche einstufen.
z.B. das Erreichen eines Nullbestands im Regal. Quelle: ZRS_LGBPRF_CUST (SAP)'
 AS 
    SELECT 
        mandant_id,
        verraeumung_prio_grund_id

FROM DBP_DATA.L_MARKT_VERRAEUMUNG_PRIO_GRUND_2 ;