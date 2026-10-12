CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_BVV_AKTE_1
-- 22.10.2015 kkaiser: neu im Projekt 533
--20180313 nfis0811: Erweiterung für (Spalten)-Internationalisierung: Auslagegerung von bez in spr_zu
(
bvv_akte_id
, mandant_id
, bvv_vertrag_nr
, dat_vertrag_beginn
/*, bvv_akte_bez*/
)

AS

   SELECT DISTINCT
   v01.bvv_akte_id, v01.mandant_id, v01.bvv_vertrag_nr, v01.dat_vertrag_beginn
   /*, v02.bvv_akte_bez*/
   --,CAST(v02.bvv_akte_bez AS VARCHAR(255))     AS bvv_akte_bez
   FROM
   dbp_view.v_ivs_l_bvv_akte_1            v01

   /*JOIN   dbp_view.v_ivs_bvv_akte_spr_zu_1 v02
   ON      v01.bvv_akte_id  = v02.bvv_akte_id
   AND    v01.mandant_id  = v02.mandant_id
   AND    v02.spr_id = 22;*/
   ;