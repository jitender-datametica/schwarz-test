CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_ODS_BONDATEN_2
-- 04.01.2017 : Initial Anlage_2 (ttez1905)
-- 09.01.2017: kjwo, wg_id, view wupcal_2 rausgenommen. in_art_id hinzugefuegt. (ttez1905)
-- 11.01.2017: wg_id und arthier_typ_id in die View aufgenommen. Artikel_2-Ebene wird nicht benoetigt (ttez1905)
-- 23.11.2018: Joinweg geaendert wegen WG Umstellung. Siehe SPEC0046420. Artikel_2 Id wurde in die View aufgenommen. (nak2305)
-- 29.11.2018: Joinweg ueber der art_id aus  Art_2 Tabelle zu der wg_id aus der art_wg_zu_per.
-- 13.08.2019 twie: NSR0906348 bon_dat in Join zwischen ods_bon_verkauf_2 und ods_bon_kopf_2 aufgenommen, da Partitionierung der Tabellen geaendert wurde -> Performancevorteil
(
mandant_id
,wup_id
,bon_dat
,arthiertyp_id
,wg_id
,anzahl_scanned
,anzahl_keyed
,anzahl_bons
)
AS
   SELECT
   k.mandant_id, k.wup_id, k.bon_dat, v02.arthiertyp_id, v02.wg_id, SUM(CASE WHEN v.erfassung_id = 'SC' THEN 1 ELSE 0 END) AS anzahl_scanned, SUM(CASE WHEN v.erfassung_id = 'KE' THEN 1 ELSE 0 END) AS anzahl_keyed, COUNT(DISTINCT(k.bon_id)) AS anzahl_bons

   FROM dbp_v_ods.v_ods_bon_verkauf_2 v

   JOIN dbp_v_ods.v_ods_bon_kopf_2 k
   ON k.mandant_id = v.mandant_id
   AND k.wup_id = v.wup_id
   AND k.bon_id = v.bon_id
   AND k.bon_dat = v.bon_dat

   JOIN dbp_view.v_art_2 v01
   ON  v.kl_art_id = v01.kl_art_id
   AND  v.mandant_id = v01.mandant_id

   JOIN dbp_view.v_art_wg_zu_per_2 v02
   ON  v01.art_id= v02.art_id
   AND  v01.mandant_id = v02.mandant_id


   WHERE
   k.mandant_id IN (1,2)
   AND (k.bon_id, k.bon_dat) NOT IN  (SELECT bon_id, bon_dat FROM dbp_v_ods.v_ods_bon_storno_2)

   GROUP BY 1,2,3,4,5;
