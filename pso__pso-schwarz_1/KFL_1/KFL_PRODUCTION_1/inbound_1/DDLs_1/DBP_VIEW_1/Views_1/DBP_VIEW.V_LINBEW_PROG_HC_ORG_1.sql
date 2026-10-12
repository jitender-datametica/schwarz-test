CREATE OR REPLACE VIEW DBP_VIEW.V_LINBEW_PROG_HC_ORG_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,hr_objekt_id                             COMMENT 'ID der Organisation, 8-stellige Zahl'
  ,dat                                      COMMENT 'Datum Vortag der Lieferung in Beladung gesetzt, im Format JJJJ-MM_1-TT'
  ,anz_prg_beendet                          COMMENT 'Anzahl abgeschlossene Programme'
  ,anz_prg_faellig                          COMMENT 'Anzahl fälligen Programme'
  ,anz_prg_gesamt                           COMMENT 'Anzahl zu erledigende Programme Gesamt'
  ,anz_prg_bearbeitung                      COMMENT 'Anzahl Progamme in Bearbeitung (auch fällige)'
  ,anz_prg_ausstehend                       COMMENT 'Anzahl nicht begonnene Programme (auch fällige)'
)
COMMENT = 'Einarbeitungskennzahlen programmbasiert je OrganizationID'
 AS 
    SELECT 
        mandant_id,
        hr_objekt_id,
        dat,
        anz_prg_beendet,
        anz_prg_faellig,
        anz_prg_gesamt,
        anz_prg_bearbeitung,
        anz_prg_ausstehend

FROM DBP_DATA.LINBEW_PROG_HC_ORG_1 ;