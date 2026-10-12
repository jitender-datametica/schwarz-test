CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_KJ_1 as
   -- 2008-12-15 NEU
   -- FAKTVIEW ZEIT_1 (KJ)
   SELECT
   kj,
   akt_kj,
   akt_kj_komplett
  FROM dbp_view.v_jahr_kj_1
;