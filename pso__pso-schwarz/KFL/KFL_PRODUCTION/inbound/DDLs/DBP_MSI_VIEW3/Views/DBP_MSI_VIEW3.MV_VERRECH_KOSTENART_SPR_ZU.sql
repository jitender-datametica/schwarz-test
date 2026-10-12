CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_VERRECH_KOSTENART_SPR_ZU (
   mandant_id,
   verrechfall_kostenart_id,
   spr_id,
   verrechfall_kostenart_bez
) AS 
-- 20230717 staeblern Umstellung auf Session Variable
-- 02-08-2024, dknop, adding new kostenart_id
   SELECT
   v01.mandant_id, v01.verrechfall_kostenart_id, v01.spr_id, v01.verrechfall_kostenart_bez

   FROM dbp_view.v_verrechfall_kostenart_spr_zu v01

   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 --dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id
   
UNION
SELECT mandant_id,'MDIES',v01.spr_id, 'manuelle Berechnung Diesel-Anteil'
FROM dbp_view.v_verrechfall_kostenart_spr_zu v01

   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 --dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id
UNION
SELECT mandant_id,'MSTRO',v01.spr_id, 'manuelle Berechnung Strom-Anteil'
FROM dbp_view.v_verrechfall_kostenart_spr_zu v01

   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 --dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id
UNION
SELECT mandant_id,'MGAS',v01.spr_id, 'manuelle Berechnung Gas-Anteil'
FROM dbp_view.v_verrechfall_kostenart_spr_zu v01

   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 --dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id
UNION
SELECT mandant_id,'MMAUT',v01.spr_id, 'manuelle Berechnung Maut-Anteil'
FROM dbp_view.v_verrechfall_kostenart_spr_zu v01

   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 --dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id
UNION
SELECT mandant_id,'MKUEH',v01.spr_id, 'manuelle Berechnung Kühlung-Anteil'
FROM dbp_view.v_verrechfall_kostenart_spr_zu v01

   JOIN DBP_MSI_VIEW3.MV_USER_SPR_ZU v02 --dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id   
     
   ;