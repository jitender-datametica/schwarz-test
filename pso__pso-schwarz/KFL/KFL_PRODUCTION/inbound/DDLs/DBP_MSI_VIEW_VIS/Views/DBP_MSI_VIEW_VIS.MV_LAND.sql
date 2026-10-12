CREATE OR REPLACE VIEW dbp_msi_view_vis.mv_land
AS
-- LOOKUP/SPRACHE Laender
-- Mandant + Laendergruppen
-- 2010KW17 Review
-- 2011KW37 Review
-- 2013KW28 Where-Bedingung (mandant_id <> 4) entfernt
-- 20160929 ssch0611 : KMO >> Ausland
-- 2019.0520 ssch0611 : added Moldau (+ automatic sort)
-- 2020-09-25 ssch0611 : synchronized bez with mandant
SELECT
CASE mandant_id
WHEN 1 THEN mandant_sort_id + 1
ELSE mandant_sort_id + 2 END::BYTEINT AS land_sort_id,
mandant_id::BYTEINT AS land_id,
mandant_bez::VARCHAR(40)  AS land_bez,
CASE mandant_id WHEN 2 THEN 'Tschechien'
 WHEN 7 THEN 'Rumänien'
 ELSE mandant_bez END::VARCHAR(40)  AS land_neu_bez
FROM dbp_view.v_mandant

UNION ALL
SELECT
mandant_id::BYTEINT,
-1::BYTEINT,
'INT'::VARCHAR(40),
'INT'::VARCHAR(40)
FROM dbp_view.v_mandant
WHERE mandant_id = 1

UNION ALL
SELECT
mandant_id::BYTEINT,
-2::BYTEINT,
'Ausland'::VARCHAR(40),
'Ausland'::VARCHAR(40)
FROM dbp_view.v_mandant
WHERE mandant_id = 3;