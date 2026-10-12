CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_L_ABSCHRIFTENART_GRP_1

-- Awol 13.03.13: Where Bedingung von "v01.abschriftart_id BETWEEN 933 AND 994" auf "v01.abschriftart_id BETWEEN 905 AND 994" geändert. S. Mail Frau Winter 11.03.13
-- AP0034888, SPEC0119166 Lagerbewegungen added

(
mandant_id
,abschriftart_id
,abschriftart_gruppe_id
)
AS
   SELECT
   mandant_id,
   abschriftart_id,
   CASE WHEN MOD( abschriftart_id, 2) =0 THEN abschriftart_id -1
   ELSE abschriftart_id
   END abschriftart_gruppe_id
   FROM dbp_view.v_l_abschriftart_1 v01

   WHERE
   v01.abschriftart_id BETWEEN 905 AND 994
   AND v01.mandant_id <> 1
   AND
   NOT (v01.abschriftart_id = 955
   AND v01.mandant_id = 2)
   
   UNION ALL
   
   SELECT DISTINCT
   mandant_id
   ,CASE 
   WHEN lager_bewart_id IN ('Y01','Y02') THEN 210
   WHEN lager_bewart_id IN ('Y07','Y08') THEN 211
   WHEN lager_bewart_id IN ('Y11','Y12') THEN 240
   WHEN lager_bewart_id IN ('Y05','Y06') THEN 241
   WHEN lager_bewart_id IN ('Y35','Y36') THEN 242
   END
   ,CASE 
   WHEN lager_bewart_id IN ('Y01','Y02') THEN 210
   WHEN lager_bewart_id IN ('Y07','Y08') THEN 211
   WHEN lager_bewart_id IN ('Y11','Y12') THEN 240
   WHEN lager_bewart_id IN ('Y05','Y06') THEN 241
   WHEN lager_bewart_id IN ('Y35','Y36') THEN 242
   END
   FROM dbp_view.v_l_lager_bewart_1
   WHERE lager_bewart_id IN ('Y01','Y02','Y07','Y08','Y11','Y12','Y05','Y06','Y35','Y36')
   AND mandant_id <> 1;