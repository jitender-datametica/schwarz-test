CREATE OR REPLACE VIEW dbp_msi_view_log.mv_auftraggeber_2 -- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 auftraggeber_id
,mandant_id
,nb_id
,auftraggeber_bez
,vs_id
,wup_typ_id
,vkl_id
,dat_bis
,breitengrad
,laengengrad
)
AS
SELECT
Cast(v01.wup_id AS VARCHAR(10)) AS auftraggeber_id,
v01.mandant_id,
v01.nb_id,
CASE
WHEN v01.nb_id = -1 THEN '---'
ELSE v01.wup_standort END AS auftraggeber_bez,
v01.vs_id,
v01.wup_typ_id,
v01.vkl_id,
v01.dat_bis,
v01.breitengrad,
v01.laengengrad
FROM dbp_view.v_wup_2 v01
WHERE (v01.nb_id IN (0, 99, 2, -111) AND v01.wup_id > 0)
   OR (v01.nb_id = -1 AND v01.wup_id = 0)

UNION ALL
SELECT
Cast(REPLACE(v02.kunde_nr,'0000', '000') AS VARCHAR(10)) AS auftraggeber_id,
v02.mandant_id,
0 AS nb_id,
v02.kunde_name AS auftraggeber_bez,
0 AS vs_id,
0 AS wup_typ_id,
-1 AS vkl_id,
SNOWCONVERT.PUBLIC.INT_TO_DATE_UDF(80991231) AS dat_bis,
NULL AS breitengrad,
NULL AS laengengrad
FROM dbp_view.v_in_kunde_2 v02
WHERE v02.mandant_id = 1
  AND (SUBSTR(v02.kunde_nr, 1, 5) = '97000' OR SUBSTR( v02.kunde_nr, 1, 5) = '94000');
