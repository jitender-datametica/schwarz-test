CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_FUR_PROGNOSE_ARTBEW_WG_SUM_2
-- #619834 Erweiterung Feld diff_menge_af_prognose
--         Ausbau Filterung auf dispomerkmal, listung_id und kdis - sschuecke 15.07.2015
(
wup_id
,nb_id
,mandant_id
,wg_id
,dat
,menge_prognose
,menge_prognose_bef
,menge_prognose_max
,vk_menge
,vk_menge_af
,vk_menge_sa
,diff_menge_af_prognose
)
AS

   SELECT
   v01.wup_id,
   v01.nb_id,
   v01.mandant_id,
   v01.wg_id,
   v01.dat,
   CAST(v01.menge_prognose AS DECIMAL(18,3)) AS menge_prognose,
   CAST(v01.menge_prognose_bef AS DECIMAL(18,3)) AS menge_prognose_bef,
   CAST(v01.menge_prognose_max AS DECIMAL(18,3)) AS menge_prognose_max,
   CAST(v01.menge_af +v01.menge_sa AS NUMBER(38,5)) AS menge,
   CAST(v01.menge_af AS NUMBER(38,5)) AS vk_menge_af,
   CAST(v01.menge_sa AS NUMBER(38,5)) AS vk_menge_sa,
   CAST(v01.diff_menge_af_prognose AS DECIMAL (18,3)) AS diff_menge_af_prognose
   FROM dbp_view.v_fur_prognose_wg_sum_2 v01

   WHERE v01.mandant_id <> 1;