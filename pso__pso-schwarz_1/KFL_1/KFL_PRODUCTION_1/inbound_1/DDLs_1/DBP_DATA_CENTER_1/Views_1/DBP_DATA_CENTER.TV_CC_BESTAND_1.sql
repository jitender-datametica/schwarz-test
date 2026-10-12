CREATE OR REPLACE VIEW DBP_DATA_CENTER.tv_cc_bestand_1
AS
SELECT
grundmenge.country_1,
grundmenge.storeId,
Right('00000000' || Trim(Cast(grundmenge.kl_art_id AS CHAR(7))), 8) AS klNr,
Coalesce(bestand.menge_lgbest_erp_frei_bme,0)+Coalesce(we.we_heute,0)-Coalesce(bon.menge_bon,0) AS stock
FROM
(SELECT
l.mandant_id,
l.wup_id,
l.art_id,
a.kl_art_id,
/*2020-12-17 nwag2310: performance-optimization, moved country_1+storeId creation here*/
CASE
WHEN mandant_kbez='D' THEN 'DE'
ELSE mandant_kbez END AS country_1,
country_1 || Cast(wup_id AS CHAR(4))  AS storeId
FROM dbp_view.v_art_list_wup_zu_per_1 l
JOIN dbp_view.v_art_1 a ON a.mandant_id=l.mandant_id AND a.art_id=l.art_id
JOIN dbp_data_center.cc_artikel_1 gm   ON a.mandant_id=gm.mandant_id AND a.kl_art_id=gm.kl_art_id
JOIN dbp_view.v_mandant_1 m     ON gm.mandant_id=m.mandant_id   --Laenderbezeichnung
WHERE l.dat_bis= to_date('9999-12-31', 'YYYY-MM_1-DD')
GROUP BY 1,2,3,4,5,6) grundmenge        --Artikelliste vom Fachbereich + WKL1 Listung

JOIN dbp_view.v_marktbestand_erp_delta_1 bestand  --Letzter Marktbestand eoB.
ON grundmenge.mandant_id=bestand.mandant_id
AND grundmenge.wup_id=bestand.wup_id
AND grundmenge.art_id=bestand.art_id

LEFT JOIN  (    --2020-11-16 nwag2310: performance-optimization
SELECT
vk.mandant_id,
vk.wup_id,
vk.kl_art_id,
vk.bon_dat,
Sum(vk.menge) AS menge_bon   --Nicht-Stornierte Verkaufsbons vom auf den eoB-Bestand folgenden Tag_1

FROM dbp_v_ods.v_ods_bon_verkauf_1  vk_1
JOIN dbp_data_center.cc_artikel_1 gm   ON vk.mandant_id=gm.mandant_id AND vk.kl_art_id=gm.kl_art_id
 --2020-12-17 nwag2310: performance-optimization
JOIN
dbp_view.v_art_1 a ON a.mandant_id=gm.mandant_id AND a.kl_art_id=gm.kl_art_id
JOIN dbp_view.v_marktbestand_erp_delta_1 mb ON  vk.mandant_id=mb.mandant_id AND a.art_id=mb.art_id AND vk.wup_id=mb.wup_id AND vk.bon_dat = mb.dat +1
WHERE (vk.mandant_id, vk.wup_id, vk.bon_id, vk.bon_dat) NOT IN (SELECT
mandant_id,
wup_id,
bon_id,
bon_dat
FROM dbp_v_ods.v_ods_bon_storno_1)
                   AND  vk.bon_dat BETWEEN CURRENT_DATE -2 AND CURRENT_DATE
GROUP BY 1,2,3,4) bon
ON grundmenge.mandant_id=bon.mandant_id
AND grundmenge.wup_id=bon.wup_id
AND grundmenge.kl_art_id=bon.kl_art_id

LEFT JOIN (     --2020-11-16 nwag2310: performance-optimization
SELECT
bl.mandant_id,
Cast(TRUNC(kunde_id) AS INT) /*** MSC-ERROR - MSCEWI2041 - TRUNC FUNCTION WAS ADDED TO ENSURE INTEGER. MAY NEED CHANGES IF NOT NUMERIC OR STRING. ***/ AS wup_id,
bld.art_id,
bld.dat_lief_soll,
Sum(menge_lief_ist_bme) AS we_heute  --Marktlieferungen vom auf den eoB-Bestand folgenden Tag_1

FROM dbp_view.v_besch_lief_det_1 bld
     --2021-03-03 nwag2310: performance-optimization (dat_lief_soll in joinkey)
JOIN
dbp_view.v_besch_lief_1 bl ON bld.mandant_id=bl.mandant_id AND bl.lief_beleg_id=bld.lief_beleg_id AND bl.dat_lief_soll = bld.dat_lief_soll
 --2020-12-17 nwag2310: performance-optimization
JOIN
dbp_view.v_art_1 a ON a.mandant_id=bld.mandant_id AND a.art_id=bld.art_id
JOIN dbp_data_center.cc_artikel_1 gm   ON bld.mandant_id=gm.mandant_id AND gm.kl_art_id=a.kl_art_id
JOIN dbp_view.v_marktbestand_erp_delta_1 mb ON  bld.mandant_id=mb.mandant_id AND bld.art_id=mb.art_id AND TRY_CAST(kunde_id AS INT) =mb.wup_id AND bld.dat_lief_soll = mb.dat +1
WHERE bld.dat_lief_soll BETWEEN CURRENT_DATE -2 AND CURRENT_DATE
GROUP BY 1,2,3,4) we
ON grundmenge.mandant_id=we.mandant_id
AND grundmenge.wup_id=we.wup_id
AND grundmenge.art_id=we.art_id;
