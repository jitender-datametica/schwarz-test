CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_IN_BANF_1
   -- 23.06.2017 ttez: SPEC0023876 Initial
   -- 30.06.2017 ttez: GROUP BY mandant_id,banf_beleg_id hinzugefügt wegen mehrfache Ausgabe
   -- 08.12.2017 twie: Filter aus Bestellungen (besch_best_det_1) übernommen, damit Werte vergleichbar sind

   (
   mandant_id
   ,banf_beleg_id
   ,dat_banf_beleg
   ,dat_lief_soll
   ,dat_freigabe
   )
   AS
      SELECT
      v01.mandant_id,
      v01.banf_beleg_id,
      MAX(v01.dat_banf_beleg),
      MAX(v01.dat_lief_soll),
      MAX(v01.dat_freigabe)
      FROM dbp_view.v_in_banf v01

      JOIN dbp_view.v_in_banf_det v02
      ON v01.mandant_id = v02.mandant_id
      AND v01.banf_beleg_id = v02.banf_beleg_id

      JOIN dbp_view.v_in_besch_best_1 v03
      ON v02.mandant_id = v03.mandant_id
      AND v02.best_beleg_id = v03.best_beleg_id

      WHERE v02.best_beleg_id > 0  -- Bestellanforderungen mir Bestellung

      AND  v03. memory_fg = 0

      --Einschränkung auf relevante Lieferanten
      AND (v03.mandant_id, v03.in_lief_id) IN
      (
      SELECT
      v11.mandant_id,
      v11.in_lief_id
      FROM dbp_view.v_in_lieferant_ekorg_zu_1 v11
      INNER JOIN dbp_view.v_in_l_ekorg_1 v12
      ON v11.mandant_id = v12.mandant_id
      AND v11.einkaufsorganisation_id = v12.einkaufsorganisation_id
      AND v12.sako_fg = 1
      AND v11.einkaeufer_grp_id IS NOT NULL
      )

      --Einschränkung auf relevante Buchungskreise
      AND (v03.mandant_id, v03.buchungskreis_id) IN
      (
      SELECT
      mandant_id,
      buchungskreis_id
      FROM dbp_view.v_in_l_buchungskreis_1
      WHERE sako_fg = 1
      )

      /* --benötigt?
      -- nur Umsätze auf relevanten Artikeln reporten, analog Artikellookup
      AND (v06.artikelart_id IN ('ZSAK','ZSDI','ZSKO', 'ZSWG')
      OR v06.in_art_nr LIKE 'W%'
      OR v06.in_art_id = -1
      )

      --gelöschte Bestellungen ausschließen
      AND v02.loesch_id = ''
      */

      GROUP BY 1,2
;