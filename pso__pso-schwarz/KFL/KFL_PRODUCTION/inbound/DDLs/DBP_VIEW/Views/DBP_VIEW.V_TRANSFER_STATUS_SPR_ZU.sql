CREATE OR REPLACE VIEW DBP_VIEW.V_TRANSFER_STATUS_SPR_ZU (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,transfer_status_id                       COMMENT 'ID des Transferstatus. Der Transferstatus gibt den aktuellen Stand der Übertragung an SAP Retail an, bspw. "empfohlen", "genehmigt", "storniert", etc.'
  ,transfer_status_bez                      COMMENT 'Sprachabhängige Bezeichnung des Transferstatus'
)
COMMENT = 'Tabelle für sprachabhängige Bezeichnungen des Transferstatus.'
 AS 
    SELECT 
        mandant_id,
        spr_id,
        transfer_status_id,
        transfer_status_bez
FROM DBP_DATA.TRANSFER_STATUS_SPR_ZU ;