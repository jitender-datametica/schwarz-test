CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_BEURTEILUNG_AUSPR_SPR_ZU as
    -- SPRACHE Bezeichnungen für frueh_fg
    -- MR 25.01.2012 Gibt Frueh, Spaet als Ausprägung zurück
    -- 2014.04.10 : Anpassung; neuer Default-Wert + neue Auspraegung Storecheck
    -- TEMP Zwischen-Loesung bis 2014KW20
    -- 2014KW20 : Zwischenloesung bis KW30; temp. Anpassung KZ/FG/BEZ

   SELECT
     CASE
       WHEN akt_tag = 1 THEN 'Storecheck'
       WHEN akt_tag = 2 THEN 'Früh'
       WHEN akt_tag = 3 THEN 'Spät'
       ELSE ''
     END AS frueh_fg, CASE
   WHEN akt_tag = 1 THEN 'Storecheck'
   WHEN akt_tag = 2 THEN 'Früh'
   WHEN akt_tag = 3 THEN 'Spät'
   ELSE ''
 END AS frueh_bez
FROM dbp_view.v_tag

WHERE akt_tag BETWEEN 0 AND 3
;