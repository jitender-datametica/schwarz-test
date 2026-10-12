CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_FUR_PROGNOSE_ARTBEW_1
-- #619834 Erweiterung Berechnung Wert diff_menge_af_prognose - sschuecke 15.07.2015
-- Anpassung Berechnung Diff_menge_af_prognose - sschuecke 31.08.2015
-- #AP0003026 Erweiterung um neue Felder - sschuecke 16.08.2016
--#AP0004411 Erweiterung  Filterung DM - sschuecke 27.04.2017
--#INC1293744 Anpassung Berechnung diff_menge_af_prognose - sschuecke 09.11.2017
--SPEC0068483 - adding bewart_1 1010 to the AF columns
-- AP0055243_SPEC0076970_SCM - Add: menge_ofc - nwag2310 13.05.2020
(
 wup_id
,nb_id
,mandant_id
,art_id
,dat
,menge_prognose
,menge_prognose_bef
,menge_prognose_max
,menge_ofc
,vk_menge
,vk_menge_af
,vk_menge_sa
,diff_menge_af_prognose
,gp_id
,progn_groesser_fg
,menge_af_groesser_fg
)
AS

   SELECT
   dt1.wup_id,
   dt1.nb_id,
   dt1.mandant_id,
   dt1.art_id,
   dt1.dat,
   MIN(dt1.menge_prognose) AS menge_prognose,
   MIN(dt1.menge_prognose_bef) AS menge_prognose_bef,
   MIN(dt1.menge_prognose_max) AS menge_prognose_max,
   MIN(dt1.menge_ofc) AS menge_ofc,
   SUM(dt1.menge) AS menge,
   SUM(vk_menge_af) AS vk_menge_af,
   SUM(vk_menge_sa) AS vk_menge_sa,
   CASE WHEN SUM(vk_menge_sa) IS NOT NULL THEN NULL ELSE ABS(ZEROIFNULL(SUM(vk_menge_af)) - MIN(menge_prognose)) END AS diff_menge_af_prognose,
   dt1.gp_id,
   dt1.progn_groesser_fg,
   dt1.menge_af_groesser_fg

   FROM

   (SELECT
    v01.wup_id,
   v01.nb_id,
   v01.mandant_id,
   v01.art_id,
   v02.dat,
   CAST(v01.menge_prognose AS DECIMAL(18,3)) AS menge_prognose,
   CAST(v01.menge_prognose_bef AS DECIMAL(18,3)) AS menge_prognose_bef,
   CAST(v01.menge_prognose_max AS DECIMAL(18,3)) AS menge_prognose_max,
   CAST(v01.menge_ofc AS DECIMAL(18,3)) AS menge_ofc,
   CAST(v04.menge AS NUMBER(38,5)) AS menge,
   CASE WHEN v04.bewart_id IN (1001,1010) THEN CAST(v04.menge AS NUMBER(38,5)) END vk_menge_af,
   CASE WHEN v04.bewart_id = 1002 THEN CAST(v04.menge AS NUMBER(38,5)) END vk_menge_sa,
   CASE WHEN vk_menge_sa IS NOT NULL THEN NULL ELSE ABS(ZEROIFNULL(vk_menge_af) - menge_prognose) END AS diff_menge_af_prognose,
   v03.gp_id,
   v01.progn_groesser_fg,
   v01.menge_af_groesser_fg

   FROM DBP_DATA.FUR_PROGNOSE_1 v01
   INNER JOIN DBP_DATA.TAG_1 v02
   ON v02.dat = v01.dat
   INNER JOIN DBP_DATA.ART_GP_NM_ZU_PER_1 v03
   ON v01.art_id = v03.art_id
   AND v01.wup_id =v03.wup_id
   AND v01.mandant_id = v03.mandant_id
   AND v02.dat BETWEEN v03.dat_von AND v03.dat_bis
   LEFT JOIN DBP_DATA.ARTBEW_1 v04
   ON v01.art_id = v04.art_id
   AND v01.mandant_id = v04.mandant_id
   AND v01.wup_id = v04.wup_id
   AND v01.nb_id = v04.nb_id
   AND v03.gp_id = v04.gp_id
   AND v02.dat = v04.dat

   WHERE v01.mandant_id > 1
   AND v01.dispomerkmal IN ('S2', '10', '12', '14')
   AND v01.listung_id = 1
   AND v01.kdis = 0
    --AP0190987/SPEC0225041 Filter E-Loading Artikel_1 / sschuecke 17.11.2023
   AND NOT (v04.mandant_id = 5 AND v04.art_id = 206731500)
   --AP0227085/SPEC0284781 Filter E-Loading Artikel_1 / sschuecke 25.02.2025
   AND NOT (v04.mandant_id = 2 AND v04.art_id = 208124500)
   AND NOT (v04.mandant_id = 3 AND v04.art_id = 208113690)
   AND NOT (v04.mandant_id = 6 AND v04.art_id = 208131570)
   AND NOT (v04.mandant_id IN (4,7) AND v04.art_id = 208114740)
   AND NOT (v04.mandant_id = 8 AND v04.art_id = 208131640)
   ) dt1

   GROUP BY
    dt1.wup_id
   ,dt1.nb_id
   ,dt1.mandant_id
   ,dt1.art_id
   ,dt1.dat
   ,dt1.gp_id
   ,dt1.progn_groesser_fg
   ,dt1.menge_af_groesser_fg;