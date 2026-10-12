CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTKZ_POSTEN_1
(
mandant_id
, posten_id
, spr_id
, posten_bez
, posten_kz
, posten_bez_agg
)
AS
SELECT
v01.mandant_id
,v01.posten_id
,v01.spr_id
,v01.posten_bez
,CASE
WHEN v01.mandant_id = 1
AND v01.posten_id IN ('PN', 'PF') THEN 'X'
--WHEN v01.mandant_id <> 1
--AND v01.posten_id = '1' THEN 'X'
ELSE '' END AS posten_kz
,CASE
WHEN v01.posten_bez = 'Postenartikel/Werbung - Non Food' THEN 'Postenartikel'
ELSE v01.posten_bez END AS posten_bez_agg
FROM dbp_view.v_artkz_posten_1 v01
WHERE
   mandant_id = 1
   AND spr_id = 22

UNION
SELECT
v02.mandant_id
,v02.posten_kz_sap AS posten_id
,v02.spr_id
,v02.posten_bez_sap AS posten_bez
,CASE
WHEN v02.mandant_id <> 1 AND v02.posten_kz_sap IN ('PN','SP') THEN 'X'
ELSE '' END AS posten_kz
,CASE
WHEN posten_kz = 'X' THEN 'Posten'
ELSE 'Sortimentsartikel' END AS posten_bez_agg
FROM dbp_view.v_posten_kz_sap_spr_zu_1 v02
WHERE v02.mandant_id <> 1
AND v02.spr_id = 22;