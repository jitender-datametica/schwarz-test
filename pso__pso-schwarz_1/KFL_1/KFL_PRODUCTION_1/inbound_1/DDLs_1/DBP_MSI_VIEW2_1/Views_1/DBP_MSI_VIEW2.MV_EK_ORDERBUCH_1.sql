CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_EK_ORDERBUCH_1


(
  art_id
, mandant_id
, wup_id
, nb_id
, gp_id
, orderbuch_gueltig
)
AS

-- gültige Orderbucheinträge
SELECT DISTINCT
v01.art_id,
v01.mandant_id,
v01.wup_id,
v01.nb_id,
v01.gp_id,
--, 'X' AS orderbuch_gueltig
'gültiger Orderbucheintrag' AS orderbuch_gueltig
FROM dbp_view.v_ek_orderbuch_1 v01
WHERE v01.mandant_id = 1
AND (v01.gesperrt_fg = 0 AND CURRENT_DATE-1 BETWEEN v01.dat_von AND v01.dat_bis)

UNION ALL

-- ungültige Orderbucheinträge
SELECT DISTINCT
v02.art_id,
v02.mandant_id,
v02.wup_id,
v02.nb_id,
v02.gp_id,
--,'' AS orderbuch_gueltig
'ungültiger Orderbucheintrag' AS orderbuch_gueltig
FROM dbp_view.v_ek_orderbuch_1 v02
WHERE v02.mandant_id = 1
AND (art_id, mandant_id, wup_id, nb_id, gp_id) NOT IN
(SELECT DISTINCT
art_id,
mandant_id,
wup_id,
nb_id,
gp_id
FROM dbp_view.v_ek_orderbuch_1
WHERE mandant_id = 1
AND (gesperrt_fg = 0 AND CURRENT_DATE-1 BETWEEN dat_von AND dat_bis)
);


