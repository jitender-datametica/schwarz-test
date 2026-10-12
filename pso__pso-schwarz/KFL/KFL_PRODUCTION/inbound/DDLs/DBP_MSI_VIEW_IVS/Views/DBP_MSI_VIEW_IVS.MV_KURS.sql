CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_KURS as
              -- 2009-03-16
              -- FAKTVIEW Kurstabelle


              SELECT
              dat_bis,
              dat_von,
              kurstyp_id,
              nach_wrg_id,
              von_wrg_id,
              umrechnungskurs,
              TRUNC( 1/umrechnungskurs) AS kurs

              FROM dbp_view.v_kurs

              WHERE dat_bis = '9999-12-31'
              AND   kurstyp_id=3;