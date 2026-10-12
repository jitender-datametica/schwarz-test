CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.mv_art_kreistyp_gruppe_zu_per
-- 12.08.2021, srom0404, AP0098488, SPEC0121102 - Reichweitenliste
-- 26.08.2021, nwag2310, AP0098488, SPEC0121102 - Reichweitenliste
-- 10.11.2021, srom0404, AP0098488, SPEC0121102 - Dummy Werte fuer DE auf '' ohne BLANK
AS
SELECT
 v00.art_id
,v00.mandant_id
,COALESCE(v01.kreistyp_id,'') AS kreistyp_id
,v01.dat_von
,COALESCE(v01.kreistyp_gruppe_id,'') AS kreistyp_gruppe_id
,v01.dat_bis
FROM DBP_VIEW.v_art v00 
LEFT JOIN DBP_VIEW.v_art_kreistyp_gruppe_zu_per v01
ON v00.mandant_id = v01.mandant_id
AND v00.art_id = v01.art_id
AND v01.dat_bis = '9999-12-31'
WHERE v00.dat_bis = '9999-12-31';