CREATE OR REPLACE VIEW dbp_msi_view_log.mv_lagerbew_lgort_grund_wup_1 
(
 mandant_id
,mandant_id_empfaenger
,lagerort_id
,grund_id
,wup_id
,nb_id
,auto_fg
,dat_buch
,vorgangsart_id
,lager_bewart_id
,wg_id
,arthiertyp_id
,empfaenger_id
,betrag_lagerbew
,betrag_verkauf
,menge_lagerbew_bme
,menge_lief
,menge_lieferschein
,menge_lagerbew_kolli
,menge_lagerbew_palette
,menge_erf
,wrg_id
,wrg_typ_id
,betrag_vk_netto_vz
,lief_pal_typ_id
)
AS
-- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_1
-- 27.10.2021, dknop, Anpassung Moldau BEWART_1 643/644 based on LIS
--16.12.2021, dknop, expanding condition with Z11
--2022-08-04, richternic, AP0132142, SPEC0154921, change akt_msi_user_wrg_typ_zu_1 -> AKT_MSI_USER_PRJ_WRG_TYP_ZU

SELECT
 v01.mandant_id
,CASE WHEN v01.mandant_id_empfaenger IS NULL OR v01.mandant_id_empfaenger = 0 THEN v01.mandant_id ELSE v01.mandant_id_empfaenger END AS mandant_id_empfaenger
,v01.lagerort_id
,v01.grund_id
,v01.wup_id
,v01.nb_id
,v01.auto_fg
,v01.dat_buch
,v01.vorgangsart_id
,v01.lager_bewart_id
,v01.wg_id
,v01.arthiertyp_id
,CASE WHEN v01.empfaenger_id IS NULL THEN 0 ELSE v01.empfaenger_id END AS empfaenger_id
,CASE WHEN v03.wrg_typ_id = 0 THEN v01.betrag_lagerbew * v02.umrechnungskurs ELSE v01.betrag_lagerbew END 
* CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN -1 ELSE 1 END AS betrag_lagerbew
,CASE WHEN v03.wrg_typ_id = 0 THEN v01.betrag_verkauf * v02.umrechnungskurs ELSE betrag_verkauf END 
* CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN -1
ELSE 1 END AS betrag_verkauf
,CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lagerbew_bme * -1
ELSE v01.menge_lagerbew_bme END AS menge_lagerbew_bme
,CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lief * -1
ELSE v01.menge_lief END AS menge_lief
,CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lieferschein * 1
ELSE v01.menge_lieferschein END AS menge_lieferschein
,CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lagerbew_kolli * -1
ELSE v01.menge_lagerbew_kolli END AS menge_lagerbew_kolli
,CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_lagerbew_palette * -1
ELSE v01.menge_lagerbew_palette END AS menge_lagerbew_palette
,CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN v01.menge_erf * -1
ELSE v01.menge_erf END AS menge_erf
,v03.wrg_id
,v03.wrg_typ_id
,CASE WHEN v03.wrg_typ_id = 0 THEN v01.betrag_vk_netto_vz * v02.umrechnungskurs ELSE v01.betrag_vk_netto_vz END 
* CASE WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '643', '647', '302', '312', '602', '642', '644', '648', 'Z11') AND v01.mandant_id <> 1 THEN -1
ELSE 1 END AS betrag_vk_netto_vz
,v01.lief_pal_typ_id
FROM dbp_view.v_lagerbew_lgort_grund_wup_1 v01

JOIN (SELECT
 umrechnungskurs
,von_wrg_id
FROM dbp_view.v_kurs_1
      WHERE dat_bis = TO_DATE('9999-12-31', 'YYYY-MM_1-DD') AND kurstyp_id = 3
	 ) v02
  ON v01.wrg_id = v02.von_wrg_id

JOIN dbp_view.v_mandant_wrg_typ_zu_1 v03
ON v01.mandant_id = v03.mandant_id

JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1 v04
ON v03.wrg_typ_id = v04.wrg_typ_id

WHERE v01.lagerort_id NOT IN ('-1', '-2', '-3');