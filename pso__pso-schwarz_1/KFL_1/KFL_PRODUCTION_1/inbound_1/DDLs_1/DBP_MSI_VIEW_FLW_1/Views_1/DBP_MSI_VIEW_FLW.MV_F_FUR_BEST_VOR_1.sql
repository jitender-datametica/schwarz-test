CREATE
OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FUR_BEST_VOR_1 AS
SELECT
   v01.art_id,
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.dat_dispo,
   v01.gp_id,
   v01.menge_best_vor,
   --Umrechnung in die Basismengeeinheit
   cast(
      (
         v01.menge_best_vor / CASE
            WHEN v04.umrech_faktor = 0 THEN null
            ELSE v04.umrech_faktor
         END
      ) as NUMBER(38, 5)
   ) as menge_best_vor_bme,
   dat_lief_soll,
   v03.dat_naechst_verkaufstag
FROM
   dbp_view.v_fur_best_vor_1 v01
   INNER JOIN dbp_view.v_art_1 v02 ON v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id
   LEFT OUTER JOIN dbp_view.v_art_wup_tag_denorm_1 v03 ON v01.art_id = v03.art_id
   AND v01.mandant_id = v03.mandant_id
   AND v01.wup_id = v03.wup_id
   AND v01.dat_lief_soll = v03.dat
   INNER JOIN dbp_view.v_art_umrechnung_faktor_per_1 v04 ON v02.art_id = v04.art_id
   AND v02.mandant_id = v04.mandant_id
   AND v02.best_menge_einh_id = v04.altnv_menge_einh_id
   AND dat_dispo BETWEEN v04.dat_von
   and v04.dat_bis
WHERE
   v01.mandant_id = 1;