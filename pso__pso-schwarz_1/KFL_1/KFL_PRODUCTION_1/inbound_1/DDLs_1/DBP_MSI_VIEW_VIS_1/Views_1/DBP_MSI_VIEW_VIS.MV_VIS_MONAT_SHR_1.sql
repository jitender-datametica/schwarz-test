CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_SHR_1 as
   -- LOOKUP -- SHR Berichtsmonat auf Basis Buchungsstatus KER
   -- REDESIGN VIS Personal auf Basis SHR Mitarbeiterbew_1
   -- 2018.0926 ssch0611 : Initial
   -- 2018.1106 ssch0611 : Final/Release

   SELECT
   kj_ker_mo_id        AS kjmo, akt_fruehinfo2 - 1  AS akt_mo_shr -- Berichtsmonat = -1
   , akt_fruehinfo2                    -- original FG
   , dat_fruehinfo2, akt_gj_buchungs_schluss
   FROM dbp_view.v_l_buchungsstatus_ker_1
   ;