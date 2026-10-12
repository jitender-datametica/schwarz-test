CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_FREIGABE
    -- 31.08.2018 twie: SPEC0042079 Lookuptabelle für Selektion im RFI Transaction Service Bericht

    (
    freigabe
    ,freigabe_bez
    )
    AS

       SELECT t.*
       FROM (SELECT * FROM (SELECT 'update' AS freigabe,
       'Ändern ' AS freigabe_bez) x
UNION ALL
SELECT * FROM  (SELECT 'delete' AS freigabe,
       'Löschen' AS freigabe_bez) x
) t
 ;