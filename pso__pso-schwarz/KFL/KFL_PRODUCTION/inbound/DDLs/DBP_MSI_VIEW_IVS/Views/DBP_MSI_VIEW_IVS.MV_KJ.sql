CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_KJ as
   -- 2008-12-15 NEU
   -- FAKTVIEW ZEIT (KJ)
   SELECT
   kj,
   akt_kj,
   akt_kj_komplett
  FROM dbp_view.v_jahr_kj
;