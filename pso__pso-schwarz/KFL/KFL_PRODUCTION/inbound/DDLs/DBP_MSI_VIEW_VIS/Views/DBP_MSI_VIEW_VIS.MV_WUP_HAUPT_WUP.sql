CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_HAUPT_WUP
AS
    -- LOOKUP Stammdaten Filiale (Markt + Getraenkemarkt)
    -- 2019.03.04 ssch0611 : INIT aus mv_wup
    -- 2020.0401 ssch0611 : synchronized/updated columns

   SELECT DISTINCT
     ww.mandant_id, ww.land_id, ww.nb_id                       AS haupt_nb_id, ww.haupt_wup_id                AS haupt_wup_id, ww.wup_standort                AS haupt_wup_standort, eigentum_miete_kz              AS haupt_eigentum_miete, dat_steckbrief                 AS haupt_dat_steckbrief, dat_geschlossen                AS haupt_dat_geschlossen, dat_letzte_modernisierung_von  AS haupt_dat_mod_von, dat_letzte_modernisierung_bis  AS haupt_dat_mod_bis, dat_letzter__facelift_von      AS haupt_dat_fcl_von -- 2020.04
   , dat_letzter_facelift           AS haupt_dat_fcl, umsatz_erwartung_eur           AS haupt_ums_erwart_eur -- 2020.04
   , einwohner_anzahl               AS haupt_ew_anzahl      -- 2020.04
   , Trim(land_id) || ' ' || Trim(wup_id) || ' ' || Trim(wup_standort) AS haupt_wup_bez
   FROM dbp_msi_view_vis.mv_wup ww

   WHERE ww.wup_id = ww.haupt_wup_id
   AND ww.nb_id IN (0,-1);