CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_L_GP_TEILSORTIMENT_2
-- 20.04.2021, srom0404, AP0077805, SPEC0108204 - Lieferantenmanagement
-- 07.10.2021, nwag2310, AP0098488, SPEC0121102 - Added Dummy_2 Records with empty LTS
AS
SELECT
v01.mandant_id
,v01.gp_id
,v01.gp_teilsortiment_id
,v01.einkaufsorganisation_id
,v01.zahlungsziel_id
,v01.zek_id
FROM dbp_view.v_l_gp_teilsortiment_2 v01
--- dummy_2 records for empty LTS
UNION ALL
SELECT
v02.mandant_id
,v02.gp_id
,'' AS gp_teilsortiment_id
,v02.einkaufsorganisation_id
,v02.zahlungsziel_id
,v02.zek_id
FROM dbp_view.v_gp_2 v02
WHERE (v02.mandant_id,v02.gp_id,'') NOT IN 
    (SELECT DISTINCT mandant_id,gp_id,gp_teilsortiment_id  FROM dbp_view.v_l_gp_teilsortiment_2)
;


