CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_RUECKLASTSCHRIFT_1 as
      -- 2009-06-15
      -- FAKTVIEW Ruecklastschriften
      -- 2009KW17 EUR + LW über waehrungstyp
      -- 2009KW27 Historisierung Kurs_1
      --  2009KW47 Umstellung mv_zeit_1 auf v_monat_1

      SELECT
      rl.mandant_id,
      rl.debitor_id,
      rl.kjmo,
      rl.dat_beleg,
      rl.beleg_betrag * kurs_1 beleg_betrag,
      kurs.wrg_id,
      kurs.wrg_typ_id
     FROM dbp_view.v_ivs_ruecklastschrift_1 rl
      INNER JOIN dbp_view.v_monat_1  zeit_1
      ON zeit.kjmo = rl.kjmo
      INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_1  kurs_1
      ON kurs.mandant_id = rl.mandant_id
      AND max_dat BETWEEN kurs_dat_von AND kurs_dat_bis;