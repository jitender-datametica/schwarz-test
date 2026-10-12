CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_WERBEWOCHE_KL_1
(
   mandant_id,
   dat,
   akt_kjwo_ww,
   akt_kjwo_ww_komplett,
   kjwo_ww,
   wo_ww,
   ww_dat_von,
   ww_dat_bis,
   ww_mo,
   ww_tag
)
AS
   SELECT 
   mandant_id, 
   dat, 
   akt_kjwo_ww, 
   akt_kjwo_ww_komplett, 
   kjwo_ww, 
   Substr(To_Char(kjwo_ww),5,2) AS wo_ww, 
   Min(dat) Over (PARTITION BY mandant_id, kjwo_ww) AS ww_dat_von, 
   Max(dat) Over (PARTITION BY mandant_id, kjwo_ww) AS ww_dat_bis, 
   (Extract(YEAR From Min(dat) Over (PARTITION BY mandant_id, kjwo_ww)) * 100) + Extract(MONTH From Min(dat) Over (PARTITION BY mandant_id, kjwo_ww)) AS ww_mo, 
   Rank() Over (PARTITION BY mandant_id, kjwo_ww ORDER BY dat) AS ww_tag
   -- neue Tabelle wegen VorVortages-Logik
   FROM
   /* SPEC0249727 Umstellung auf VTA (vorher v_werbewoche_kl_vvt_1) / sschuecke 23.05.2024 */
   dbp_view.v_werbewoche_kl_1;