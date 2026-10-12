CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_BERICHTS_POS_KOSTART_ZU_PER AS
-- 11.07.2013 twie: View zum Rückschreiben der Pflegeberichte, wird nicht im MSI WHC eingelesen

   SELECT
   mandant_id,
   kostenart_id,
   krk_id,
   dat_von,
   dat_bis,
   ma_ldap,
   berichts_position_invest_id,
   berichts_position_it_id

   FROM dbp_msi_v_view.v_berichts_pos_kostart_zu_per;