CREATE OR REPLACE VIEW DBP_VIEW.V_L_TRANSFER_STATUS (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,transfer_status_id                       COMMENT 'ID des Transferstatus. Der Transferstatus gibt den aktuellen Stand der Übertragung an SAP Retail an, bspw. "empfohlen", "genehmigt", "storniert", etc.'
)
COMMENT = 'Lookuptabelle der möglichen Status des Transfers. Der Transferstatus gibt den Aktuellen Stand der Übertragung an SAP Retail an.'
 AS 
    SELECT 
        mandant_id,
        transfer_status_id
FROM DBP_DATA.L_TRANSFER_STATUS ;