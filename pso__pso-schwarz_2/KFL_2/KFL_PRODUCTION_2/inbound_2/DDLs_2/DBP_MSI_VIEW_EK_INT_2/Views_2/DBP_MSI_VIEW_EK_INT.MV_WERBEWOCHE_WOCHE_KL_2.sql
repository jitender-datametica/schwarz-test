CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_WERBEWOCHE_WOCHE_KL_2
AS
   SELECT
   distinct
   mandant_id, akt_kjwo_ww, akt_kjwo_ww_komplett, kjwo_ww, (kjwo_ww - 100) AS kjwo_ww_vj, Substr(To_Char(kjwo_ww),5,2) AS wo_ww, Min(dat) Over (PARTITION BY mandant_id, kjwo_ww) AS ww_dat_von, Max(dat) Over (PARTITION BY mandant_id, kjwo_ww) AS ww_dat_bis, (Extract(YEAR From Min(dat) Over (PARTITION BY mandant_id, kjwo_ww)) * 100) +
   Extract(MONTH From Min(dat) Over (PARTITION BY mandant_id, kjwo_ww)) AS ww_mo
   FROM dbp_msi_view_ek_int.mv_werbewoche_kl_2;