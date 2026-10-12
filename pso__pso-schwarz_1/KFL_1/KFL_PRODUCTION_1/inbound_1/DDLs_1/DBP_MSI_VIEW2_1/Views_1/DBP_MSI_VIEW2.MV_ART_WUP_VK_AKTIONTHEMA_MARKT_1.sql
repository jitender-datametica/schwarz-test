CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ART_WUP_VK_AKTIONTHEMA_MARKT_1
(
 mandant_id
,aktion_id
,wup_id
,nb_id
,art_id
,vk_brutto
)
AS

SELECT
 v01.mandant_id
,v02.aktion_id
,v01.wup_id
,v01.nb_id
,v01.art_id
,v01.vk_brutto
FROM  dbp_data.art_wup_vk_per_1 v01
JOIN DBP_MSI_VIEW2.MV_AKTIONTHEMA_MARKT_1 v02
ON v01.mandant_id = v02.mandant_id
AND v01.art_id = v02.art_id
AND v01.wup_id = v02.wup_id
WHERE v02.dat_von BETWEEN v01.dat_von AND v01.dat_bis
AND v01.nb_id = 0;
