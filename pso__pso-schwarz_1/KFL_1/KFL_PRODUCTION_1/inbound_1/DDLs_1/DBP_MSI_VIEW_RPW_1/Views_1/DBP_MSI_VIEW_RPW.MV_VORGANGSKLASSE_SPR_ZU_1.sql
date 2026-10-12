CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_VORGANGSKLASSE_SPR_ZU_1
       (
       system_id
       ,mandant_id
       ,vorgangsklasse_id
       ,spr_id
       ,vorgangsklasse_bez
       ,vorgangsklasse_bez_kurz
       ,vorgangsklasse_bez_lang
       )
       AS
          SELECT
          7,
          mandant_id,
          vorgangsklasse_id,
          spr_id,
          vorgangsklasse_bez,
          vorgangsklasse_bez_kurz,
          vorgangsklasse_bez_lang
          FROM dbp_view.v_vorgangsklasse_spr_zu_1
          WHERE mandant_id = 1
 ;