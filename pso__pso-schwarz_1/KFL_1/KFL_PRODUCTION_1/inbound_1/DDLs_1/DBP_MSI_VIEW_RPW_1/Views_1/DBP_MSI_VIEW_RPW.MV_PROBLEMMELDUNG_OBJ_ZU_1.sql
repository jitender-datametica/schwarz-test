CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_PROBLEMMELDUNG_OBJ_ZU_1
   (
   system_id
   ,mandant_id
   ,problemmeldung_id
   ,zus_obj_id
   ,wert_dec
   ,wert_date
   ,wert_char
   )
   AS
      SELECT
      7,
      mandant_id,
      problemmeldung_id,
      zus_obj_id,
      wert_dec,
      wert_date,
      wert_char
      FROM dbp_view.v_problemmeldung_obj_zu_1
      WHERE mandant_id = 1
 ;