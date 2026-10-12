CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_F_IN_LAGERBEW_KENNZAHLEN_2

      -- 09.08.2017: ttez Initial
      -- 31.08.2017 ttez: Bedingung in WHERE-Bedingung für die relevanten Artikel_2 hinzugefügt.
      -- 09.02.2018 jszc2108: SPEC0032512 added column menge and in_bewart_id=647 in the WHERE clause
      (
      mandant_id
      ,in_art_id
      ,in_bewart_id
      ,dat_buch
      ,menge_erf
      ,menge
      ,betrag_netto_wrg
      )
      AS

         SELECT
         v1.mandant_id,
         v1.in_art_id,
         v1.in_bewart_id,
         v0.dat_buch,
         v1.menge_erf,
         v1.menge,
         CASE WHEN v5.wrg_typ_id = 0
         THEN CAST(v3.betrag_pos_netto_best_wrg AS NUMBER(38,5))  * v6.umrechnungskurs
         ELSE CAST(v3.betrag_pos_netto_best_wrg AS NUMBER(38,5))
         END betrag_netto_wrg

         FROM dbp_view.v_in_lagerbew_2 v0

         JOIN dbp_view.v_in_lagerbew_det_2 v1
         ON v0.mandant_id  = v1.mandant_id AND v0.kj = v1.kj AND v0.lagerbew_beleg_id = v1.lagerbew_beleg_id

         JOIN dbp_view.v_in_werk_2 v2
         ON v1.mandant_id = v2.mandant_id AND v1.werk_id = v2.werk_id

         JOIN dbp_view.v_in_besch_best_det_2 v3
         ON v1.mandant_id = v3.mandant_id AND v1.best_beleg_id = v3.best_beleg_id AND v1.best_beleg_pos_id = v3.best_beleg_pos_id

         JOIN dbp_view.v_mandant_2 v4
         ON v1.mandant_id=v4.mandant_id
         CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v5

         JOIN dbp_view.v_kurs_2 AS v6
         ON   v6.von_wrg_id = v4.default_wrg AND v0.dat_buch BETWEEN v6.dat_von AND v6.dat_bis AND v6.kurstyp_id = 9 AND v6.nach_wrg_id = 'EUR'

         JOIN dbp_view.v_in_art_2 e
         ON e.mandant_id = v1.mandant_id AND e.in_art_id = v1.in_art_id


         WHERE v1.in_bewart_id IN ('645', '647', '101')
         AND v1.lagerbew_beleg_storno_id IS NULL
         AND v2.werk_nr IN ('DE01', 'PL02', 'CZ02', 'SK02', 'HR02', 'RO02', 'BG02')
         AND  (e.artikelart_id IN ('ZSAK','ZSDI','ZSKO', 'ZSWG')  OR SUBSTR( e.in_art_nr, 1, 1) = 'W'  OR e.in_art_id = -1);