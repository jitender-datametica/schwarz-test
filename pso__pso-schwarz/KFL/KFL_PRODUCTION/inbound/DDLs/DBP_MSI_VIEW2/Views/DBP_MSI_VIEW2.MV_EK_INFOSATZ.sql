CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_EK_INFOSATZ
(
mandant_id
, ek_infosatz_id
, art_id
, gp_id
, crossdocking_id
, einkaufsorganisation_id
, dat_erstellung
, gp_art_id
, dat_von
, dat_bis
, lieferbar_fg
, regel_gp_fg
, loesch_fg
, max_ek_infosatz_fg
, gp_teilsortiment_id
, konditionsgruppe_id
, apollo_ian
)
AS
SELECT
v01.mandant_id,
v01.ek_infosatz_id,
v01.art_id,
v01.gp_id,
v01.crossdocking_id,
v01.einkaufsorganisation_id,
v01.dat_erstellung,
v01.gp_art_id,
v01.dat_von,
v01.dat_bis,
CASE
WHEN (CURRENT_DATE - 1 BETWEEN v01.dat_von AND v01.dat_bis) THEN 'X'
ELSE ' ' END lieferbar_fg,
CASE
WHEN (v01.regel_gp_fg = 1) THEN 'X'
ELSE ' ' END regel_gp_fg,
CASE
WHEN (v01.loesch_fg = 1) THEN 'X'
ELSE ' ' END loesch_fg,
CASE
WHEN (v02.max_ek_infosatz_id IS NOT NULL) THEN 'X'
ELSE ' ' END max_ek_infosatz_fg,
COALESCE(gp_teilsortiment_id, '999999') gp_teilsortiment_id,
v01.konditionsgruppe_id,
v01.apollo_ian
FROM dbp_view.v_ek_infosatz v01
LEFT JOIN

(SELECT
mandant_id,
art_id,
MAX(ek_infosatz_id) AS max_ek_infosatz_id
FROM dbp_view.v_ek_infosatz

WHERE mandant_id = 1

GROUP BY 1,2) v02

ON v01.mandant_id = v02.mandant_id
AND v01.art_id = v02.art_id
AND v01.ek_infosatz_id = v02.max_ek_infosatz_id

WHERE v01.mandant_id = 1
QUALIFY RANK() OVER(PARTITION BY v01.mandant_id, v01.art_id, v01.gp_id ORDER BY v01.ek_infosatz_id DESC NULLS LAST) = 1;


