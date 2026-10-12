CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ARTIKEL_VKPREIS_2
(
art_id
, mandant_id
--, umrechnungskurs_
, VKPK1
, VKPK1_NETTO
, VKPK2
, VKPK3
, VKPK4
, VKPK4_NETTO
, VKPK5
, VKPK6
, VKPK7
, VKPK8
, VKPK9
, VKPK10
, mwst
)
AS
   SELECT
   v01.art_id, 
   v01.mandant_id, 
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / in diesem Fall nur Umstellung auf akt. Berichtskurs, da immer aktueller Preis - sschuecke 10.01.2025 
  --CASE WHEN v200.wrg_typ_id  = 1 THEN  1.00 ELSE v300.umrechnungskurs END umrechnungskurs_, 
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK1 *v300.umrechnungskurs 
              ELSE _VKPK1 END AS DECIMAL(12,5)) AS VKPK1,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK1 *v300.umrechnungskurs / (1.000 + mwst/100.000)
              ELSE _VKPK1 / (1.000 + mwst/100.000) END AS DECIMAL(12,5)) AS VKPK1_NETTO,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK2 *v300.umrechnungskurs 
              ELSE _VKPK2 END AS DECIMAL(12,5)) AS VKPK2,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK3 *v300.umrechnungskurs 
              ELSE _VKPK3 END AS DECIMAL(12,5)) AS VKPK3,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK4 *v300.umrechnungskurs 
              ELSE _VKPK4 END AS DECIMAL(12,5)) AS VKPK4,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK4 *v300.umrechnungskurs / (1.000 + mwst/100.000)
              ELSE _VKPK4 / (1.000 + mwst/100.000) END AS DECIMAL(12,5)) AS VKPK4_NETTO,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK5 *v300.umrechnungskurs 
              ELSE _VKPK5 END AS DECIMAL(12,5)) AS VKPK5,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK6 *v300.umrechnungskurs 
              ELSE _VKPK6 END AS DECIMAL(12,5)) AS VKPK6,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK7 *v300.umrechnungskurs 
              ELSE _VKPK7 END AS DECIMAL(12,5)) AS VKPK7,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK8 *v300.umrechnungskurs 
              ELSE _VKPK8 END AS DECIMAL(12,5)) AS VKPK8,
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK9 *v300.umrechnungskurs 
              ELSE _VKPK9 END AS DECIMAL(12,5)) AS VKPK9,   
   CAST (CASE WHEN v200.wrg_typ_id = 0 THEN _VKPK10 *v300.umrechnungskurs 
              ELSE _VKPK10 END AS DECIMAL(12,5)) AS VKPK10,
   mwst

   FROM dbp_view.v_art_2 v01
   LEFT OUTER JOIN
   (
   SELECT
   art_id, mandant_id, Max(CASE WHEN  pm_id = 1 THEN vk_brutto END)  AS _VKPK1, Max(CASE WHEN  pm_id = 2 THEN vk_brutto END)  AS _VKPK2, Max(CASE WHEN  pm_id = 3 THEN vk_brutto END)  AS _VKPK3, Max(CASE WHEN  pm_id = 4 THEN vk_brutto END)  AS _VKPK4, Max(CASE WHEN  pm_id = 5 THEN vk_brutto END)  AS _VKPK5, Max(CASE WHEN  pm_id = 6 THEN vk_brutto END)  AS _VKPK6, Max(CASE WHEN  pm_id = 7 THEN vk_brutto END)  AS _VKPK7, Max(CASE WHEN  pm_id = 8 THEN vk_brutto END)  AS _VKPK8, Max(CASE WHEN  pm_id = 9 THEN vk_brutto END)  AS _VKPK9, Max(CASE WHEN  pm_id =10 THEN vk_brutto END)  AS _VKPK10

   FROM dbp_view.v_art_pm_vw_zu_per_2
   WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
   AND preistyp_id = 0
   GROUP BY art_id, mandant_id
   ) v02
   ON v01.mandant_id = v02.mandant_id AND
   v01.art_id = v02.art_id
   LEFT OUTER JOIN dbp_view.v_mwst_per_2 v03
   ON v03.dat_bis = '9999-12-31' AND
   v01.mwst_id=v03.mwst_id AND
   v01.mandant_id = v03.mandant_id

   JOIN dbp_view.v_mandant_2 v100
   ON v01.mandant_id = v100.mandant_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v200

    /*  -- Umrechnung Aktuell Standardkurs, Tageskurs
   JOIN
   dbp_view.v_kurs_2 v300
   ON CURRENT_DATE BETWEEN v300.dat_von AND v300.dat_bis
   AND v100.default_wrg = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR'*/
   
   
-- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_2 v300
   ON v300.dat_bis = '9999-12-31'
   AND v100.default_wrg = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR';