CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_FRISCHE_MANAGER_2
--AP0084960 | nwag2310 | added -1 record
AS
SELECT
 mandant_id
,ma_id AS frische_manager_id 
,MAX(ma_vorname ||  ' '  || ma_name) AS frische_manager_name
FROM DBP_VIEW.v_ma_spr_zu_2 v01
WHERE (v01.mandant_id, v01.ma_id) IN (SELECT mandant_id
                                            ,frische_manager_id 
                                      FROM DBP_MSI_V_VIEW.v_wup_denorm_2
                                      )
GROUP BY v01.mandant_id
        ,v01.ma_id

UNION

SELECT mandant_id
      ,frische_manager_id
      ,frische_manager_name
FROM (SELECT 1 AS mandant_id
            ,-1 AS frische_manager_id
            ,'Alle FM (DIF)' AS frische_manager_name
      ) t0;