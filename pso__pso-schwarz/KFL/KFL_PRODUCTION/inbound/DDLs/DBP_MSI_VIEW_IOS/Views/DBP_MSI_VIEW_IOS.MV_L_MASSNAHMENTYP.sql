CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_L_MASSNAHMENTYP as
   -- Faktview : Massnahmengruppe gemäß: AP0004980
   -- 20161202 kkai0912 : initial
   -- 20180313nfis0811: Erweiterung für (Spalten)-Internationalisierung - BEZ ausgelagert in spr_zu
   SELECT
   v01.massnahmentyp_id
   /* , CASE WHEN v02.massnahmentyp_id = '-1' THEN '  ' ELSE v02.massnahmentyp_bez END AS massnahmentyp_bez*/

   FROM
   dbp_view.v_l_massnahmentyp v01
   /*JOIN dbp_view.v_massnahmentyp_spr_zu v02
   ON v01.massnahmentyp_id = v02.massnahmentyp_id
   AND v02.spr_id = 22;*/
   ;