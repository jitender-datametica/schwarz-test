CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.mv_l_kreistyp_gruppe_2 
-- 10.11.2021, srom0404, AP0098488, SPEC0121102 - Dummy_2 Werte für Laender, die noch nicht in l_kreistyp_gruppe_2 sind
AS 
SELECT v01.mandant_id
      ,v01.kreistyp_gruppe_id
FROM DBP_VIEW.v_l_kreistyp_gruppe_2 v01

UNION ALL

SELECT v02.mandant_id
      ,'' AS kreistyp_id
FROM DBP_VIEW.v_mandant_2 v02
WHERE v02.mandant_id NOT IN (SELECT mandant_id FROM DBP_VIEW.v_l_kreistyp_gruppe_2 WHERE kreistyp_gruppe_id = '');