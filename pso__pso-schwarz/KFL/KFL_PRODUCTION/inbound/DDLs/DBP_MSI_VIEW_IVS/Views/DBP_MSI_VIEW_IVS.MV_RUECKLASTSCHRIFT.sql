CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_RUECKLASTSCHRIFT as
      -- 2009-06-15
      -- FAKTVIEW Ruecklastschriften
      -- 2009KW17 EUR + LW über waehrungstyp
      -- 2009KW27 Historisierung Kurs
      --  2009KW47 Umstellung mv_zeit auf v_monat

      SELECT
      rl.mandant_id,
      rl.debitor_id,
      rl.kjmo,
      rl.dat_beleg,
      rl.beleg_betrag * kurs beleg_betrag,
      kurs.wrg_id,
      kurs.wrg_typ_id
     FROM dbp_view.v_ivs_ruecklastschrift rl
      INNER JOIN dbp_view.v_monat  zeit
      ON zeit.kjmo = rl.kjmo
      INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per  kurs
      ON kurs.mandant_id = rl.mandant_id
      AND max_dat BETWEEN kurs_dat_von AND kurs_dat_bis;