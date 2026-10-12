CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_IN_EKORG
   --03.12.2012 SHoger Initial


   ( einkaufsorganisation_id
   ,mandant_id
   ,buchungskreis_id


   )
   AS
      SELECT
      einkaufsorganisation_id,
      mandant_id,
      buchungskreis_id



      FROM dbp_view.v_in_l_ekorg
      WHERE sako_fg=1;