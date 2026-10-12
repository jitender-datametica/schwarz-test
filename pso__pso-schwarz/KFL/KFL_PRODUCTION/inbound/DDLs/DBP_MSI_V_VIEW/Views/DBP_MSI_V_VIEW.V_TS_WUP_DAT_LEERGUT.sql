CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_WUP_DAT_LEERGUT (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,wup_id                                   COMMENT 'Marktnummer'
  ,nb_id                                    COMMENT 'Nebenbetriebs ID, bei Märkten immer = 0'
  ,dat                                      COMMENT 'Datum der Zählung des Leerguts.'
  ,wrg_id                                   COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'
  ,betrag_leergut_zaehlung                  COMMENT 'Hausleiter zählt regelmäßig das Leergut und trägt dann den Wert in Landeswährung ein. Wird von Frontend (Transaction) per update/insert gepflegt.'
  ,betrag_leergut_inventur                  COMMENT 'Inventurwert von Leergut. Wird DWH intern aus Inventuren befüllt.'
)
COMMENT = 'Der Betrag des Leerguts in einer Filiale. Diese Information wird entweder durch eine jährliche Inventur oder eine monatliche Zählung,die vom Hausleiter durchgeführt wird,bekannt. Wird per Transaction und per AbInitio befüllt.'
 AS 
    SELECT 
        mandant_id,
        wup_id,
        nb_id,
        dat,
        wrg_id,
        betrag_leergut_zaehlung,
        betrag_leergut_inventur

FROM DBP_MSI_DATA.TS_WUP_DAT_LEERGUT ;