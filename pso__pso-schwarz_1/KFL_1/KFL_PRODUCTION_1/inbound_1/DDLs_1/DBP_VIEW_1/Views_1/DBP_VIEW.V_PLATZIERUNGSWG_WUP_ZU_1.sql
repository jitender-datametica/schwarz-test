CREATE OR REPLACE VIEW DBP_VIEW.V_PLATZIERUNGSWG_WUP_ZU_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH.'
  ,platzierungswg_id                        COMMENT 'Platzierungswarengruppe - im DWH generierter numerischer Schlüssel.'
  ,wup_id                                   COMMENT 'ID Warenumschlagsplatz, ID der Filiale.'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,sm_id                                    COMMENT 'Sortimentsmodul ID. Gibt die Sortimentsgröße der Platzierungswarengruppe in der Filiale an.'
  ,anz_artikel                              COMMENT 'Gibt die Anzahl der Artikel_1 in der Filiale für die Platzierungswarengruppe an.'
  ,menge_soll_flaeche_regio                 COMMENT 'Gibt die SOLL-Größe der Verkaufsflächen rein regionaler Sortimente an.'
)
COMMENT = 'Zuordnungen der Platzierungswarengruppe zur Filiale.'
 AS 
    SELECT 
        mandant_id,
        platzierungswg_id,
        wup_id,
        nb_id,
        sm_id,
        anz_artikel,
        menge_soll_flaeche_regio

FROM DBP_DATA.PLATZIERUNGSWG_WUP_ZU_1 ;