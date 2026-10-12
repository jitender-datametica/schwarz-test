--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.art_bewertungskreis_tag_1
(
mandant_id
, bewertungskreis_id
, art_id
, dat_gld
, preis_steuer_kz
, wrg_id
, gld
, standard_preis
, menge_bestand_bme
, wert_bestand
, vk_wert
, zeit_extrakt
)
SELECT
abt.mandant_id
, abt.bewertungskreis_id
, abt.art_id
, t.dat
, abt.preis_steuer_kz
, abt.wrg_id
, abt.gld
, abt.standard_preis
, abt.menge_bestand_bme
, abt.wert_bestand
, abt.vk_wert
, abt.zeit_extrakt
FROM DBP_DATA.art_bewertungskreis_tag_1 abt_1
CROSS JOIN
DBP_DATA.tag_1 t
WHERE (abt.mandant_id, abt.bewertungskreis_id, abt.art_id, abt.dat_gld) IN
(
SELECT mandant_id
, bewertungskreis_id
, art_id
,MAX(dat_gld)
FROM DBP_DATA.art_bewertungskreis_tag_1
WHERE mandant_id = 1
GROUP BY 1,2,3
)
AND t.dat BETWEEN abt.dat_gld + 1 AND CURRENT_DATE - 1
AND (abt.mandant_id, abt.bewertungskreis_id, abt.art_id, t.dat) NOT IN
(SELECT mandant_id
, bewertungskreis_id
, art_id
, dat_gld
FROM DBP_DATA.art_bewertungskreis_tag_1
WHERE mandant_id = 1
)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
;

