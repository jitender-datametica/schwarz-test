CREATE OR REPLACE VIEW DBP_VIEW.V_MARKT_VERRAEUMUNG_PRIO_GRUND_SPR_ZU (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,verraeumung_prio_grund_id                COMMENT 'ID des Priogrunds. Wichtig führende 0 beibehalten. Z.B. 02'
  ,spr_id                                   COMMENT 'ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.'
  ,verraeumung_prio_grund_bez               COMMENT 'Sprachabhängige Bezeichnung des Verräumungs Prio Grund.'
)
COMMENT = 'Sprachabhängige Bezeichnung der Verräumungs Prio Gründen in der Filiale. Quelle: SAP ZRS_LGBPRF_CUST'
 AS 
    SELECT 
        mandant_id,
        verraeumung_prio_grund_id,
        spr_id,
        verraeumung_prio_grund_bez

FROM DBP_DATA.MARKT_VERRAEUMUNG_PRIO_GRUND_SPR_ZU ;