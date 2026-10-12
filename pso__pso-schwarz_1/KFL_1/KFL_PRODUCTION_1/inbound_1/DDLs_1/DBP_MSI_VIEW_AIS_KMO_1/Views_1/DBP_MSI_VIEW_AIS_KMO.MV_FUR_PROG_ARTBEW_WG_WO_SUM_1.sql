CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_FUR_PROG_ARTBEW_WG_WO_SUM_1
-- #619834 Erweiterung Feld diff_menge_af_prognose
--         Ausbau Filterung auf dispomerkmal, listung_id und kdis - sschuecke 15.07.2015
-- #AP0003026 Erweiterung um neue Felder - sschuecke 16.08.2016
(
wup_id
,nb_id
,mandant_id
,wg_id
,kjwo_kl
,menge_prognose
,menge_prognose_bef
,menge_prognose_max
,vk_menge
,vk_menge_af
,vk_menge_sa
,diff_menge_af_prognose
,sum_progn_groesser
,sum_menge_af_groesser
,menge_af_mittel_3wo
,progn_groesser_wo_fg
,menge_af_groesser_wo_fg
,progn_grosser_wo0_fg
,progn_groesser_wo1_fg
,progn_groesser_wo2_fg
,menge_af_groesser_wo0_fg
,menge_af_groesser_wo1_fg
,menge_af_groesser_wo2_fg
)
AS

   SELECT
   v01.wup_id,
   v01.nb_id,
   v01.mandant_id,
   v01.wg_id,
   v01.kjwo_kl,
   CAST(v01.menge_prognose AS DECIMAL(18,3)) AS menge_prognose,
   CAST(v01.menge_prognose_bef AS DECIMAL(18,3)) AS menge_prognose_bef,
   CAST(v01.menge_prognose_max AS DECIMAL(18,3)) AS menge_prognose_max,
   CAST(v01.menge_af + v01.menge_sa AS NUMBER(38,5)) AS menge,
   CAST(v01.menge_af AS NUMBER(38,5)) AS vk_menge_af,
   CAST(v01.menge_sa AS NUMBER(38,5)) AS vk_menge_sa,
   CAST(v01.diff_menge_af_prognose AS DECIMAL (18,3)) AS diff_menge_af_prognose,
   v01.sum_progn_groesser,
   v01.sum_menge_af_groesser,
   CAST(v01.menge_af_mittel_3wo AS DECIMAL(18,3)) AS menge_af_mittel_3wo,
   v01.progn_groesser_wo_fg,
   v01.menge_af_groesser_wo_fg,
   v01.progn_grosser_wo0_fg,
   v01.progn_groesser_wo1_fg,
   v01.progn_groesser_wo2_fg,
   v01.menge_af_groesser_wo0_fg,
   v01.menge_af_groesser_wo1_fg,
   v01.menge_af_groesser_wo2_fg

   FROM dbp_view.v_fur_prognose_wg_wo_sum_1 v01

   WHERE v01.mandant_id > 1;