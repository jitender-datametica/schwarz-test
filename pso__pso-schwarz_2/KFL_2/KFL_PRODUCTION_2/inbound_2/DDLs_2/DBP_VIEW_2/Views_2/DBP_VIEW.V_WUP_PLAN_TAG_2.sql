CREATE OR REPLACE VIEW DBP_VIEW.V_WUP_PLAN_TAG_2 (
   wup_id                                   COMMENT 'Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'
  ,nb_id                                    COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'
  ,mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,dat                                      COMMENT 'Datum'
  ,plan_tag_fg                              COMMENT 'Wenn die Daten bereits in der SST auf der Ebene wup_2 und Tag_2 geliefert wurden: 1, sonst  0'
  ,umsatz_netto_plan                        COMMENT 'geplanter Nettoumsatz'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'
  ,umsatz_netto_plan_extern                 COMMENT 'umsatz_netto_plan_extern. Upload aus Excel'
  ,menge_absatz_ohne_pfand_plan             COMMENT 'Geplante Anzahl der zu verkaufenden Artikel_2 (ohne Pfand-Artikel_2) auf  Ebene Filiale/Tag.'
)
COMMENT = 'VIS - Planwerte pro Markt und Tag_2'
 AS 
    SELECT 
        wup_id,
        nb_id,
        mandant_id,
        dat,
        plan_tag_fg,
        umsatz_netto_plan,
        wrg_id,
        umsatz_netto_plan_extern,
        menge_absatz_ohne_pfand_plan

FROM DBP_DATA.WUP_PLAN_TAG_2 ;