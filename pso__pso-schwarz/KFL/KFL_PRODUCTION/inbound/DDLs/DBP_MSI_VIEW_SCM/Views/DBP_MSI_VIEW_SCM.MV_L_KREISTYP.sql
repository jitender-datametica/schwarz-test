CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.mv_l_kreistyp
-- 12.08.2021, srom0404, AP0098488, SPEC0121102 - Reichweitenliste
-- 10.11.2021, srom0404, AP0098488, SPEC0121102 - Dummy Werte fuer DE
AS
SELECT
 v01.mandant_id
,v01.kreistyp_id
,v01.vz_prio_id
FROM DBP_VIEW.v_l_kreistyp v01

UNION ALL

SELECT 
 v02.mandant_id
,v02.kreistyp_id
,v02.vz_prio_id
FROM (SELECT 1 AS mandant_id
            ,'' AS kreistyp_id
            ,0 AS vz_prio_id
     ) v02;