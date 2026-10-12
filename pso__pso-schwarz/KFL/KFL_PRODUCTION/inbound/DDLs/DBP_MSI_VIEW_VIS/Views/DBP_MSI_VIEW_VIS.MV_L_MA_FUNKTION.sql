CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_MA_FUNKTION as
   -- LOOKUP Funtion Mitarbeiter in MA-Hierarchie
   -- Enthaelt alle Eintraege fuer alle Hierarchien

   SELECT
   v01.mandant_id, v01.ma_funktion_id
   FROM dbp_view.v_l_ma_funktion v01;