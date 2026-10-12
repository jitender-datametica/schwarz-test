CREATE OR REPLACE VIEW dbp_msi_view_log.tbl_mv_lagerbestand_erp_per_2 -- 02.03.2020, AP0053509, SPEC0071753, srom0404, initiale Anlage_2
(
 art_id
,gjmo_buch
,lagerort_id
,lagerort_loesch_fg
,mandant_id
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_kolli
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_palette
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_ret_gesp_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_bme
,nb_id
,pflege_status
,sperr_id
,wup_id
,dat
,wrg_id
,wrg_typ_id
,vk_netto_lgbest_erp
,umrechnungskurs
,betrag_lgbest_erp
)
AS
SELECT
v01.art_id,
v01.gjmo_buch,
v01.lagerort_id,
v01.lagerort_loesch_fg,
v01.mandant_id,
v01.menge_lgbest_erp_frei_bme,
v01.menge_lgbest_erp_gesp_bme,
v01.menge_lgbest_erp_kolli,
v01.menge_lgbest_erp_nf_charge_bme,
v01.menge_lgbest_erp_palette,
v01.menge_lgbest_erp_qual_bme,
v01.menge_lgbest_erp_ret_gesp_bme,
v01.menge_lgbest_erp_umlag_bme,
Cast((v01.menge_lgbest_erp_frei_bme + v01.menge_lgbest_erp_gesp_bme + v01.menge_lgbest_erp_qual_bme + v01.menge_lgbest_erp_ret_gesp_bme + v01.menge_lgbest_erp_umlag_bme) AS DECIMAL (18,3) ) AS menge_lgbest_erp_bme,
v01.nb_id,
v01.pflege_status,
v01.sperr_id,
v01.wup_id,
v04.dat,
v03.wrg_id,
v03.wrg_typ_id,
CASE
WHEN v03.wrg_typ_id = 0 THEN (v01.vk_netto_lgbest_erp * v02.umrechnungskurs)
ELSE v01.vk_netto_lgbest_erp END AS vk_netto_lgbest_erp,
v02.umrechnungskurs,
v01.betrag_lgbest_erp
FROM dbp_view.v_lagerbestand_erp_per_2 v01

JOIN (SELECT
umrechnungskurs,
von_wrg_id
FROM dbp_view.v_kurs_2
      WHERE dat_bis = to_date('9999-12-31', 'YYYY-MM_2-DD') AND kurstyp_id = 3
     ) v02
  ON v01.wrg_id = v02.von_wrg_id

JOIN dbp_view.v_mandant_wrg_typ_zu_2 v03
ON v01.mandant_id = v03.mandant_id


JOIN dbp_view.v_tag_2 v04
ON v04.dat BETWEEN v01.dat_von AND v01.dat_bis

;