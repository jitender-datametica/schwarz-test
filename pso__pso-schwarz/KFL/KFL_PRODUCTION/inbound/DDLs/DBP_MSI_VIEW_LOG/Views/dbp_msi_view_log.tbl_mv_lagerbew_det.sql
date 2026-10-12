CREATE OR REPLACE VIEW dbp_msi_view_log.tbl_mv_lagerbew_det -- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage
(
 art_id
,auto_fg
,best_beleg_id
,best_beleg_pos_id
,betrag_verkauf
,einkaufsorganisation_id
,erf_menge_einh_id
,grund_id
,kj
,lager_bewart_id
,lagerbew_beleg_id
,lagerbew_beleg_pos_id
,lagerort_id
,lagerplatz_id
,mandant_id
,mandant_id_empfaenger
,mandant_id_kunde
,menge_lagerbew_kolli
,menge_lagerbew_bme
,menge_lief
,menge_lieferschein
,menge_lagerbew_palette
,nb_id
,soll_haben_kz
,wrg_id
,wup_id
,dat_buch
,kunde_id
,empfaenger_id
,gp_id
,wrg_typ_id
,betrag_vk_netto_vz
,betrag_lagerbew
,umrechnungskurs
)
AS
SELECT
v01.art_id,
v01.auto_fg,
v01.best_beleg_id,
v01.best_beleg_pos_id,
CASE
WHEN v03.wrg_typ_id = 0 THEN (v01.betrag_verkauf * v02.umrechnungskurs)
ELSE v01.betrag_verkauf END
* CASE
WHEN (v01.lager_bewart_id IN ('301', '311', '601', '641', '647') AND v01.mandant_id <> 1) THEN -1
ELSE 1 END AS betrag_verkauf,
v01.einkaufsorganisation_id,
v01.erfsngs_menge_einh_id,
v01.grund_id,
v01.kj,
v01.lager_bewart_id,
v01.lagerbew_beleg_id,
v01.lagerbew_beleg_pos_id,
v01.lagerort_id,
CASE
WHEN v01.lagerplatz_id IS NULL OR Trim(lagerplatz_id) = '' THEN 'NoStorGrnd'
ELSE v01.lagerplatz_id END AS lagerplatz_id,
v01.mandant_id,
CASE
WHEN v01.mandant_id_empfaenger IS NULL OR v01.mandant_id_empfaenger = 0 THEN v01.mandant_id
ELSE v01.mandant_id_empfaenger END AS mandant_id_empfaenger,
CASE
WHEN v01.mandant_id_kunde IS NULL OR v01.mandant_id_kunde = 0 THEN v01.mandant_id
ELSE v01.mandant_id_kunde END AS mandant_id_kunde,
CASE
WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '647') AND v01.mandant_id <> 1 THEN v01.menge_lagerbew_kolli * -1
ELSE v01.menge_lagerbew_kolli END AS menge_lagerbew_kolli,
CASE
WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '647') AND v01.mandant_id <> 1 THEN v01.menge_lagerbew_bme * -1
ELSE v01.menge_lagerbew_bme END AS menge_lagerbew_bme,
CASE
WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '647') AND v01.mandant_id <> 1 THEN v01.menge_lief * -1
ELSE v01.menge_lief END AS menge_lief,
CASE
WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '647') AND v01.mandant_id <> 1 THEN v01.menge_lieferschein * 1
ELSE v01.menge_lieferschein END AS menge_lieferschein,
CASE
WHEN v01.lager_bewart_id IN ('301', '311', '601', '641', '647') AND v01.mandant_id <> 1 THEN v01.menge_lagerbew_palette * -1
ELSE v01.menge_lagerbew_palette END AS menge_lagerbew_palette,
v01.nb_id,
v01.soll_haben_kz,
v03.wrg_id,
v01.wup_id,
v01.dat_buch,
CASE
WHEN TO_NUMBER(Substr(v01.kunde_id,7,4)) IS NULL THEN 0
ELSE TO_NUMBER(Substr(v01.kunde_id,7,4)) END AS kunde_id,
CASE
WHEN v01.empfaenger_id IS NULL THEN 0
ELSE v01.empfaenger_id END AS empfaenger_id,
v01.gp_id,
v03.wrg_typ_id,
CASE
WHEN v03.wrg_typ_id = 0 THEN (v01.betrag_vk_netto_vz * v02.umrechnungskurs)
ELSE v01.betrag_vk_netto_vz END
* CASE
WHEN (v01.lager_bewart_id IN ('301', '311', '601', '641', '647') AND v01.mandant_id <> 1) THEN -1
ELSE 1 END AS betrag_vk_netto_vz,
v01.betrag_lagerbew,
v02.umrechnungskurs
FROM dbp_view.v_lagerbew_det v01

JOIN (SELECT
umrechnungskurs,
von_wrg_id
FROM dbp_view.v_kurs
      WHERE dat_bis = to_date('9999-12-31', 'YYYY-MM-DD') AND kurstyp_id = 3
     ) v02
  ON v01.wrg_id = v02.von_wrg_id

JOIN dbp_view.v_mandant_wrg_typ_zu v03
ON v01.mandant_id = v03.mandant_id

WHERE v01.lagerort_id NOT IN ('-1', '-2', '-3');