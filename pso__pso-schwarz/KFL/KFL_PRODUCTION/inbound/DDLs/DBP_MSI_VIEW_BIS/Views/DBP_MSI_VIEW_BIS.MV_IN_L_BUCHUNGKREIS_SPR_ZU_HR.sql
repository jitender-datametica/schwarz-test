CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_IN_L_BUCHUNGKREIS_SPR_ZU_HR
   --18.12.2012 SHoger Initial
   (
   buchungskreis_id
   ,mandant_id
   ,spr_id
   ,buchungskreis_bez

   )
   AS
      SELECT
      v01.buchungskreis_id,
      v01.mandant_id,
      v01.spr_id,
      v01.buchungskreis_bez


      FROM dbp_view.v_in_buchungskreis_spr_zu v01
      INNER JOIN dbp_view.v_in_l_buchungskreis v02
      ON v01.mandant_id=v02.mandant_id
      AND v01.buchungskreis_id = v02.buchungskreis_id

      WHERE spr_id=65 AND sako_fg=1;