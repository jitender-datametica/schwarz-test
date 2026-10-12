CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ART_WUP_DISPO_TAG_2
AS
/*
* Name = für den Fall dass noch andere Kennzahlen oder Attribute aus den Dispo 2020-Tabellen auf Ebene 
* Verteilzentrum/Artikel_2/Tag_2 [=PK] dazukommen sollten)
*/
--2022-08-03, AP0125093, SPEC0164838, dknop, max for ANZ_WUP_DIS, ANZ_WUP_KDIS
SELECT 
v1.MANDANT_ID
,v1.ART_ID
,v2.WUP_ID
,v2.NB_ID
,v1.DAT_PLAN AS dat
,MAX(v1.ANZ_WUP_DIS) AS ANZ_WUP_DIS
,MAX(v1.ANZ_WUP_KDIS) AS ANZ_WUP_KDIS
FROM DBP_VIEW.V_ART_GP_DISPO_TAG_2 v1
JOIN DBP_VIEW.V_GP_DISPO_VZ_TAG_2 v2
ON v1.mandant_id=v2.mandant_id
AND v1.gp_dispo_id=v2.gp_dispo_id
AND v1.dat_plan=v2.dat_plan
GROUP BY
v1.MANDANT_ID
,v1.ART_ID
,v2.WUP_ID
,v2.NB_ID
,v1.DAT_PLAN;