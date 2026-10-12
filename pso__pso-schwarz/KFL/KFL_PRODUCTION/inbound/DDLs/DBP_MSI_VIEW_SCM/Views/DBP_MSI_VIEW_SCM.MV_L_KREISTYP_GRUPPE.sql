CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.mv_l_kreistyp_gruppe 
-- 10.11.2021, srom0404, AP0098488, SPEC0121102 - Dummy Werte für Laender, die noch nicht in l_kreistyp_gruppe sind
AS 
SELECT v01.mandant_id
      ,v01.kreistyp_gruppe_id
FROM DBP_VIEW.v_l_kreistyp_gruppe v01

UNION ALL

SELECT v02.mandant_id
      ,'' AS kreistyp_id
FROM DBP_VIEW.v_mandant v02
WHERE v02.mandant_id NOT IN (SELECT mandant_id FROM DBP_VIEW.v_l_kreistyp_gruppe WHERE kreistyp_gruppe_id = '');