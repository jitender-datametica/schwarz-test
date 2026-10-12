CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lagerbew_det AS
-- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
-- 11.10.2021, AP0103346, SPEC0124027, dknop, left join to dbp_msi.akt_msi_user_ek_anzeige_zu, COALESCE (v04.ek_anzeige_fg,0), correction to case statement with kunde_id
-- 18.10.2021, dknop, formatting adjustments
-- 26.20.2021, dknop, column name update (erf_menge_einh_id)
-- 26.10.2021, dknop, expand condition for lager_bewart_id, was lager_bewart_id IN ('301', '311', '601', '641', '647')
-- 27.10.2021, dknop, Anpassung Moldau BEWART 643/644 based on LIS
-- 16.12.2021, dknop, expand condition for lager_bewart_id, adding Z11
-- 04.04.2022, AP0111566, SPEC0134176, dknop, changing to akt_msi_user_ek_anzeige_zu_log
--2022-08-04, richternic, AP0132142, SPEC0154921, change akt_msi_user_wrg_typ_zu -> AKT_MSI_USER_PRJ_WRG_TYP_ZU

SELECT
 v01.art_id
,v01.auto_fg
,v01.best_beleg_id
,v01.best_beleg_pos_id
,CASE WHEN v03.wrg_typ_id = 0 THEN (v01.betrag_lagerbew * v02.umrechnungskurs * COALESCE (v04.ek_anzeige_fg,0))
 ELSE (v01.betrag_lagerbew * COALESCE (v04.ek_anzeige_fg,0)) END
* CASE WHEN (v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1) THEN -1
 ELSE 1 END AS betrag_lagerbew
,CASE WHEN v03.wrg_typ_id = 0 THEN (v01.betrag_verkauf * v02.umrechnungskurs)
 ELSE v01.betrag_verkauf END
* CASE WHEN (v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1) THEN -1
ELSE 1 END AS betrag_verkauf
,v01.einkaufsorganisation_id
,v01.erfsngs_menge_einh_id AS erf_menge_einh_id
,v01.grund_id
,v01.kj
,v01.lager_bewart_id
,v01.lagerbew_beleg_id
,v01.lagerbew_beleg_pos_id
,v01.lagerort_id
,CASE WHEN v01.lagerplatz_id IS NULL OR Trim(lagerplatz_id) = '' THEN 'NoStorGrnd'
 ELSE v01.lagerplatz_id END AS lagerplatz_id
,v01.mandant_id
,CASE WHEN v01.mandant_id_empfaenger IS NULL OR v01.mandant_id_empfaenger = 0 THEN v01.mandant_id
 ELSE v01.mandant_id_empfaenger END AS mandant_id_empfaenger
,CASE WHEN v01.mandant_id_kunde IS NULL OR v01.mandant_id_kunde = 0 THEN v01.mandant_id
 ELSE v01.mandant_id_kunde END AS mandant_id_kunde
,CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lagerbew_kolli * -1
 ELSE v01.menge_lagerbew_kolli END AS menge_lagerbew_kolli
,CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lagerbew_bme * -1
 ELSE v01.menge_lagerbew_bme END AS menge_lagerbew_bme
,CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lief * -1
 ELSE v01.menge_lief END AS menge_lief
,CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lieferschein * 1
 ELSE v01.menge_lieferschein END AS menge_lieferschein
,CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lagerbew_palette * -1
 ELSE v01.menge_lagerbew_palette END AS menge_lagerbew_palette
,v01.nb_id
,v01.soll_haben_kz
,v03.wrg_id
,v01.wup_id
,v01.dat_buch
/*CASE
WHEN TO_NUMBER(Substr(v01.kunde_id,7,4)) IS NULL THEN 0
ELSE TO_NUMBER(Substr(v01.kunde_id,7,4)) END AS kunde_id,*/
,CASE WHEN SUBSTR(v01.kunde_id,7,4)= '' THEN 0
 ELSE TO_NUMBER (SUBSTR(v01.kunde_id,7,4)) END AS kunde_id
,CASE WHEN v01.empfaenger_id IS NULL THEN 0
 ELSE v01.empfaenger_id END AS empfaenger_id
,v01.gp_id
,v03.wrg_typ_id
,CASE WHEN v03.wrg_typ_id = 0 THEN (v01.betrag_vk_netto_vz * v02.umrechnungskurs)
 ELSE v01.betrag_vk_netto_vz END
* CASE WHEN (v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1) THEN -1
 ELSE 1 END AS betrag_vk_netto_vz

FROM dbp_view.v_lagerbew_det v01

JOIN (SELECT
 umrechnungskurs
,von_wrg_id
FROM dbp_view.v_kurs
    WHERE dat_bis = TO_DATE('9999-12-31', 'YYYY-MM-DD') AND kurstyp_id = 3
     ) v02
ON v01.wrg_id = v02.von_wrg_id

JOIN dbp_view.v_mandant_wrg_typ_zu v03
ON v01.mandant_id = v03.mandant_id

JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU v05
ON v03.wrg_typ_id = v05.wrg_typ_id

LEFT JOIN dbp_msi.akt_msi_user_ek_anzeige_zu_log v04

WHERE v01.lagerort_id NOT IN ('-1', '-2', '-3');