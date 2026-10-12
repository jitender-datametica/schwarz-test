CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_BEST_AUSG_MENGE_EINH_2
-- AP0032822, SPEC0041631 - 31.10.2108, mkub1811 neue View
-- AP0104298, SPEC0125134 - 28-07-2022, snik1809 new field bruttogew
(
  mandant_id
, art_id
, best_menge_einh_id
, best_umrech_faktor
, best_menge_einh_inhalt
, ausg_menge_einh_id
, ausg_umrech_faktor
, ausg_menge_einh_inhalt
, bruttogew
)
AS
   SELECT
     v01.mandant_id
   , v01.art_id
   , CAST(CASE WHEN v01.best_menge_einh_id IS NULL OR  v01.best_menge_einh_id=''
      THEN  'ST'
      ELSE best_menge_einh_id
      END AS CHAR(3))AS best_menge_einh_id
   , COALESCE(CASE WHEN v02.umrech_faktor = 0 THEN NULL ELSE v02.umrech_faktor END, 1) AS best_umrech_faktor
   , CAST((TRUNC(1 / best_umrech_faktor)) AS DECIMAL(18,0)) AS best_menge_einh_inhalt
   , CAST(CASE WHEN v03.ausg_menge_einh_id IS NULL OR  v03.ausg_menge_einh_id=''
      THEN  'ST'
      ELSE ausg_menge_einh_id
      END AS CHAR(3))AS ausg_menge_einh_id
   , COALESCE(CASE WHEN v04.umrech_faktor = 0 THEN NULL ELSE v04.umrech_faktor END, 1) AS ausg_umrech_faktor
   , CAST((TRUNC(1 / ausg_umrech_faktor)) AS DECIMAL(18,0)) AS ausg_menge_einh_inhalt
   ,v02.bruttogew

   FROM dbp_view.v_art_2 v01
   LEFT OUTER JOIN dbp_view.v_art_umrechnung_faktor_per_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.art_id = v02.art_id
   AND v01.best_menge_einh_id = v02.altnv_menge_einh_id
   AND v02.dat_bis = '9999-12-31'
   LEFT OUTER JOIN dbp_view.v_art_vorschlagswert_per_2 v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.art_id = v03.art_id
   AND v03.dat_bis = '9999-12-31'
   LEFT OUTER JOIN dbp_view.v_art_umrechnung_faktor_per_2 v04
   ON v03.mandant_id = v04.mandant_id
   AND v03.art_id = v04.art_id
   AND v03.ausg_menge_einh_id = v04.altnv_menge_einh_id
   AND v04.dat_bis = '9999-12-31'

   --WHERE v01.mandant_id <> 1
   ;