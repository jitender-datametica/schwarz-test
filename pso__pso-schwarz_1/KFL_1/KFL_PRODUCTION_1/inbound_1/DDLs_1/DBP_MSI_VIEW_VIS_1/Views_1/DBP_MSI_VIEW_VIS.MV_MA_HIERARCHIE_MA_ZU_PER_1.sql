CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MA_HIERARCHIE_MA_ZU_PER_1 as
   -- ZUORDNUNG Mitarbeiter zu MA-Hierarchie
   -- Alle Hierarchietypen (VAUS, SB)
   -- 20120430 UPDATE

   SELECT
   mandant_id, ma_hierarchie_id, ma_hierarchie_typ_id, ma_id, ma_funktion_id, dat_von, dat_bis
   FROM dbp_view.v_ma_hierarchie_ma_zu_per_1
   WHERE dat_bis = '9999-12-31';